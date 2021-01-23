//
//  TGHybridNativeUIModel.m
//  HybirdBridge
//
//  Created by wanwu on 2020/7/29.
//  Copyright © 2020 wanwu. All rights reserved.
//

#import "TGHybridNativeUIModel.h"


@implementation TGHybridNativeUIButtonTypeModel


@end

@implementation TGHybridNativeUIParamModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if([key isEqualToString:kParamLeftButton]) {
        _leftButton = [[TGHybridNativeUIButtonTypeModel alloc] initWithDictionary: value];
        _leftButton.isLeft = YES;
    } else if([key isEqualToString:kParamRightButton]) {
        _rightButton = [[TGHybridNativeUIButtonTypeModel alloc] initWithDictionary:value];
    } else {
        [super setValue:value forKey:key];
    }
}

@end

@implementation TGHybridNativeUIEventParamModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if([key isEqualToString:kParamParam]) {
        _param = [[TGHybridNativeUIParamModel alloc] initWithDictionary:value];
    } else {
        [super setValue:value forKey:key];
    }
}

@end

@implementation TGHybridNativeUIModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if([key isEqualToString:kParamEventParam]) {
        _eventParam = [[TGHybridNativeUIEventParamModel alloc] initWithDictionary:value];
    } else {
        [super setValue:value forKey:key];
    }
}

@end
