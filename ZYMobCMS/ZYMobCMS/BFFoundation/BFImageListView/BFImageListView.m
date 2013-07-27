//
//  BFImageListView.m
//  PPFIphone
//
//  Created by ZYVincent on 12-8-23.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import "BFImageListView.h"

@interface BFImageListView(PrivateMethod)

- (void)addImageViewForReuse:(BFImageListCell*)imageView;
- (void)updatePagesWhileScrolled;
- (void)didInitAllViews;
- (void)addTapGestureForCellView:(BFImageListCell*)cellView;

@end

@implementation BFImageListView
@synthesize imageListDelegate,imageListDataSource;

- (void)dealloc
{
    [_visiableViews release];
    [_resuseViews release];
    [_cellHeightArray release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (id)initWithDataSource:(id<BFImageListViewDataSource>)dataSource withDelegate:(id<BFImageListViewDelegate>)imDelegate withFrame:(CGRect)nFrame
{
    if (self = [super init]) {
        
        self.delegate = self;
        self.frame = nFrame;
        
        if (dataSource) {
            self.imageListDataSource = dataSource;
        }
        
        if (imDelegate) {
            self.imageListDelegate = imDelegate;
        }
        
        if ([self.imageListDataSource respondsToSelector:@selector(gapWidthBetweenSubviewInImageList:)]) {
            gapWidth = [self.imageListDataSource gapWidthBetweenSubviewInImageList:self];
        }
        
        if ([self.imageListDataSource respondsToSelector:@selector(gapHeightBetweenSubviewInImageList:)]) {
            gapHeight = [self.imageListDataSource gapHeightBetweenSubviewInImageList:self];
        }
        
        if ([self.imageListDataSource respondsToSelector:@selector(numberOfVisiableSubviewsForEachCloumnInImageList:)]) {
            
            verticalVisiableCellCount = [self.imageListDataSource numberOfVisiableSubviewsForEachCloumnInImageList:self];
        }
        
        if ([self.imageListDataSource respondsToSelector:@selector(numberOfCloumsInImageList:)]) {
            
            _cloums = [self.imageListDataSource numberOfCloumsInImageList:self];
        }
        
        
        
        // set the subView width and height now
        CGFloat totalWidth = self.frame.size.width;
        CGFloat totalHeight = self.frame.size.height;
        
        CGFloat totalXGapWidth = gapWidth * (_cloums+1);
        CGFloat totalYGapHeight = gapHeight * (verticalVisiableCellCount+1);
        
        CGFloat xLeaveWidth = totalWidth - totalXGapWidth;
        CGFloat yLeaveHeight = totalHeight - totalYGapHeight;
        
        subViewWidth = xLeaveWidth/_cloums;
        subViewHeight = yLeaveHeight/verticalVisiableCellCount-gapHeight/2;
        
        _visiableViews = [[NSMutableArray alloc]initWithCapacity:0];
        _resuseViews = [[NSMutableDictionary alloc]initWithCapacity:0];
        _cellHeightArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        [self didInitAllViews];
    }
    return self;
}

- (void)setImageListDataSource:(id<BFImageListViewDataSource>)newimageListDataSource
{
    if (newimageListDataSource) {
        self.imageListDataSource = newimageListDataSource;
    }
    [self didInitAllViews];
}

- (void)addImageViewForReuse:(BFImageListCell *)imageView
{
    if (imageView.reuseIdentifier==nil) {
        return;
    }
    
    NSMutableArray *eachArray = [_resuseViews objectForKey:imageView.reuseIdentifier];
    
    if(eachArray == nil){
        eachArray = [NSMutableArray array];
        [eachArray addObject:imageView];
    }else {
        
        [eachArray addObject:imageView];
    }
}

- (BFImageListCell*)dequeuReuseWithIdentifier:(NSString *)identifier
{
    if (identifier == nil && identifier.length == 0) {
        return nil;
    }
    
    NSMutableArray *reuseArray = [_resuseViews objectForKey:identifier];
    if (reuseArray != nil && reuseArray.count > 0) {
        
        BFImageListCell *use = [reuseArray lastObject];
        [use retain];
        [reuseArray removeObject:use];
        return [use autorelease];
    }
    
    return  nil;
}

- (void)reloadData
{    
    if ([self.imageListDataSource respondsToSelector:@selector(gapWidthBetweenSubviewInImageList:)]) {
        gapWidth = [self.imageListDataSource gapWidthBetweenSubviewInImageList:self];
    }
    
    if ([self.imageListDataSource respondsToSelector:@selector(gapHeightBetweenSubviewInImageList:)]) {
        gapHeight = [self.imageListDataSource gapHeightBetweenSubviewInImageList:self];
    }
    
    if ([self.imageListDataSource respondsToSelector:@selector(numberOfVisiableSubviewsForEachCloumnInImageList:)]) {
        
        verticalVisiableCellCount = [self.imageListDataSource numberOfVisiableSubviewsForEachCloumnInImageList:self];
    }
    
    if ([self.imageListDataSource respondsToSelector:@selector(numberOfCloumsInImageList:)]) {
        
        _cloums = [self.imageListDataSource numberOfCloumsInImageList:self];
    }
    
    // set the subView width and height now
    CGFloat totalWidth = self.frame.size.width;
    CGFloat totalHeight = self.frame.size.height;
    
    CGFloat totalXGapWidth = gapWidth * (_cloums+1);
    CGFloat totalYGapHeight = gapHeight * (verticalVisiableCellCount+1);
    
    CGFloat xLeaveWidth = totalWidth - totalXGapWidth;
    CGFloat yLeaveHeight = totalHeight - totalYGapHeight;
    
    subViewWidth = xLeaveWidth/_cloums;
    subViewHeight = yLeaveHeight/verticalVisiableCellCount-gapHeight/2;
    
    //移出所有子视图，用于重用
    for (int i=0; i<_cloums; i++) {
        
        NSMutableArray *cells = [_visiableViews objectAtIndex:i];
        
        for (int j=0; j<cells.count; j++) {
            
            [self addImageViewForReuse:[cells objectAtIndex:j]];
            [[cells objectAtIndex:j]removeFromSuperview];
        }
    }
    
    [self didInitAllViews];
}

- (void)didInitAllViews
{
    //视图包含内容的最大高度   
    CGFloat maxHeight = 0;
    
    //为每一列保存一个视图组
    for (int i=0; i<_cloums; i++) {
        
        NSMutableArray *cloumsArray = [NSMutableArray arrayWithCapacity:_cloums];
        [_visiableViews addObject:cloumsArray];
        
        NSInteger numberOfRowsInEachCloum = [imageListDataSource numberofRowsInImageList:self inCloum:i];
                
        NSMutableArray *rowsHeightForCloumArray = [NSMutableArray arrayWithCapacity:numberOfRowsInEachCloum];
        [_cellHeightArray addObject:rowsHeightForCloumArray];
        
        CGFloat fHeight = 0;
        for (int j=0; j<numberOfRowsInEachCloum; j++) {
            
            fHeight = (j+1)*gapHeight+j*subViewHeight;
                        
            //确定每一个子视图在列的什么位置
            [rowsHeightForCloumArray addObject:[NSNumber numberWithFloat:fHeight]];
            
        }
        maxHeight = (maxHeight>=fHeight)? maxHeight:fHeight+gapHeight*2;
    }
    [self setContentSize:CGSizeMake(320, maxHeight)];
    [self updatePagesWhileScrolled];
}

- (void)updatePagesWhileScrolled
{
    CGPoint offset = self.contentOffset;
        
    //加载所有视图
    for (int i=0; i<_cloums; i++) {
        
        CGFloat orginX = (i+1)*gapWidth+i*subViewWidth;
        
        //每一列有多少个视图
        NSMutableArray *eachCloumRowCells = [_visiableViews objectAtIndex:i];
        NSMutableArray *eachCloumRowsHeight = [_cellHeightArray objectAtIndex:i];
        
        BFImageListCell *cellView = nil;
        if (eachCloumRowCells == nil || [eachCloumRowCells count] == 0) {
            
            //确定第一个cell的位置
            int cRow = 0;
            for (int j=0; j<[eachCloumRowsHeight count]-1;j++) {
                
                CGFloat rowHeight = [[eachCloumRowsHeight objectAtIndex:j]floatValue];
                                
                if (rowHeight < offset.y) {
                    cRow++;
                }
            }
                        
            CGFloat originY = 0;
            if (cRow == 0) {
                originY = gapHeight;
            }else if(cRow < [eachCloumRowsHeight count]){
                originY = [[eachCloumRowsHeight objectAtIndex:cRow-1] floatValue];
            }
            
            cellView = [imageListDataSource imageListView:self cellViewForIndexPath:[BFIndexPath pathWithRow:cRow withCloum:i]];
            cellView.indexPath = [BFIndexPath pathWithRow:cRow withCloum:i];
            
            cellView.frame = CGRectMake(orginX, originY, subViewWidth, subViewHeight);
                                    
            [self addTapGestureForCellView:cellView];
            [self addSubview:cellView];
            
            [eachCloumRowCells insertObject:cellView atIndex:0];
            
        }
        
        else {
            cellView = [eachCloumRowCells objectAtIndex:0];
            
        }
                
        //加载上面的
        while (cellView &&((cellView.frame.origin.y -gapHeight - offset.y)>0.0001)) {
                        
            int cRow = cellView.indexPath.row;
            CGFloat originy = 0;
            
            //如果是第0行，那么上面没有可以加载的了，就跳出
            if (cRow == 0) {
                cellView = nil;
                continue;
            }
            
            //如果是第1行，那么加载第0行
            else if (cRow == 1) {
                originy = gapHeight;
            }
            
            else if (cRow <[eachCloumRowsHeight count]) {
                originy = [[eachCloumRowsHeight objectAtIndex:cRow -2]floatValue];
            }
            
            cellView = [imageListDataSource imageListView:self cellViewForIndexPath:[BFIndexPath pathWithRow:cRow>0? (cRow-1):0 withCloum:i]];
            
            cellView.indexPath = [BFIndexPath pathWithRow:cRow>0? (cRow-1):0 withCloum:i];
            
            cellView.frame = CGRectMake(orginX, originy, subViewWidth, subViewHeight);
        
            [self addTapGestureForCellView:cellView];
            [self addSubview:cellView];
            [eachCloumRowCells insertObject:cellView atIndex:0];
            
            if (cRow == 0) {
                break;
            }
        }
        
        //移出上面的
        while (cellView && ((cellView.frame.origin.y+cellView.frame.size.height - offset.y - gapHeight)<0.0001)) {
            
            [cellView removeFromSuperview];
            [self addImageViewForReuse:cellView];
            [eachCloumRowCells removeObject:cellView];
            
            if (eachCloumRowCells.count > 0) {
                
                cellView = [eachCloumRowCells objectAtIndex:0];
            }else {
                cellView = nil;
            }
        }
                
        //加载下面的
        cellView = [eachCloumRowCells lastObject];
        while (cellView && ((cellView.frame.origin.y+cellView.frame.size.height - self.frame.size.height - offset.y)<0.0001)) {
            
            int cRow = cellView.indexPath.row;
                        
            float originy = 0;
            
            //如果是最后一行，那么没有下面的了
            if (cRow == [eachCloumRowsHeight count]-1) {
                
                cellView = nil;
                break;
            }
            
            else {
                
                originy = [[eachCloumRowsHeight objectAtIndex:cRow]floatValue];
            }
                        
            cellView = [imageListDataSource imageListView:self cellViewForIndexPath:[BFIndexPath pathWithRow:cRow+1 withCloum:i]];
            
            cellView.indexPath = [BFIndexPath pathWithRow:cRow+1 withCloum:i];
            cellView.frame = CGRectMake(orginX, originy, subViewWidth, subViewHeight);
                        
            [self addTapGestureForCellView:cellView];
            [self addSubview:cellView];
            
            [eachCloumRowCells addObject:cellView];
            
        }
        
        //移出下面的
        while (cellView && ((cellView.frame.origin.y - self.frame.size.height - offset.y)>0.0001)) {
            
            [cellView removeFromSuperview];
            [self addImageViewForReuse:cellView];
            [eachCloumRowCells removeObject:cellView];
            
            if(eachCloumRowCells.count > 0)
			{
				cellView = [eachCloumRowCells lastObject];
			}
			else {
				cellView = nil;
			}
        }
        
    }
}

- (NSArray *)visiableCellViews
{
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<_cloums; i++) {
        NSArray *eachArray = [_visiableViews objectAtIndex:i];
        [resultArray addObjectsFromArray:eachArray];
    }
    return resultArray;
}

- (void)tapGestureMethod:(UITapGestureRecognizer*)tapGesutre
{
    BFImageListCell *tapView = (BFImageListCell*)tapGesutre.view;
    
    if (imageListDelegate&&[imageListDelegate respondsToSelector:@selector(imageListView:didSelectAtIndexPath:)]) {
        
        [imageListDelegate imageListView:self didSelectAtIndexPath:tapView.indexPath];
    }
}

- (void)addTapGestureForCellView:(BFImageListCell *)cellView
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureMethod:)];
    [cellView addGestureRecognizer:tap];
    [tap release];
}


#pragma mark -
#pragma mark UIScrollViewDelegate methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //    [self updatePagesWhileScrolled];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //	[self updatePagesWhileScrolled];
	
	NSLog(@"subviewcont = %d", [self.subviews count]);
	
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
	
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	//NSLog(@"scrollViewDidScroll = %@", NSStringFromCGPoint(scrollView.contentOffset));
	[self updatePagesWhileScrolled];
	
	NSLog(@"subviewcont = %d", [self.subviews count]);
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
	
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
	
}	


- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
	return YES;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
	
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	
}






@end
