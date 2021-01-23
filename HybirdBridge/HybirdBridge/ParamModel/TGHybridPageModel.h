//
//  TGHybridPageModel.h
//  HybirdBridge
//
//  Created by wanwu on 2020/7/30.
//  Copyright © 2020 wanwu. All rights reserved.
//

#import "HybridBaseModel.h"
#import "HybridDefine.h"
#import "HybridType.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGHybridPageParamModel : HybridBaseModel

@property (nonatomic,copy) NSString *url;//路径
@property (nonatomic,strong) NSDictionary *param;//页面参数

@end

@interface TGHybridPageEventParamModel : HybridBaseModel

@property (nonatomic,assign) TGHybridPageType methor;//1.本地html页面跳转 2.网络链接跳转
@property (nonatomic,strong) TGHybridPageParamModel *param;

@end

@interface TGHybridPageModel : HybridBaseModel

@property (nonatomic,assign) TGHybridType eventType;

@property (nonatomic,strong) TGHybridPageEventParamModel *eventParam;

@end


NS_ASSUME_NONNULL_END
