//
//  HybridCallbackTool.m
//  HybirdBridge
//
//  Created by wanwu on 2020/7/29.
//  Copyright © 2020 wanwu. All rights reserved.
//

#import "HybridCallbackTool.h"
#import "HybridDefine.h"
#import "HybridType.h"

#import "TGHybridRequestModel.h"
#import "TGHybridNativeUIModel.h"
#import "TGHybridPageModel.h"

#import "TGHybridEventTool.h"
#import "HybridBridgeManager.h"

@implementation HybridCallbackTool

/// 处理h5调用native方法
/// @param data h5传递数据
/// @param hybridBridgeManager 管理类
/// @param responseCallback h5回调
+ (void)proccessHybridMethorByData:(id)data hybridBridgeManager:(HybridBridgeManager *)hybridBridgeManager callBack:(WVJBResponseCallback)responseCallback {
    if(!data){
        [self callBackForParamErrorByMsg:@"data not nil" callBack:responseCallback];
        return;
    }
    
    
    TGHybridType eventType = [[data objectForKey:kParamEventType] integerValue];
    NSDictionary *dicParam = [data objectForKey:kParamEventParam];

    if(eventType <= 0 || !dicParam){
        [self callBackForParamErrorByMsg:@"eventType or eventParam not nil" callBack:responseCallback];
        return;
    }
    switch (eventType) {
        case TGHybridTypeForRequest:{
            TGHybridRequestEventParamModel *eventParam = [TGHybridRequestEventParamModel getModelByDic:dicParam];
            [TGHybridEventTool proccessHybridRequestByEventParam:eventParam callBack:responseCallback hybridBridgeManager:hybridBridgeManager];
        }
            break;
        case TGHybridTypeForNaviteUI:{
            TGHybridNativeUIEventParamModel *eventParam = [TGHybridNativeUIEventParamModel getModelByDic:dicParam];
            [TGHybridEventTool proccessHybridNativeUIByEventParam:eventParam callBack:responseCallback hybridBridgeManager:hybridBridgeManager];
        }
            break;
        case TGHybridTypeForGetParam:{
            if(!hybridBridgeManager.webView){
                return;
            }
            NSDictionary *dicParam = hybridBridgeManager.webView.customParam;
            if(!dicParam){
                dicParam = @{};
            }
            [self callBackForSucceedByData:@{kParamUrl:hybridBridgeManager.webView.URL.absoluteString,kParamParam:dicParam} isCacheData:NO callBack:responseCallback];
        }
            break;
        case TGHybridTypeForToPage:{
            TGHybridPageEventParamModel *eventParam = [TGHybridPageEventParamModel getModelByDic:dicParam];
            [TGHybridEventTool proccessHybridToPageByEventParam:eventParam callBack:responseCallback hybridBridgeManager:hybridBridgeManager];
        }
            break;
            
        default:
            break;
    }
}



/// 处理错误消息，执行回调给H5
/// @param msg 错误信息
/// @param responseCallback h5回调
+ (void)callBackForParamErrorByMsg:(NSString *)msg callBack:(WVJBResponseCallback)responseCallback{
    if(!responseCallback){
        return;
    }
    NSDictionary *dicResponse = @{kStateCode:@"ERRCODE0002",kMessage:ExistStringGet(msg),kParamData:@""};
    responseCallback(dicResponse);
}



///  处理数据，执行回调给H5
/// @param data 数据
/// @param isCacheData 是否是缓存数据
/// @param responseCallback 回调
+ (void)callBackForSucceedByData:(id)data isCacheData:(BOOL)isCacheData callBack:(WVJBResponseCallback)responseCallback{
    if(!responseCallback){
        return;
    }
    NSDictionary *dicResponse = @{kStateCode:@"ERRCODE0000",kMessage:@"",kParamCacheData:@(isCacheData),kParamData:@{}};
    if(data){
        dicResponse = @{kStateCode:@"ERRCODE0000",kMessage:@"",kParamCacheData:@(isCacheData),kParamData:data};
    }
    responseCallback(dicResponse);
}

@end
