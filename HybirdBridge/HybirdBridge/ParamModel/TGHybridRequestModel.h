//
//  TGHybridRequestModel.h
//  HybirdBridge
//
//  Created by wanwu on 2020/7/29.
//  Copyright © 2020 wanwu. All rights reserved.
//

#import "HybridBaseModel.h"
#import "HybridType.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGHybridRequestEventParamModel : HybridBaseModel

@property (nonatomic,copy) NSString  *url;
@property (nonatomic,copy) NSString  *methor;

@property (nonatomic,strong) NSDictionary *param;

@end

@interface TGHybridRequestModel : HybridBaseModel

@property (nonatomic,assign) TGHybridType eventType;

@property (nonatomic,strong) TGHybridRequestEventParamModel *eventParam;

@end

NS_ASSUME_NONNULL_END
