//
//  HybridCommonTool.m
//  HybirdBridge
//
//  Created by wanwu on 2020/7/29.
//  Copyright © 2020 wanwu. All rights reserved.
//

#import "HybridCommonTool.h"

@implementation HybridCommonTool

/// 检查是否符合允许相应的host
/// @param host 当前host
/// @param allowLoadUrlHostConfigs host配置集合
+ (BOOL)checkAllowLoadUrlHost:(NSString *)host configs:(NSArray *)allowLoadUrlHostConfigs{
    for (NSString *subHost in allowLoadUrlHostConfigs.objectEnumerator) {
        if([host hasSuffix:subHost]){
            return YES;
        }
    }
    return NO;
}

@end
