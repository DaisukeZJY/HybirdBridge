//
//  TGHybridEventTool.m
//  HybirdBridge
//
//  Created by wanwu on 2020/7/29.
//  Copyright © 2020 wanwu. All rights reserved.
//

#import "TGHybridEventTool.h"
#import "TGHybridRequestModel.h"
#import "TGHybridNativeUIModel.h"
#import "TGHybridPageModel.h"

#import "HybridCallbackTool.h"
#import "HybridBridgeManager.h"

@implementation TGHybridEventTool

#pragma mark - 处理H5调用请求部分
/// 处理H5发起事件，需要native处理请求并返回数据给H5
/// @param eventParam 参数
/// @param responseCallback 回调
/// @param hybridBridgeManager 管理对象
+ (void)proccessHybridRequestByEventParam:(TGHybridRequestEventParamModel *)eventParam callBack:(WVJBResponseCallback)responseCallback hybridBridgeManager:(HybridBridgeManager *)hybridBridgeManager{
 
    if(eventParam.methor.length <= 0){
        [HybridCallbackTool callBackForParamErrorByMsg:@"eventParam.methor not nil" callBack:responseCallback];
        return;
    }
    
    if(eventParam.param && ![[eventParam.param class] isSubclassOfClass:[NSDictionary class]]){
        [HybridCallbackTool callBackForParamErrorByMsg:@"eventParam.param not type error" callBack:responseCallback];
        return;
    }
    
    // 存储当前回调，返回给上层做数据请求，再执行回调
    HybridBridgeManagerPrivate *manager = [HybridBridgeManagerPrivate shareManagerPrivate];
    [manager.responseCallbackDictM setObject:responseCallback forKey:eventParam.methor];
    
    // 回调给用户执行请求操作
    if (hybridBridgeManager.hybridBridgeEventDelagete && [hybridBridgeManager.hybridBridgeEventDelagete respondsToSelector:@selector(hybridBridgeEventForRequestEventWithMethor:eventParam:callBackBlock:)]) {
        [hybridBridgeManager.hybridBridgeEventDelagete hybridBridgeEventForRequestEventWithMethor:eventParam.methor eventParam:eventParam callBackBlock:^(NSDictionary * _Nonnull callBackData, BOOL isCacheData) {
            
            // 执行回调返回数据给H5
            WVJBResponseCallback callBack = [manager.responseCallbackDictM objectForKey:eventParam.methor];
            [HybridCallbackTool callBackForSucceedByData:callBackData isCacheData:isCacheData callBack:callBack];
            callBack = nil;
        }];
    } else {
        [HybridCallbackTool callBackForParamErrorByMsg:@"eventParam.methor not handle error" callBack:responseCallback];
    }
    
}

#pragma mark - 处理H5调用UI部分
/// 处理H5发起事件，需要native处理相关UI操作并返回数据给H5
/// @param eventParam 参数
/// @param responseCallback 回调
/// @param hybridBridgeManager 管理对象
+ (void)proccessHybridNativeUIByEventParam:(TGHybridNativeUIEventParamModel *)eventParam callBack:(WVJBResponseCallback)responseCallback hybridBridgeManager:(HybridBridgeManager *)hybridBridgeManager{
    TGHybridUIType uiType = eventParam.methor;
    if(uiType <= 0){
        [HybridCallbackTool callBackForParamErrorByMsg:@"eventParam.methor not nil" callBack:responseCallback];
        return;
    }
    
    // 存储当前回调，返回给上层做数据请求，再执行回调
    
//    HybridBridgeManager *manager = [HybridBridgeManager shareManager];
//    [manager.responseCallbackDictM setObject:responseCallback forKey:@(eventParam.methor)];
    
    // 回调给用户执行请求操作
    if (hybridBridgeManager.hybridBridgeEventDelagete && [hybridBridgeManager.hybridBridgeEventDelagete respondsToSelector:@selector(hybridBridgeEventForUIEventWithUIType:eventParam:callBackBlock:)]) {
        [hybridBridgeManager.hybridBridgeEventDelagete hybridBridgeEventForUIEventWithUIType:uiType eventParam:eventParam callBackBlock:^(NSDictionary * _Nonnull callBackData, BOOL isCacheData) {
            
            // 执行回调返回数据给H5
//            WVJBResponseCallback callBack = [manager.responseCallbackDictM objectForKey:@(eventParam.methor)];
            [HybridCallbackTool callBackForSucceedByData:callBackData isCacheData:isCacheData callBack:responseCallback];
//            callBack = nil;
        }];
    } else {
        [HybridCallbackTool callBackForParamErrorByMsg:@"eventParam.methor not handle error" callBack:responseCallback];
    }
}


#pragma mark - 处理H5调用跳转部分
/// 处理H5发起事件，需要native处理页面跳转操作并返回数据给H5
/// @param eventParam 参数
/// @param responseCallback 回调
/// @param hybridBridgeManager 管理对象 
+ (void)proccessHybridToPageByEventParam:(TGHybridPageEventParamModel *)eventParam callBack:(WVJBResponseCallback)responseCallback hybridBridgeManager:(HybridBridgeManager *)hybridBridgeManager{
    
    TGHybridPageType pageType = eventParam.methor;
    if(pageType <= 0){
        [HybridCallbackTool callBackForParamErrorByMsg:@"eventParam.methor not nil" callBack:responseCallback];
        return;
    }
    
    if(eventParam.param.url.length <= 0){
        [HybridCallbackTool callBackForParamErrorByMsg:@"eventParam.param.url not nil" callBack:responseCallback];
        return;
    }
    
    // 存储当前回调，返回给上层做数据请求，再执行回调
//    HybridBridgeManager *manager = [HybridBridgeManager shareManager];
//    [manager.responseCallbackDictM setObject:responseCallback forKey:@(eventParam.methor)];
    
    // 回调给用户执行请求操作
    if (hybridBridgeManager.hybridBridgeEventDelagete && [hybridBridgeManager.hybridBridgeEventDelagete respondsToSelector:@selector(hybridBridgeEventForPageEventWithPageType:eventParam:callBackBlock:)]) {
        [hybridBridgeManager.hybridBridgeEventDelagete hybridBridgeEventForPageEventWithPageType:pageType eventParam:eventParam callBackBlock:^(NSDictionary * _Nonnull callBackData, BOOL isCacheData) {

            // 执行回调返回数据给H5
//            WVJBResponseCallback callBack = [manager.responseCallbackDictM objectForKey:@(eventParam.methor)];
            [HybridCallbackTool callBackForSucceedByData:callBackData isCacheData:isCacheData callBack:responseCallback];
//            callBack = nil;
        }];
    } else {
        [HybridCallbackTool callBackForParamErrorByMsg:@"eventParam.methor not handle error" callBack:responseCallback];
    }
}




@end
