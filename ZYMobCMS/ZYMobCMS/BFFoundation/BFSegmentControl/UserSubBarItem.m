//
//  UserSubBarItem.m
//  BarfooBlog
//
//  Created by ZYVincent on 12-11-26.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import "UserSubBarItem.h"

@implementation UserSubBarItem
@synthesize delegate;
@synthesize titleLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, frame.size.width,frame.size.height)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:titleLabel];
        [titleLabel release];
        
        //添加手势
        UITapGestureRecognizer *tapR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnSelf)];
        [self addGestureRecognizer:tapR];
        [tapR release];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)switchToNormal
{
    titleLabel.textColor = [UIColor blackColor];
}

- (void)switchToSelected
{
    titleLabel.textColor = [UIColor whiteColor];
}

- (void)tapOnSelf
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapOnSubBaritem:)]) {
        [self.delegate didTapOnSubBaritem:self];
    }
}

@end
