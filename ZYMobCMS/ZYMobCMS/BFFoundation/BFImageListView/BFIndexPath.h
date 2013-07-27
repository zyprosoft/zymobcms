//
//  BFIndexPath.h
//  PPFIphone
//
//  Created by ZYVincent on 12-8-23.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFIndexPath : NSObject
{
    NSInteger _rowIndex;
    NSInteger _cloumIndex;
}
@property (nonatomic)NSInteger row;
@property (nonatomic)NSInteger cloum;

+ (id)pathWithRow:(NSInteger)nrow withCloum:(NSInteger)ncloum;
@end
