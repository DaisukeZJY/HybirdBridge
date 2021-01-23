//
//  HybridType.h
//  HybirdBridge
//
//  Created by wanwu on 2020/7/29.
//  Copyright © 2020 wanwu. All rights reserved.
//

#ifndef HybridType_h
#define HybridType_h


typedef NS_ENUM(NSInteger,TGHybridType) {
    TGHybridTypeForRequest = 1, // 需要原生请求并返回数据类型
    TGHybridTypeForNaviteUI = 2, // 需要创建原生UI
    TGHybridTypeForGetParam = 3, // 返回当前webview附带参数
    TGHybridTypeForToPage = 4, // 需要跳转页面
};


typedef NS_ENUM(NSInteger,TGHybridUIType) {
    TGHybridUITypeForNavigation = 1,
    TGHybridUITypeForAlertView = 2,
    TGHybridUITypeForToast = 3,
    TGHybridUITypeForActionSheet = 4,
    TGHybridUITypeForAlertTextView = 5,
    TGHybridUITypeForTagSingleSelectView = 6,
    TGHybridUITypeForDatePickerView = 7,
    TGHybridUITypeForNavMemuView = 8,
    TGHybridUITypeForImageBrowserView = 9,
    TGHybridUITypeForProvinceSelectView = 10,
    TGHybridUITypeForSocialShareImageView = 11,
    TGHybridUITypeForSocialShareView = 12,
    TGHybridUITypeForSocialQuickShareView = 13,
    TGHybridUITypeForCouponActiveShareView = 14,
    
    TGHybridUITypeForOther = 1000, // 类型自定义从1000开始
};

typedef NS_ENUM(NSInteger,TGHybridPageType) {
    TGHybridPageTypeForWebLocalUrlPush = 1, // 新开webview跳转
    TGHybridPageTypeForWebUrlPush = 2, // webview内部链接跳转
};

#endif /* HybridType_h */
