//
//  BFVarHeightCell.m
//  OPinion
//
//  Created by ZYVincent on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BFVarHeightCell.h"

@implementation BFVarHeightCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        testLabel = [[UILabel alloc]init];
        testLabel.frame = CGRectZero;
        testLabel.font = [UIFont systemFontOfSize:13];
        testLabel.numberOfLines = 0;
        [self.contentView addSubview:testLabel];
        [testLabel release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellWithContent:(NSString *)content
{    
    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(self.frame.size.width,999999) lineBreakMode:UILineBreakModeTailTruncation];
    
    CGRect labelRect = CGRectMake(5,5,320,size.height);
    
    testLabel.text = content;
    [testLabel setFrame:labelRect];
    
    [self setNeedsDisplay];
    
}

+ (CGFloat)heightWithContent:(NSString *)content inTableView:(UITableView *)tView
{

    CGFloat width = tView.frame.size.width - 10;
    
    CGSize newSize = [content sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(width, 99999) lineBreakMode:UILineBreakModeTailTruncation];
    
    return newSize.height + 10;
}


@end
