//
//  OPFileCache.h
//  OPinion
//
//  Created by ZYVincent on 12-8-7.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OPFileCache : NSObject


+ (void)cacheWithDict:(NSDictionary *)dict withKeyName:(NSString *)keyName;
+ (void)cacheWithArray:(NSArray *)array withKeyName:(NSString *)keyName;
+ (void)cacheWithData:(NSData *)data withKeyName:(NSString *)keyName;

+ (NSData *)returnCacheDataWithKeyName:(NSString *)keyName;
+ (NSArray *)returnArrayWithKeyName:(NSString *)keyName;
+ (NSDictionary *)returnDictWithKeyName:(NSString *)keyName;

@end
