//
//  AyncImageCell.m
//  OPinion
//
//  Created by ZYVincent on 12-7-23.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import "AyncImageCell.h"

@implementation AyncImageCell
@synthesize headImgView;
@synthesize nameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle]loadNibNamed:@"AyncImageCell" owner:self options:nil]objectAtIndex:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [headImgView release];
    [nameLabel release];
    [super dealloc];
}
@end
