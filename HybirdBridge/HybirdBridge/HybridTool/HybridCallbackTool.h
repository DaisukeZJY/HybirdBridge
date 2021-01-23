//
//  HybridCallbackTool.h
//  HybirdBridge
//
//  Created by wanwu on 2020/7/29.
//  Copyright © 2020 wanwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKWebViewJavascriptBridge.h"
#import "WebViewJavascriptBridge.h"

NS_ASSUME_NONNULL_BEGIN
@class HybridBridgeManager;

/// 此工具为H5调用原生唯一入口工具
@interface HybridCallbackTool : NSObject

#pragma mark - 处理h5调用native方法

/// 处理h5调用native方法
/// @param data h5传递数据
/// @param hybridBridgeManager 管理类
/// @param responseCallback h5回调
+ (void)proccessHybridMethorByData:(id)data hybridBridgeManager:(HybridBridgeManager *)hybridBridgeManager callBack:(WVJBResponseCallback)responseCallback;


#pragma mark - 执行回调给H5
/// 处理错误消息，执行回调给H5
/// @param msg 错误信息
/// @param responseCallback h5回调
+ (void)callBackForParamErrorByMsg:(NSString *)msg callBack:(WVJBResponseCallback)responseCallback;

///  处理数据，执行回调给H5
/// @param data 数据
/// @param isCacheData 是否是缓存数据
/// @param responseCallback 回调
+ (void)callBackForSucceedByData:(id)data isCacheData:(BOOL)isCacheData callBack:(WVJBResponseCallback)responseCallback;


@end

NS_ASSUME_NONNULL_END
