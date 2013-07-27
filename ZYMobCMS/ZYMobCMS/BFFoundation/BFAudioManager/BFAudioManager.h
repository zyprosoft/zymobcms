//
//  BFAudioManager.h
//  PPFIphone
//
//  Created by ZYVincent on 12-8-24.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleAudioEngine.h"

@interface BFAudioManager : NSObject

+ (BFAudioManager*)shareManager;


- (void)playEffectSourceInBundle:(NSString *)effectName;
- (void)playBackgroundMusicInBundle:(NSString *)musicName;
- (void)stopPlayBackgroundMusic;



@end
