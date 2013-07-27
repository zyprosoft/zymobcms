//
//  NSString+UrlCombine.m
//  OPinion
//
//  Created by ZYVincent on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSString+UrlCombine.h"

@implementation NSString (UrlCombine)
+ (NSString *)urlWithInterface:(NSString *)interface
{
    return [NSString stringWithFormat:@"%@%@?",MBCMS_Base_Url, interface];
}
@end
