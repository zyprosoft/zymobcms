//
//  BFElement.m
//  OPinion
//
//  Created by ZYVincent on 12-7-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BFElement.h"

@implementation BFElement
@synthesize content;
@synthesize levelFlag;
@synthesize subCount;

- (id)initWithContent:(NSString *)newContent withLevelFlag:(BFElementLevel)level withSubCount:(NSInteger)count
{
    if (self = [super init]) {
        self.content = newContent;
        self.levelFlag = level;
        
        self.subCount = count;
        
        
    }
    return self;
}

- (void)dealloc{
    [content release];
    [super dealloc];
}
@end
