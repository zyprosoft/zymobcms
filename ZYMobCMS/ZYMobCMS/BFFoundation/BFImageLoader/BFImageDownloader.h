//
//  BFImageDownloader.h
//  OPinion
//
//  Created by ZYVincent on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYCache.h"

@interface BFImageDownloader : NSObject
{
    NSOperationQueue *_loadQueue;
}

+ (BFImageDownloader *)shareLoader;
- (void)downloadImageWithUrl:(NSString *)url forView:(UIView *)view;
- (void)downloadImageWithUrl:(NSString *)url forView:(UIView *)view shouldResize:(BOOL)state;

//down

@end
