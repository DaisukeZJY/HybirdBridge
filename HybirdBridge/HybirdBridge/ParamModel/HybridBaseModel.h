//
//  HybridBaseModel.h
//  HybirdBridge
//
//  Created by wanwu on 2020/7/29.
//  Copyright © 2020 wanwu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HybridBaseModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)jsonObject;

+ (instancetype)getModelByDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
