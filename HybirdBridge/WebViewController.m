//
//  WebViewController.m
//  HybirdBridge
//
//  Created by wanwu on 2020/7/30.
//  Copyright © 2020 wanwu. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import "HybridBridgeManager.h"

@interface WebViewController ()<WKNavigationDelegate,WKUIDelegate, HybridBridgeEventDelagete>
@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, copy) NSString *strUrl;

@property (nonatomic, copy) NSString *currentPageUrl;
@property (nonatomic, copy) NSDictionary *currentParam;

@property (nonatomic, strong) HybridBridgeManager *manager;

@end

@implementation WebViewController

- (instancetype)initWithUrl:(NSString *)strUrl{
    self = [super init];
    if (self) {
        _strUrl = strUrl;
    }
    return self;
}
    
- (instancetype)initWithPageUrl:(NSString *)pageUrl param:(NSDictionary *)param{
    self = [super init];
    if (self) {
        _currentPageUrl = pageUrl;
        _currentParam = param;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WKWebView *webView = [[WKWebView alloc] init];
    webView.UIDelegate = self;
    webView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:webView];
    _webView = webView;
    
    _webView.customParam = @{@"附带参数":@"附带参数"};
    HybridBridgeManager *manager = [HybridBridgeManager hybirdBridgeForWebView:_webView webViewDelegate:self];
    manager.hybridBridgeEventDelagete = self;
    [manager registerHandler:@"TGAppHandler"];
    _manager = manager;
    

    if (_strUrl) {
        [self loadData];
    } else {
        [self loadLocalPage];
    }
    
}

- (void)loadData{
    NSURL* url = [NSURL URLWithString:_strUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
    [self.webView loadRequest:request];
}

- (void)loadLocalPage{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    path = [path stringByAppendingPathComponent:@"Hybrid"];
    NSString* htmlPath = [path stringByAppendingPathComponent:_currentPageUrl];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    if(appHtml.length > 0){
        // 如果有这个<hybrid_common_file/>标识，替换成相对应引导头文件内容
        if([appHtml containsString:kParamHybridCommonFile]){
            NSString* htmlPath = [path stringByAppendingPathComponent:@"/common/TGHybridCommonFile.txt"];
            NSString* commonHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
            if(commonHtml.length > 0){
                appHtml = [appHtml stringByReplacingOccurrencesOfString:kParamHybridCommonFile withString:commonHtml];
            }
        }

        NSURL *baseURL = [NSURL fileURLWithPath:[path stringByAppendingPathComponent:@"common"]];
        [self.webView loadHTMLString:appHtml baseURL:baseURL];
    } else{
        DLog(@"无法找到文件--->%@",_currentPageUrl);
    }
}

#pragma mark - HybridBridgeEventDelagete

/// H5调用原生请求
/// @param methor 方法路径
/// @param eventParam 相关参数
/// @param callBackBlock 请求完毕执行回调，并返回相关数据字典
- (void)hybridBridgeEventForRequestEventWithMethor:(NSString *)methor eventParam:(TGHybridRequestEventParamModel *)eventParam callBackBlock:(void (^)(NSDictionary *callBackData, BOOL isCacheData))callBackBlock{
    /**
     {
       "callbackId" : "cb_2_1596099264618",
       "handlerName" : "TGAppHandler",
       "data" : {
         "eventType" : "1",
         "eventParam" : {
           "param" : {
             "limit" : 20,
             "min" : "",
             "max" : "",
             "start" : 0
           },
           "methor" : "\/Api\/GetNoteList"
         }
       }
     }
     */
    if ([eventParam.methor isEqualToString:@"/Api/GetNoteList"]) {
        // 获取我的笔记部分
        NSError* parseError =nil;
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:eventParam.param options:0 error:&parseError];
        NSString *paramStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString *path = [NSString stringWithFormat:@"http://www.xxx.com%@?%@", eventParam.methor, paramStr];
        NSURL *url = [NSURL URLWithString:path];
        //表示客户端发起的网络请求内容
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(error == nil) {
                //6.解析服务器返回的数据
                NSLog(@"11111");
                //说明：（此处返回的数据是JSON格式的，因此使用NSJSONSerialization进行反序列化处理）
                
                NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                // 回调数据
                callBackBlock(@{}, NO);
            }
        }];
        
        [dataTask resume];
    }
    
    // 执行回调
//    callBackBlock(@{}, NO);
}

/// H5调用原生UI
/// @param uiType UI类型
/// @param eventParam 相关参数
/// @param callBackBlock 请求完毕执行回调，并返回相关数据字典
- (void)hybridBridgeEventForUIEventWithUIType:(TGHybridUIType)uiType eventParam:(TGHybridNativeUIEventParamModel *)eventParam callBackBlock:(void (^)(NSDictionary *callBackData, BOOL isCacheData))callBackBlock{
    /**
     TGHybridUITypeForNavigation = 1,
     TGHybridUITypeForAlertView = 2,
     TGHybridUITypeForToast = 3,
     TGHybridUITypeForActionSheet = 4,
     TGHybridUITypeForAlertTextView = 5,
     TGHybridUITypeForTagSingleSelectView = 6,
     TGHybridUITypeForDatePickerView = 7,
     TGHybridUITypeForNavMemuView = 8,
     TGHybridUITypeForImageBrowserView = 9,
     TGHybridUITypeForProvinceSelectView = 10,
     TGHybridUITypeForSocialShareImageView = 11,
     TGHybridUITypeForSocialShareView = 12,
     TGHybridUITypeForSocialQuickShareView = 13,
     TGHybridUITypeForCouponActiveShareView = 14,
     
     TGHybridUITypeForOther = 1000, // 类型自定义从1000开始
     
     */
    switch (uiType) {
        case TGHybridUITypeForNavigation:
        {
            /**
             {
             "callbackId" : "cb_3_1596097462361",
             "handlerName" : "TGAppHandler",
             "data" : {
               "eventType" : "2",
               "eventParam" : {
                 "param" : {
                   "leftButton" : {
                     "type" : "2",
                     "image" : "back"
                   },
                   "rightButton" : {
                     "type" : "1",
                     "content" : "右边按钮"
                   },
                   "title" : "导航栏标题"
                 },
                 "methor" : "1"
               }
             }
             */
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:eventParam.param.rightButton.content style:UIBarButtonItemStyleDone target:self action:@selector(clickNavRightItem:)];
            self.navigationItem.rightBarButtonItem = rightItem;
            self.title = eventParam.param.title;
            
        }
            break;
        case TGHybridUITypeForAlertView: {
            /**
             {
               "callbackId" : "cb_1_1596095634062",
               "handlerName" : "TGAppHandler",
               "data" : {
                 "eventType" : "2",
                 "eventParam" : {
                   "param" : {
                     "rightButton" : {
                       "content" : "右边"
                     },
                     "title" : "标题",
                     "content" : "弹出框test",
                     "leftButton" : {
                       "content" : "左边"
                     }
                   },
                   "methor" : "2"
                 }
               }
             }
             */
            // 弹窗
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:eventParam.param.title message:eventParam.param.content preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:eventParam.param.leftButton.content style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:eventParam.param.rightButton.content style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // 点击了右边按钮，并发送相关数据
                // 执行回调
                callBackBlock(@{@"key": @"value"}, NO);
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
    
    
    
    
    
}

/// H5调用原生跳转页面
/// @param pageType 页面类型
/// @param eventParam 相关参数
/// @param callBackBlock 请求完毕执行回调，并返回相关数据字典
- (void)hybridBridgeEventForPageEventWithPageType:(TGHybridPageType)pageType eventParam:(TGHybridPageEventParamModel *)eventParam callBackBlock:(void (^)(NSDictionary *callBackData, BOOL isCacheData))callBackBlock{

    /**
     {
       "callbackId" : "cb_1_1596101088617",
       "handlerName" : "TGAppHandler",
       "data" : {
         "eventType" : "4",
         "eventParam" : {
           "param" : {
             "url" : "\/user\/ExampleApp.html"
           },
           "methor" : 1
         }
       }
     }
     */
    UIViewController *pushView = nil;
    switch (pageType) {
        case TGHybridPageTypeForWebLocalUrlPush:{
            pushView = [[WebViewController alloc] initWithPageUrl:eventParam.param.url param:eventParam.param.param];
        }
            break;
        case TGHybridPageTypeForWebUrlPush:{
            if(![self checkUrlIsInAppPush:eventParam.param.url currentView:self]){
                pushView = [[WebViewController alloc] initWithUrl:eventParam.param.url];
            }
        }
            break;
            
        default:
            break;
    }
    if(pushView){
        [self.navigationController pushViewController:pushView animated:YES];
    }
    // 执行回调
//    callBackBlock(@{}, NO);
}


- (void)clickNavRightItem:(UIBarButtonItem *)item{
    
}


#pragma mark - 其他
//检测url是否是应用内自动跳转的链接
- (BOOL)checkUrlIsInAppPush:(NSString *)url currentView:(UIViewController *)currentView {
    BOOL isInAppPush = NO;
//    if (url.length > 0){
//        NSDictionary *dicParam = [TGHttpTool getUrlParamByStrUrl:url];
//        isInAppPush = [TGHttpTool checkIsInAppPushByUrl:url dicParam:dicParam currentView:currentView];
//    }
//    if(!isInAppPush){
//        isInAppPush = [TGHttpTool checkIsServiceIntroduceByUrl:url currentView:currentView];
//    }
    return isInAppPush;
}

@end
