//
//  HybirdBridgeManager.h
//  HybirdBridge
//
//  Created by wanwu on 2020/7/29.
//  Copyright © 2020 wanwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "WKWebViewJavascriptBridge.h"

#import "TGHybridNativeUIModel.h"
#import "TGHybridRequestModel.h"
#import "TGHybridPageModel.h"

#import "WKWebView+Hybrid.h"
#import "HybridDefine.h"
#import "HybridType.h"

NS_ASSUME_NONNULL_BEGIN

#define kMethorForNative    @"TGAppHandler"
#define kMethorForJs        @"TGJsHandler"


@protocol HybridBridgeEventDelagete <NSObject>

@optional

/// H5调用原生请求
/// @param methor 方法路径
/// @param eventParam 相关参数
/// @param callBackBlock 请求完毕执行回调，并返回相关数据字典
- (void)hybridBridgeEventForRequestEventWithMethor:(NSString *)methor eventParam:(TGHybridRequestEventParamModel *)eventParam callBackBlock:(void (^)(NSDictionary *callBackData, BOOL isCacheData))callBackBlock;

/// H5调用原生UI
/// @param uiType UI类型
/// @param eventParam 相关参数
/// @param callBackBlock 请求完毕执行回调，并返回相关数据字典
- (void)hybridBridgeEventForUIEventWithUIType:(TGHybridUIType)uiType eventParam:(TGHybridNativeUIEventParamModel *)eventParam callBackBlock:(void (^)(NSDictionary *callBackData, BOOL isCacheData))callBackBlock;

/// H5调用原生跳转页面
/// @param pageType 页面类型
/// @param eventParam 相关参数
/// @param callBackBlock 请求完毕执行回调，并返回相关数据字典
- (void)hybridBridgeEventForPageEventWithPageType:(TGHybridPageType)pageType eventParam:(TGHybridPageEventParamModel *)eventParam callBackBlock:(void (^)(NSDictionary *callBackData, BOOL isCacheData))callBackBlock;

@end


@interface HybridBridgeManager : NSObject

@property WKWebViewJavascriptBridge *wkBridge;

/// 初始化hybrid
+ (instancetype)hybirdBridgeForWebView:(WKWebView *)webView webViewDelegate:(id<WKNavigationDelegate>)webViewDelegate;

/// 注册原生方法名，并监听方法
/// @param handlerName 原生方法名 （kMethorForNative）
- (void)registerHandler:(NSString *)handlerName;

/// 代理
@property (nonatomic, weak) id<HybridBridgeEventDelagete> hybridBridgeEventDelagete;

/// 允许相应H5的host数组，如果不属于此数组的host将无法相应
@property (nonatomic, copy) NSArray *allowLoadUrlHostConfigs;


@property (nonatomic, weak, readonly) WKWebView *webView;

@end

@interface HybridBridgeManagerPrivate : NSObject

+ (instancetype)shareManagerPrivate;

/// 回调字典，key:方法名称， value：对应回调
@property (nonatomic, strong, readonly) NSMutableDictionary *responseCallbackDictM;

@end

NS_ASSUME_NONNULL_END
