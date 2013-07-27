//
//  AsyncImageCell.m
//  OPinion
//
//  Created by ZYVincent on 12-7-24.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import "AsyncImageCell.h"

@implementation AsyncImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initwithHeadImgUrl:(NSString *)url reuseIdentify:(NSString *)identify
{
    [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    if (self) {
        
        headImgView = [[BFImageView alloc]initWithImageUrl:url];
        headImgView.frame = CGRectMake(10, 5, 55, 55);
        headImgView.backgroundColor = [UIColor redColor];
        [self addSubview:headImgView];
        [headImgView release];
    }
    return self;
}

@end
