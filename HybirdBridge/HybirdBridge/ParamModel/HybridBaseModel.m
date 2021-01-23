//
//  HybridBaseModel.m
//  HybirdBridge
//
//  Created by wanwu on 2020/7/29.
//  Copyright © 2020 wanwu. All rights reserved.
//

#import "HybridBaseModel.h"
#import "HybridDefine.h"

#define kNull [NSNull null]

@implementation HybridBaseModel

- (instancetype)initWithDictionary:(NSDictionary *)jsonObject {
    self = [super init];
    if(self) {
        if(!jsonObject || ![[jsonObject class]isSubclassOfClass:[NSDictionary class]]){
            return self;
        }
        NSMutableDictionary *dicObject = [NSMutableDictionary dictionaryWithDictionary:jsonObject];
        dicObject = [self proccessToDeleteNullValue:dicObject];
        [self setValuesForKeysWithDictionary:dicObject];
        
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    DLog(@"%@ unknown-key:%@",NSStringFromClass([self class]),key);
}

#pragma mark 过滤空值字段
- (NSMutableDictionary *)proccessToDeleteNullValue:(NSMutableDictionary *)dicParam {
    NSMutableDictionary *dicResult = [NSMutableDictionary dictionary];
    if(dicParam) {
        for (NSString *strKey in dicParam.keyEnumerator) {
            @autoreleasepool {
                if([dicParam objectForKey:strKey] != kNull && [dicParam objectForKey:strKey]){
                    id value = [dicParam objectForKey:strKey];
                    if([value isKindOfClass:[NSArray class]]){
                        NSArray *arrValue = (NSArray *)value;
                        if(arrValue.count > 0 && [arrValue objectAtIndex:0] != kNull){
                            [dicResult setObject:value forKey:strKey];
                        }
                    }
                    else{
                        [dicResult setObject:value forKey:strKey];
                    }
                }
            }
        }
    }
    return dicResult;
    
}

+ (instancetype)getModelByDic:(NSDictionary *)dic{
    if(!dic){
        return nil;
    }
    return [[[self class] alloc] initWithDictionary:dic];
}


@end
