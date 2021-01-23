//
//  TGHybridPageModel.m
//  HybirdBridge
//
//  Created by wanwu on 2020/7/30.
//  Copyright © 2020 wanwu. All rights reserved.
//

#import "TGHybridPageModel.h"

@implementation TGHybridPageParamModel

@end

@implementation TGHybridPageEventParamModel

- (void)setValue:(id)value forKey:(NSString *)key{
    if([key isEqualToString:kParamParam]){
        _param = [TGHybridPageParamModel getModelByDic:value];
    }
    else{
        [super setValue:value forKey:key];
    }
}

@end

@implementation TGHybridPageModel

- (void)setValue:(id)value forKey:(NSString *)key{
    if([key isEqualToString:kParamEventParam]){
        _eventParam = [TGHybridPageEventParamModel getModelByDic:value];
    }
    else{
        [super setValue:value forKey:key];
    }
}

@end
