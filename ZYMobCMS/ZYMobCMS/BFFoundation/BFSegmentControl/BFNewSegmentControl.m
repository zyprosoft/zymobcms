//
//  BFNewSegmentControl.m
//  PPFIphone
//
//  Created by ZYVincent on 12-11-30.
//  Copyright (c) 2012年 li sha. All rights reserved.
//

#import "BFNewSegmentControl.h"

@implementation BFNewSegmentControl
@synthesize dataSource;
@synthesize selectedIndex;
@synthesize leftTagView;
@synthesize rightTagView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withDataSource:(id<BFNewSegmentControlDataSource>)mDataSource
{
    if (self = [super initWithFrame:frame]) {
        
        self.dataSource = mDataSource;
        
        [self initSubViews];
        
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

- (void)initSubViews
{
    
    CGFloat totalWidth = self.frame.size.width;
    CGFloat totalHeight = self.frame.size.height;
    
    //添加背景
    UIImageView *backImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,totalWidth,totalHeight)];
//    backImgView.image = [OPCommon getThemeImage:@"bar_background.png"];
    [self addSubview:backImgView];
    [backImgView release];
    
    backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
    backScrollView.backgroundColor = [UIColor clearColor];
    backScrollView.showsHorizontalScrollIndicator = NO;
    backScrollView.delegate = self;
    [self addSubview:backScrollView];
    [backScrollView release];
    
    NSInteger itemCount = 0;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfItemsInSegmentControl:)]) {
        itemCount = [self.dataSource numberOfItemsInSegmentControl:self];
        totalCount = itemCount;
    }
    
    //可见项有多少
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(visiableItemsOfsegmentControl:)]) {
        visiableCount = [self.dataSource visiableItemsOfsegmentControl:self];
    }
    
    CGFloat itemWidth = 0.f;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(widthForEachItemInsegmentControl:)]) {
        itemWidth = [self.dataSource widthForEachItemInsegmentControl:self];
        
        currentItemWidth = itemWidth;
    }
    
    //添加选中背景滑块
    selectTagView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,itemWidth,backScrollView.frame.size.height)];
//    selectTagView.image = [BFUitils streghtImage:[OPCommon getThemeImage:@"segment_selected.png"]];
    [backScrollView addSubview:selectTagView];
    [selectTagView release];
    
    //左右指示项
//    leftTagView = [[UIImageView alloc]initWithImage:[OPCommon getThemeImage:@"segment_left_tag.png"]];
    [self setLeftTagViewHidden:YES];
    [self  addSubview:leftTagView];
    [leftTagView release];
    
    //
//    rightTagView = [[UIImageView alloc]initWithImage:[OPCommon getThemeImage:@"segment_right_tag.png"]];
    [self setRightTagViewHidden:YES];
    [self addSubview:rightTagView];
    [rightTagView release];
    
    //添加子项目
    for (int i=0; i<itemCount; i++) {
        
        CGRect itemFrame = CGRectMake(i*itemWidth,0,itemWidth,backScrollView.frame.size.height);
        
        NSString *title = nil;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(segmentControl:titleForItemAtIndex:)]) {
            title = [self.dataSource segmentControl:self titleForItemAtIndex:i];
        }
        
        BFNewSegmentItem *item = nil;
        if (i==itemCount-1) {
            
            item = [[BFNewSegmentItem alloc]initWithFrame:itemFrame withNormalImgName:@"segment_right_item.png" withSelectImgName:@"segment_selected.png" withSepratorName:nil withTitle:title];
            
        }else {
            
            item = [[BFNewSegmentItem alloc]initWithFrame:itemFrame withNormalImgName:@"segment_right_item.png" withSelectImgName:@"segment_selected.png" withSepratorName:@"segment_seprator_line.png" withTitle:title];
        }
        
        item.delegate = self;
        item.tag = 8899+i;
        item.backgroundColor = [UIColor clearColor];
        
        [backScrollView addSubview:item];        
        
        //默认选中第一个
        if (i==0) {
            
            [item switchToSelected];
            
            lastSelectIndex = 0;
            selectedIndex = 0;
        }else {
            [item switchToNormal];
        }
        
        //总的长度
        backScrollView.contentSize = CGSizeMake(itemWidth*itemCount,totalHeight);
        
        //set default right tag 
        if (backScrollView.contentSize.width > backScrollView.frame.size.width) {
            [self setRightTagViewHidden:NO];
        }
        
    }
    
}

- (void)changeAllItemToSlidingState:(BOOL)state
{
    for (int i=0;i<totalCount;i++) {
        
        BFNewSegmentItem *item = [self itemAtIndex:8899+i];
        
        if (state) {
            [item switchToSlidingState];
        }else {
            [item switchToFinishState];
        }
    }
}

- (BFNewSegmentItem*)itemAtIndex:(NSInteger)index
{
    return (BFNewSegmentItem*)[self viewWithTag:8899+index];
}
- (void)willAnimationMove
{
    BFNewSegmentItem *selectedItem = [self itemAtIndex:lastSelectIndex];

    [selectedItem switchToNormal];
    
}

- (void)finishMoveSlider
{    
    BFNewSegmentItem *selectedItem = [self itemAtIndex:selectedIndex];
    
    [selectedItem switchToSelected];
    
    //当达到可显示项目得最后两项时，自动超前滑动一项
    if (totalCount > visiableCount) {
        
        NSInteger moveCount = 0;
        if (selectedIndex % visiableCount == 1) {
            moveCount = visiableCount - 2;            
        }
        if (selectedIndex % visiableCount == 0 || index != 0) {
            moveCount = visiableCount - 3;
        }
        
        [backScrollView scrollRectToVisible:CGRectMake(currentItemWidth*(selectedIndex-moveCount),0,backScrollView.frame.size.width,backScrollView.frame.size.height) animated:YES];
        
    }
    
}


- (void)shouldAniamtionToSelectIndex:(NSInteger)index
{    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(willAnimationMove)];
    [UIView setAnimationDidStopSelector:@selector(finishMoveSlider)];
    
    selectTagView.frame = CGRectMake(index*currentItemWidth,0,currentItemWidth,backScrollView.frame.size.height);
    
    [UIView commitAnimations];
    
}

- (void)reloadData
{
    for (UIView *view in [backScrollView subviews]){
        
        [view removeFromSuperview];
    }
    backScrollView.frame = CGRectMake(0,0,self.frame.size.width,self.frame.size.height);
    
    [self initSubViews];
}

#pragma mark - scrollViewDelegate 
- (void)setLeftTagViewHidden:(BOOL)state
{
    self.leftTagView.frame = CGRectMake(1,16,4,12);
    self.leftTagView.hidden = state;
}
- (void)setRightTagViewHidden:(BOOL)state
{
    self.rightTagView.frame = CGRectMake(self.frame.size.width-5,16,4,12);
    self.rightTagView.hidden = state;
}
//decide if need hide left or right tag view,0.5 is a float value
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    
    if (offset.x == 0 && offset.x <= scrollView.frame.size.width+0.5 && scrollView.contentSize.width > scrollView.frame.size.width+0.5) {
        [self setLeftTagViewHidden:YES];
        [self setRightTagViewHidden:NO];
    }else if((scrollView.contentSize.width-offset.x) <= scrollView.frame.size.width+0.5){
        [self setRightTagViewHidden:YES];
        [self setLeftTagViewHidden:NO];
    }else if(scrollView.contentSize.width < scrollView.frame.size.width+0.5){
        [self setRightTagViewHidden:YES];
        [self setLeftTagViewHidden:YES];
    }else {
        [self setLeftTagViewHidden:NO];
        [self setRightTagViewHidden:NO];
    }
}

#pragma mark - 主动选中哪个选项
- (void)shouldSelectAtIndex:(NSInteger)index
{
    if (selectedIndex != index) {
        
        lastSelectIndex = selectedIndex;
        
        selectedIndex = index;
        
        [self shouldAniamtionToSelectIndex:selectedIndex];
    }
}

#pragma mark - item delegate
- (void)didTapOnSegmentItem:(BFNewSegmentItem *)item
{
    NSInteger currentIndex = item.tag - 8899;
    
    if (selectedIndex != currentIndex) {
        
        lastSelectIndex = selectedIndex;
        
        selectedIndex = currentIndex;
        
        [self shouldAniamtionToSelectIndex:selectedIndex];
        
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(segmentControl:didSelectAtIndex:)]) {
            [self.dataSource segmentControl:self didSelectAtIndex:selectedIndex];
        }
    }
}

@end
