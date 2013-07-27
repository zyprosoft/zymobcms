//
//  BFDataActiveMonitor.h
//  OPinion
//
//  Created by ZYVincent on 12-8-1.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BFUitils.h"

#define BFDATALOGFILE @"BFDataActiveLogFile"

@interface BFDataActiveMonitor : NSObject


+ (BOOL)writeDataActiveActionToFile:(NSString *)action;
+ (void)showAllActiveLogNow;

@end
