//
//  AyncImageCell.h
//  OPinion
//
//  Created by ZYVincent on 12-7-23.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFImageView.h"

@interface AyncImageCell : UITableViewCell
@property (retain, nonatomic) IBOutlet BFImageView *headImgView;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;

@end
