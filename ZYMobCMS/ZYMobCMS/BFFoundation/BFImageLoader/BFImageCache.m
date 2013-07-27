//
//  BFImageCache.m
//  OPinion
//
//  Created by ZYVincent on 12-7-23.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import "BFImageCache.h"

#define imageCacheDirectory @"BFImageCacheKey"

@implementation BFImageCache

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

+ (NSString *)baseFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths objectAtIndex:0];
    
    return basePath;
}

+ (NSString *)convertUrl2CacheFilePath:(NSString *)url
{    
    //确保文件保存不重复
    NSString *fileName = [url stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    
    NSFileManager *df = [NSFileManager defaultManager];
    
    NSString *cacheDirectory = [[BFImageCache baseFilePath] stringByAppendingPathComponent:imageCacheDirectory];
    
    if (![df fileExistsAtPath:cacheDirectory]) {
        [df createDirectoryAtPath:cacheDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *filePath = [cacheDirectory stringByAppendingPathComponent:fileName];
    
    if (filePath) {
        return filePath;
    }
    return @"";
}

+ (void)saveDataToDisk:(NSData *)data withPath:(NSString *)path
{
    NSFileManager *df = [NSFileManager defaultManager];
    
    if (![df fileExistsAtPath:path]) {
        [df createFileAtPath:path contents:data attributes:nil];
    }
}

+ (UIImage *)imageForUrl:(NSString *)url
{
    NSString *cachePath = [BFImageCache convertUrl2CacheFilePath:url];
    
    NSData *data = [NSData dataWithContentsOfFile:cachePath];
    
    UIImage *image = [UIImage imageWithData:data];
    
    return image;
}

+ (void)cacheImage:(UIImage *)image withUrl:(NSString *)url
{
    NSString *cachePath = [BFImageCache convertUrl2CacheFilePath:url];
    
    NSArray *urlArray = [url componentsSeparatedByString:@"_"];
    
    NSString *fileName = [urlArray lastObject];
    
    NSArray *paths = [fileName componentsSeparatedByString:@"."];
    
    NSString *type = [paths lastObject];
    
    NSData *data = nil;
    if ([type isEqualToString:@"png"]) {
        data = UIImagePNGRepresentation(image);
    }else {
        data = UIImageJPEGRepresentation(image, 1);
    }
    
    [BFImageCache saveDataToDisk:data withPath:cachePath];
}

+ (void)removeImageWithUrl:(NSString *)url
{
    NSString *cachePath = [BFImageCache convertUrl2CacheFilePath:url];
    
    NSFileManager *df = [NSFileManager defaultManager];
    
    if([df fileExistsAtPath:cachePath]){
        
        [df removeItemAtPath:cachePath error:nil];
    }
}

+ (void)clearImageCache
{
    NSFileManager *df = [NSFileManager defaultManager];
    
    NSString *cacheDirectory = [[BFImageCache baseFilePath] stringByAppendingPathComponent:imageCacheDirectory];
    
    //清空缓存
    if ([df fileExistsAtPath:cacheDirectory]) {
        
        [df removeItemAtPath:cacheDirectory error:nil];
    }
}

@end
