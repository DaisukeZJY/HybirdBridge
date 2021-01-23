//
//  WKWebView+Hybrid.m
//  HybirdBridge
//
//  Created by wanwu on 2020/7/30.
//  Copyright © 2020 wanwu. All rights reserved.
//

#import "WKWebView+Hybrid.h"
#import <objc/runtime.h>

static NSString *customParamKey = @"customParamKey";

@implementation WKWebView (Hybrid)

- (void)setCustomParam:(NSDictionary *)customParam{
    objc_setAssociatedObject(self, &customParamKey, customParam, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSDictionary *)customParam{
    return objc_getAssociatedObject(self, &customParamKey);
}

@end
