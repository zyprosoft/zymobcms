//
//  BFBaseTableCell.h
//  OPinion
//
//  Created by ZYVincent on 12-7-25.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFBaseTableCell : UITableViewCell
@property (nonatomic, retain) UIView* backView;
@property (nonatomic, retain) UIView* contentView;


- (void) drawContentView:(CGRect)r;
@end
