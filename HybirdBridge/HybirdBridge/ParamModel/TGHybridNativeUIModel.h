//
//  TGHybridNativeUIModel.h
//  HybirdBridge
//
//  Created by wanwu on 2020/7/29.
//  Copyright © 2020 wanwu. All rights reserved.
//

#import "HybridBaseModel.h"
#import "HybridType.h"
#import "HybridDefine.h"

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface TGHybridNativeUIButtonTypeModel : HybridBaseModel

@property (nonatomic,assign) BOOL isLeft;
@property (nonatomic,assign) NSInteger type;

@property (nonatomic,copy) NSString  *content;
@property (nonatomic,copy) NSString  *image;
@property (nonatomic,copy) NSString  *url;

@end

@interface TGHybridNativeUIParamModel : HybridBaseModel

@property (nonatomic,assign) NSInteger type;
@property (nonatomic,assign) NSInteger limitWord;
@property (nonatomic,assign) NSInteger currentSelectIndex;
@property (nonatomic,assign) NSInteger shareType;//分享类型（1.图片 2.链接）
@property (nonatomic,assign) NSInteger shareFunction;//分享功能类型（1.普通分享 2.向上级推荐分享）

@property (nonatomic,assign) CGFloat price;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *placeholder;
@property (nonatomic,copy) NSString *rightButtonTitle;
@property (nonatomic,copy) NSString *selectButtonName;
@property (nonatomic,copy) NSString *shareUrl;
@property (nonatomic,copy) NSString *shareImageUrl;
@property (nonatomic,copy) NSString *viewTitle;//分享控件的标题

@property (nonatomic,strong) NSArray *buttons;
@property (nonatomic,strong) NSArray *imageUrls;

@property (nonatomic,strong) TGHybridNativeUIButtonTypeModel *leftButton;
@property (nonatomic,strong) TGHybridNativeUIButtonTypeModel *rightButton;

@end

@interface TGHybridNativeUIEventParamModel : HybridBaseModel

@property (nonatomic,assign) TGHybridUIType methor;

@property (nonatomic,strong) TGHybridNativeUIParamModel *param;

@end

@interface TGHybridNativeUIModel : HybridBaseModel

@property (nonatomic,assign) TGHybridType eventType;

@property (nonatomic,strong) TGHybridNativeUIEventParamModel *eventParam;

@end

NS_ASSUME_NONNULL_END
