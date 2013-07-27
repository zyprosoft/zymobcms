//
//  BAFNetWorkChecker.h
//  OPinion
//
//  Created by ZYVincent on 12-7-20.
//  Copyright (c) 2012年 __barfoo__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import "Reachability.h"

@interface BFNetWorkChecker : NSObject
+ (BOOL)isConnectedToNetWork;
@end
