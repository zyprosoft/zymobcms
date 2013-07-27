//
//  BFBaseTableCell.m
//  OPinion
//
//  Created by ZYVincent on 12-7-25.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import "BFBaseTableCell.h"

@interface ContentView : UIView
@end

@implementation ContentView

- (void)drawRect:(CGRect)r
{
	[(BFBaseTableCell*)[self superview] drawContentView:r];
}

@end
@implementation BFBaseTableCell
@synthesize backView;
@synthesize contentView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        backView = [[UIView alloc] initWithFrame:CGRectZero];
        backView.opaque = YES;
        [self addSubview:backView];
        
		contentView = [[ContentView alloc] initWithFrame:CGRectZero];
		contentView.opaque = YES;
		[self addSubview:contentView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
	[backView removeFromSuperview];
	[backView release];
    
	[contentView removeFromSuperview];
	[contentView release];
	[super dealloc];
}

- (void)setFrame:(CGRect)f {
	[super setFrame:f];
	CGRect b = [self bounds];
	b.size.height -= 1; // leave room for the seperator line
	
    [backView setFrame:b];
	[contentView setFrame:b];
    [self setNeedsDisplay];
}

- (void)setNeedsDisplay {
	[super setNeedsDisplay];
    [backView setNeedsDisplay];
	[contentView setNeedsDisplay];
}

- (void)drawContentView:(CGRect)r {
	// subclasses should implement this
}

@end
