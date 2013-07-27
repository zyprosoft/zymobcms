//
//  CommonUserSubBar.h
//  BarfooBlog
//
//  Created by ZYVincent on 12-11-26.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserSubBarItem.h"

@class  CommonUserSubBar;

@protocol CommonUserSubBarDataSource <NSObject>
- (NSInteger)numberOfItemsInBar:(CommonUserSubBar*)bar;
- (NSString*)userSubBar:(CommonUserSubBar*)bar titleForIndex:(NSInteger)index;
- (void)userSubBar:(CommonUserSubBar*)bar didSelectAtIndex:(NSInteger)index;
@end

@interface CommonUserSubBar : UIView<UserSubBarItemDelegate>
{
    id<CommonUserSubBarDataSource> dataSource;
    
    UIImageView *selectedBackImgView;
    
    NSInteger selectedIndex;
    NSInteger lastSelectIndex;
}
@property (nonatomic,assign)id<CommonUserSubBarDataSource> dataSource;
@property (nonatomic,assign)NSInteger selectedIndex;

- (id)initWithFrame:(CGRect)frame withDataSource:(id<CommonUserSubBarDataSource>)mDataSource;

- (void)reloadData;

@end
