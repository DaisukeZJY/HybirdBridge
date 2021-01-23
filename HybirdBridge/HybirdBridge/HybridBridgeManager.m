//
//  HybirdBridgeManager.m
//  HybirdBridge
//
//  Created by wanwu on 2020/7/29.
//  Copyright © 2020 wanwu. All rights reserved.
//

#import "HybridBridgeManager.h"
#import "HybridCommonTool.h"
#import "HybridCallbackTool.h"

@interface HybridBridgeManager ()

@end

@implementation HybridBridgeManager

/// 初始化hybrid
+ (instancetype)hybirdBridgeForWebView:(WKWebView *)webView webViewDelegate:(id<WKNavigationDelegate>)webViewDelegate{
    HybridBridgeManager *manager = [[HybridBridgeManager alloc] init];
    
    [WKWebViewJavascriptBridge enableLogging];
    WKWebViewJavascriptBridge *wkBridge = [WKWebViewJavascriptBridge bridgeForWebView:webView];
    [wkBridge setWebViewDelegate:webViewDelegate];
    manager.wkBridge = wkBridge;
    manager->_webView = webView;
    manager.allowLoadUrlHostConfigs = [NSArray array];
    return manager;
}

/// 注册原生方法名，并监听方法
/// @param handlerName 原生方法名 （kMethorForNative）
- (void)registerHandler:(NSString *)handlerName{
    @weakify(self)
    [self.wkBridge registerHandler:handlerName handler:^(id data, WVJBResponseCallback responseCallback) {
        @strongify(self)
        // 统一处理H5事件
        [self checkIsValidUrlToCallHybridMethorByData:data responseCallback:responseCallback];
    }];
}


/// 检查路径是否合法
/// @param data H5传递数据
/// @param responseCallback 回调给H5block
- (void)checkIsValidUrlToCallHybridMethorByData:(id)data responseCallback:(WVJBResponseCallback)responseCallback{
    // 获取当前加载路径
    NSString *urlStr = self.webView.URL.absoluteString;
    if (!urlStr) {
        return;
    }
    NSString *host = self.webView.URL.host;
    DLog(@"%@", host);
    
    // 允许加载host, 当前路径是本地文件，当前shecme
    if ([HybridCommonTool checkAllowLoadUrlHost:host configs:self.allowLoadUrlHostConfigs]
        || [urlStr hasPrefix:@"file://"]) {
        [HybridCallbackTool proccessHybridMethorByData:data hybridBridgeManager:self   callBack:responseCallback];
    } else {
        [HybridCallbackTool callBackForParamErrorByMsg:@"没有访问权限" callBack:responseCallback];
    }
    
}

@end

@implementation HybridBridgeManagerPrivate

+ (instancetype)shareManagerPrivate{
    static HybridBridgeManagerPrivate *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HybridBridgeManagerPrivate alloc] init];
        manager->_responseCallbackDictM = [NSMutableDictionary dictionary];
    });
    return manager;
}

@end
