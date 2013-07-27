//
//  BFIndexPath.m
//  PPFIphone
//
//  Created by ZYVincent on 12-8-23.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import "BFIndexPath.h"

@implementation BFIndexPath
@synthesize cloum = _cloumIndex;
@synthesize row = _rowIndex;

+ (id)pathWithRow:(NSInteger)nrow withCloum :(NSInteger)ncloum
{
    BFIndexPath *path = [[BFIndexPath alloc]init];
    path.row = nrow;
    path.cloum = ncloum;
    
    return [path autorelease];
}
@end
