//
//  BFImageListView.h
//  PPFIphone
//
//  Created by ZYVincent on 12-8-23.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFImageListCell.h"
#import "BFIndexPath.h"

@class BFImageListView;
@protocol BFImageListViewDataSource <NSObject>

@optional

//总共有几列
- (NSInteger)numberOfCloumsInImageList:(BFImageListView*)imageList;

//每一列里面有多少子视图
- (NSInteger)numberofRowsInImageList:(BFImageListView*)imageList inCloum:(NSInteger)nCloum;

//横向两个子视图之间的间隔
- (CGFloat)gapWidthBetweenSubviewInImageList:(BFImageListView*)imageList;

//纵向两个子视图之间的间隔
- (CGFloat)gapHeightBetweenSubviewInImageList:(BFImageListView*)imageList;

//纵向上视图中当前能看到的视图有几个
- (NSInteger)numberOfVisiableSubviewsForEachCloumnInImageList:(BFImageListView*)imageList;

//加载子视图
- (BFImageListCell*)imageListView:(BFImageListView*)imageList cellViewForIndexPath:(BFIndexPath*)indexPath;

@end

@protocol BFImageListViewDelegate <NSObject>

//选中，点击了哪个视图
- (void)imageListView:(BFImageListView*)imageList didSelectAtIndexPath:(BFIndexPath*)indexPath;

@end

@interface BFImageListView : UIScrollView<UIScrollViewDelegate>
{
    id<BFImageListViewDataSource> imageListDataSource;
    id<BFImageListViewDelegate>   imageListDelegate;
    
    CGFloat gapWidth;
    CGFloat gapHeight;
    
    NSInteger verticalVisiableCellCount;
    NSInteger _cloums;
    
    CGFloat subViewWidth;
    CGFloat subViewHeight;
    
    NSMutableDictionary *_resuseViews;
    NSMutableArray *_visiableViews;
    NSMutableArray *_cellHeightArray;
}
@property (nonatomic,assign)id<BFImageListViewDelegate> imageListDelegate;
@property (nonatomic,assign)id<BFImageListViewDataSource> imageListDataSource;


- (id)initWithDataSource:(id<BFImageListViewDataSource>)dataSource withDelegate:(id<BFImageListViewDelegate>)imDelegate withFrame:(CGRect)nFrame;


- (BFImageListCell *)dequeuReuseWithIdentifier:(NSString *)identifier;

- (void)reloadData;

- (NSArray*)visiableCellViews;


@end
