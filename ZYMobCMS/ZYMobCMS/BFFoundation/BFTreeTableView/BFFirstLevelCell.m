//
//  BFFirstLevelCell.m
//  OPinion
//
//  Created by ZYVincent on 12-7-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BFFirstLevelCell.h"

@implementation BFFirstLevelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        testLabel = [[UILabel alloc]init];
        testLabel.frame = CGRectMake(5, 0,200,44);
        testLabel.text = @"First Level";
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

- (void)setLabelContent:(NSString *)content
{
    testLabel.text = content;
}

@end
