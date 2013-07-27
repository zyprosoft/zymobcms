//
//  AsyncImageCell.h
//  OPinion
//
//  Created by ZYVincent on 12-7-24.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFImageView.h"

@interface AsyncImageCell : UITableViewCell
{
    BFImageView *headImgView;
}

- (id)initwithHeadImgUrl:(NSString *)url reuseIdentify:(NSString *)identify;
@end
