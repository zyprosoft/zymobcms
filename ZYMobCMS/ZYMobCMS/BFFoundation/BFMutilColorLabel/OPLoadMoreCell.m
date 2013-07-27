//
//  OPLoadMoreCell.m
//  OPinion
//
//  Created by ZYVincent on 12-7-25.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import "OPLoadMoreCell.h"

@implementation OPLoadMoreCell
@synthesize indicatorView;
@synthesize loadLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //title label
        self.loadLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,768,70)];
        self.loadLabel.backgroundColor = [UIColor clearColor];
        self.loadLabel.textAlignment = UITextAlignmentCenter;
        self.loadLabel.font = [UIFont systemFontOfSize:25];
        [self.loadLabel setTextColor:[UIColor colorWithRed:54/255.0 green:100/255.0 blue:139/255.0 alpha:1.0]];
        self.loadLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        
        [self addSubview:self.loadLabel];
        [self.loadLabel release];
        
        //active
        self.indicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(232, 16, 37, 37)];
        self.indicatorView.hidesWhenStopped = YES;
        [self addSubview:self.indicatorView];
        [self.indicatorView release];
        
    }
    return self;
}

- (void)dealloc
{
    self.loadLabel = nil;
    self.indicatorView = nil;
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)stopLoading
{
    [self.indicatorView stopAnimating];
    self.indicatorView.hidden = YES;
    self.loadLabel.text = @"加载更多...";
}
- (void)startLoading
{
    self.indicatorView.hidden = NO;
    [self.indicatorView startAnimating];
    
    self.loadLabel.text = @"正在加载...";
}

@end
