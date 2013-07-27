//
//  BFNewSegmentControl.h
//  PPFIphone
//
//  Created by ZYVincent on 12-11-30.
//  Copyright (c) 2012年 li sha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFNewSegmentItem.h"

@class BFNewSegmentControl;

@protocol BFNewSegmentControlDataSource <NSObject>
//菜单里面有多少项
- (NSInteger)numberOfItemsInSegmentControl:(BFNewSegmentControl*)sgmCtrl;

//每一项得宽度是多少
- (CGFloat)widthForEachItemInsegmentControl:(BFNewSegmentControl*)sgmCtrl;

//对应索引项得标题是什么
- (NSString*)segmentControl:(BFNewSegmentControl*)sgmCtrl titleForItemAtIndex:(NSInteger)index;

//菜单选中了哪一项
- (void)segmentControl:(BFNewSegmentControl*)sgmCtrl didSelectAtIndex:(NSInteger)index;

//当前可见项有多少
- (NSInteger)visiableItemsOfsegmentControl:(BFNewSegmentControl*)sgmCtrl;

@end


@interface BFNewSegmentControl : UIView<BFNewSegmentItemDelegate,UIScrollViewDelegate>
{
    UIScrollView *backScrollView;
    
    UIImageView *selectTagView;
    
    UIImageView *leftTagView;
    UIImageView *rightTagView;
    
    id<BFNewSegmentControlDataSource> dataSource;
    
    NSInteger selectedIndex;
    NSInteger lastSelectIndex;
    
    CGFloat currentItemWidth;
    NSInteger totalCount;
    NSInteger visiableCount;
    
}
@property (nonatomic,assign)id<BFNewSegmentControlDataSource> dataSource;
@property (nonatomic,assign)NSInteger selectedIndex;
@property (nonatomic,retain)UIImageView *leftTagView;
@property (nonatomic,retain)UIImageView *rightTagView;

- (id)initWithFrame:(CGRect)frame withDataSource:(id<BFNewSegmentControlDataSource>)mDataSource;

- (BFNewSegmentItem*)itemAtIndex:(NSInteger)index;

- (void)shouldSelectAtIndex:(NSInteger)index;

- (void)reloadData;

@end
