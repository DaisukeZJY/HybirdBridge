//
//  WebViewController.h
//  HybirdBridge
//
//  Created by wanwu on 2020/7/30.
//  Copyright © 2020 wanwu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : UIViewController

- (instancetype)initWithUrl:(NSString *)strUrl;
    
- (instancetype)initWithPageUrl:(NSString *)pageUrl param:(NSDictionary *)param;

@end

NS_ASSUME_NONNULL_END
