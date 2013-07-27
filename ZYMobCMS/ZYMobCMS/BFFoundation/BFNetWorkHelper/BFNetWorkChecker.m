//
//  BAFNetWorkChecker.m
//  OPinion
//
//  Created by ZYVincent on 12-7-20.
//  Copyright (c) 2012年 __barfoo__. All rights reserved.
//

#import "BFNetWorkChecker.h"

@implementation BFNetWorkChecker
+ (BOOL)isConnectedToNetWork
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    
    //增加额外判断
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    if (!reach) {
        return NO;
    }
    
    return (isReachable && !needsConnection) ? YES : NO;
}
@end
