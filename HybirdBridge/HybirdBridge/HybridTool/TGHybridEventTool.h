//
//  TGHybridEventTool.h
//  HybirdBridge
//
//  Created by wanwu on 2020/7/29.
//  Copyright © 2020 wanwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebViewJavascriptBridge.h"

NS_ASSUME_NONNULL_BEGIN
@class TGHybridRequestEventParamModel, TGHybridNativeUIEventParamModel,TGHybridPageEventParamModel,HybridBridgeManager;

/// 处理H5发起事件，需要native处理请求方法并返回数据给H5
@interface TGHybridEventTool : NSObject

#pragma mark - 处理H5调用请求部分
/// 处理H5发起事件，需要native处理请求并返回数据给H5
/// @param eventParam 参数
/// @param responseCallback 回调
/// @param hybridBridgeManager 管理对象
+ (void)proccessHybridRequestByEventParam:(TGHybridRequestEventParamModel *)eventParam callBack:(WVJBResponseCallback)responseCallback hybridBridgeManager:(HybridBridgeManager *)hybridBridgeManager;

#pragma mark - 处理H5调用UI部分
/// 处理H5发起事件，需要native处理相关UI操作并返回数据给H5
/// @param eventParam 参数
/// @param responseCallback 回调
/// @param hybridBridgeManager 管理对象
+ (void)proccessHybridNativeUIByEventParam:(TGHybridNativeUIEventParamModel *)eventParam callBack:(WVJBResponseCallback)responseCallback hybridBridgeManager:(HybridBridgeManager *)hybridBridgeManager;

#pragma mark - 处理H5调用跳转部分
/// 处理H5发起事件，需要native处理页面跳转操作并返回数据给H5
/// @param eventParam 参数
/// @param responseCallback 回调
/// @param hybridBridgeManager 管理对象
+ (void)proccessHybridToPageByEventParam:(TGHybridPageEventParamModel *)eventParam callBack:(WVJBResponseCallback)responseCallback hybridBridgeManager:(HybridBridgeManager *)hybridBridgeManager;

@end

NS_ASSUME_NONNULL_END
