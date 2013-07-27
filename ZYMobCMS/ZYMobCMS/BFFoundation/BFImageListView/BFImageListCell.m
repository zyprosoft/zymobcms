//
//  BFImageListCell.m
//  PPFIphone
//
//  Created by ZYVincent on 12-8-23.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import "BFImageListCell.h"

@implementation BFImageListCell
@synthesize reuseIdentifier;
@synthesize indexPath;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithIdentifier:(NSString *)identifier
{
    if (self = [super init]) {
        self.reuseIdentifier = identifier;
    }
    return self;
}

- (void)dealloc
{
    self.indexPath = nil;
    self.reuseIdentifier = nil;
    [super dealloc];
}

//*********** custom 这个View 并且 启用 drawRect 来绘制自定义内容 ！！！


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
