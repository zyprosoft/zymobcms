//
//  OPFileCache.m
//  OPinion
//
//  Created by ZYVincent on 12-8-7.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import "OPFileCache.h"

#define CachePlistName @"OpinionFileCache"

//static OPFileCache *_instance = nil;
@implementation OPFileCache


+ (NSString *)baseFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:CachePlistName];
    
    return basePath;
}

+ (void)saveDataToDisk:(NSData *)data withPath:(NSString *)path
{
    if (data == nil) {
        return;
    }
    
    NSFileManager *df = [NSFileManager defaultManager];
    
    if (![df fileExistsAtPath:path]) {
        [df createFileAtPath:path contents:data attributes:nil];
    }
    [data writeToFile:path atomically:YES];
}

+ (NSString *)createCacheFilePathWithKeyName:(NSString *)keyName
{
    NSString *filePath = [[self baseFilePath]stringByAppendingPathComponent:keyName];
    return filePath;
}

+ (void)cacheWithData:(NSData *)data withKeyName:(NSString *)keyName
{
    [self saveDataToDisk:data withPath:[self createCacheFilePathWithKeyName:keyName]];
}

+ (void)cacheWithArray:(NSArray *)array withKeyName:(NSString *)keyName
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    
    [self cacheWithData:data withKeyName:keyName];
}

+ (void)cacheWithDict:(NSDictionary *)dict withKeyName:(NSString *)keyName
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    
    [self cacheWithData:data withKeyName:keyName];
}


+ (NSArray *)returnArrayWithKeyName:(NSString *)keyName
{    
   return [NSArray arrayWithContentsOfFile:[self createCacheFilePathWithKeyName:keyName]];
}

+ (NSDictionary *)returnDictWithKeyName:(NSString *)keyName
{
    return [NSDictionary dictionaryWithContentsOfFile:[self createCacheFilePathWithKeyName:keyName]];

}

+ (NSData *)returnCacheDataWithKeyName:(NSString *)keyName
{
    return [NSData dataWithContentsOfFile:[self createCacheFilePathWithKeyName:keyName]];
}

@end
