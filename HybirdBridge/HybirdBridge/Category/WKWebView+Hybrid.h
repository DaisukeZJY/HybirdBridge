//
//  WKWebView+Hybrid.h
//  HybirdBridge
//
//  Created by wanwu on 2020/7/30.
//  Copyright © 2020 wanwu. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (Hybrid)

/// 网页附带自定义参数，可做记录使用，亦可作为回调给H5使用
@property (nonatomic, copy) NSDictionary *customParam;

@end

NS_ASSUME_NONNULL_END
