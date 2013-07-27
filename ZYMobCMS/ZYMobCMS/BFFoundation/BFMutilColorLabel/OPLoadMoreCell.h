//
//  OPLoadMoreCell.h
//  OPinion
//
//  Created by ZYVincent on 12-7-25.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OPLoadMoreCell : UITableViewCell
@property (retain, nonatomic)UIActivityIndicatorView *indicatorView;
@property (retain, nonatomic)UILabel *loadLabel;

- (void)startLoading;
- (void)stopLoading;

@end
