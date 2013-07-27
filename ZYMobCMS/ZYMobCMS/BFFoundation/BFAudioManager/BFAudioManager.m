//
//  BFAudioManager.m
//  PPFIphone
//
//  Created by ZYVincent on 12-8-24.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import "BFAudioManager.h"

static BFAudioManager *_shareInstance = nil;

@implementation BFAudioManager


// Init
+ (BFAudioManager *) shareManager
{
	@synchronized(self)     {
		if (!_shareInstance)
			_shareInstance = [[BFAudioManager alloc] init];
	}
	return _shareInstance;
}

+ (id) alloc
{
	@synchronized(self)     {
		NSAssert(_shareInstance == nil, @"Attempted to allocate a second instance of a singleton.");
		return [super alloc];
	}
	return nil;
}


- (NSString *)bundlePathForFileName:(NSString *)fileName
{
    NSArray *nameArray = [fileName componentsSeparatedByString:@"."];
    
    NSString *name = [nameArray objectAtIndex:0];
    NSString *type = [nameArray objectAtIndex:1];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:type]; 
    
    return path;
}
- (void)playEffectSourceInBundle:(NSString *)effectName
{
    [[SimpleAudioEngine sharedEngine]playEffect:[self bundlePathForFileName:effectName]];
}

- (void)playBackgroundMusicInBundle:(NSString *)musicName
{
    [[SimpleAudioEngine sharedEngine]playBackgroundMusic:[self bundlePathForFileName:musicName]];
}

- (void)stopPlayBackgroundMusic
{
    [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
}

@end
