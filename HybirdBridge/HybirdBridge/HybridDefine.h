//
//  HybridDefine.h
//  HybirdBridge
//
//  Created by wanwu on 2020/7/29.
//  Copyright © 2020 wanwu. All rights reserved.
//

#ifndef HybridDefine_h
#define HybridDefine_h

#define kParamHybridCommonFile      @"<hybrid_common_file/>"

#define kParamEventType             @"eventType"
#define kParamEventParam            @"eventParam"
#define kParamParam                 @"param"
#define kParamLeftButton            @"leftButton"
#define kParamRightButton           @"rightButton"
#define kParamButtonClick           @"buttonClick"
#define kParamIsRightButtonClick    @"isRightButtonClick"

#define kParamNavigationClick       @"navigationClick"
#define kParamAlertViewClick        @"alertViewClick"
#define kParamActionSheetClick      @"actionSheetClick"

#define kParamisFromThirdBack       @"is_from_third_back"

#define kStateCode                  @"state_code"
#define kMessage                    @"message"
#define kBody                       @"body"
#define kParamData                  @"data"


#define kParamCacheData             @"isCacheData"
#define kParamUrl                   @"url"

//打印
#ifdef  DEBUG   //DeBug版本宏
#define DLog(fmt, ...)                  NSLog((@"[Method:%s]-[Line %d]->" fmt),__PRETTY_FUNCTION__, __LINE__,##__VA_ARGS__)
#define DLogClass(_ClassObject)         DLog(@"Class:%@",NSStringFromClass([_ClassObject class]))

#else           //Release版本宏（发布版本）
#define DLog(fmt, ...)
#define DLogClass(_ClassObject)
#endif


#define ExistActionDo(a,b) if((a)){b;}
#define ExistStringGet(str)  ([[(str) class] isSubclassOfClass:[NSString class]] && (str).length > 0)?(str):@""



#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

#endif /* HybridDefine_h */
