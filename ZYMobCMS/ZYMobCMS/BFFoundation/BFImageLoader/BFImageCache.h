//
//  BFImageCache.h
//  OPinion
//
//  Created by ZYVincent on 12-7-23.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFImageCache : NSObject

+ (NSString *)baseFilePath;
+ (NSString *)convertUrl2CacheFilePath:(NSString *)url;
+ (void)saveDataToDisk:(NSData *)data withPath:(NSString *)path;

+ (UIImage *)imageForUrl:(NSString *)url;
+ (void)cacheImage:(UIImage *)image withUrl:(NSString *)url;
+ (void)removeImageWithUrl:(NSString *)url;

+ (void)clearImageCache;

@end
