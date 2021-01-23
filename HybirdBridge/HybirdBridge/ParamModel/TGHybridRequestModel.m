//
//  TGHybridRequestModel.m
//  HybirdBridge
//
//  Created by wanwu on 2020/7/29.
//  Copyright © 2020 wanwu. All rights reserved.
//

#import "TGHybridRequestModel.h"
#import "HybridDefine.h"

@implementation TGHybridRequestEventParamModel

@end

@implementation TGHybridRequestModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if([key isEqualToString:kParamEventParam]) {
        _eventParam = [[TGHybridRequestEventParamModel alloc] initWithDictionary:value];
    } else {
        [super setValue:value forKey:key];
    }
}

@end
