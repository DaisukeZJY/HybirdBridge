//
//  HybridCommonTool.h
//  HybirdBridge
//
//  Created by wanwu on 2020/7/29.
//  Copyright © 2020 wanwu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/// 私有方法工具
@interface HybridCommonTool : NSObject

/// 检查是否符合允许相应的host
/// @param host 当前host
/// @param allowLoadUrlHostConfigs host配置集合
+ (BOOL)checkAllowLoadUrlHost:(NSString *)host configs:(NSArray *)allowLoadUrlHostConfigs;

@end

NS_ASSUME_NONNULL_END
