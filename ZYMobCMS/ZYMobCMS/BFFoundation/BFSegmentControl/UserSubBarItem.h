//
//  UserSubBarItem.h
//  BarfooBlog
//
//  Created by ZYVincent on 12-11-26.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserSubBarItem;
@protocol UserSubBarItemDelegate <NSObject>
- (void)didTapOnSubBaritem:(UserSubBarItem*)item;
@end
@interface UserSubBarItem : UIView
{
    id<UserSubBarItemDelegate> delegate;
    
    UILabel *titleLabel;
    
}
@property (nonatomic,assign)id<UserSubBarItemDelegate> delegate;
@property (nonatomic,retain)UILabel *titleLabel;

- (void)switchToSelected;
- (void)switchToNormal;

@end
