//
//  CommonUserSubBar.m
//  BarfooBlog
//
//  Created by ZYVincent on 12-11-26.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import "CommonUserSubBar.h"

@implementation CommonUserSubBar
@synthesize dataSource;
@synthesize selectedIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withDataSource:(id<CommonUserSubBarDataSource>)mDataSource
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

//绘制子视图
- (void)initSubViews
{
    CGFloat totalWidth = self.frame.size.width;
    
    NSInteger totalItemCount = 0;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfItemsInBar:)]) {
        totalItemCount = [self.dataSource numberOfItemsInBar:self];
    }
    
    CGFloat itemWidth = totalWidth/totalItemCount;
    CGFloat itemHeight = self.frame.size.height;
    
    //设置背景
    for (int i=0; i<totalItemCount; i++) {
        
        CGRect itemFrame = CGRectMake(i*(itemWidth-2),0,itemWidth-2,itemHeight);

        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:itemFrame];
        if (i == totalItemCount-1) {
//            imgView.image = [OPCommon getThemeImage:@"segment_right_item.png"];

        }else {
//            imgView.image = [OPCommon getThemeImage:@"segment_left_item.png"];

        }
        imgView.tag = 1112+i;
        
        [self addSubview:imgView];
        [imgView release];
    }
    
    //生成选择视图
    selectedBackImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,itemWidth,itemHeight)];
//    selectedBackImgView.image = [BFUitils streghtImage:[OPCommon getThemeImage:@"segment_selected.png"]];
    [self addSubview:selectedBackImgView];
    [selectedBackImgView release];
    
    for (int i= 0; i<totalItemCount; i++) {
        
        CGRect itemFrame = CGRectMake(i*itemWidth,0,itemWidth,itemHeight);
                                      
        UserSubBarItem *item = [[UserSubBarItem alloc]initWithFrame:itemFrame];
        item.delegate = self;
        item.tag = 2233+i;
        item.backgroundColor = [UIColor clearColor];
        
        NSString *title = nil;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(userSubBar:titleForIndex:)]) {
            title = [self.dataSource userSubBar:self titleForIndex:i];
        }
        item.titleLabel.text = title;
        
        [self addSubview:item];
        [item release];
        
        if (i==0) {
            [item switchToSelected];
            selectedIndex = 0;//默认选中 第一个
        }else {
            [item switchToNormal];
        }
    }
    
}

- (void)didSelectAnimationStop
{
    UserSubBarItem *selectedItem = (UserSubBarItem*)[self viewWithTag:2233+selectedIndex];
    [selectedItem switchToSelected];
}

- (void)willSelectAnimationStart
{
    UserSubBarItem *lastSelectItem = (UserSubBarItem*)[self viewWithTag:2233+lastSelectIndex];
    [lastSelectItem switchToNormal];
}

//动画
- (void)shouldSelectedAtIndex:(NSInteger)index
{
    CGFloat totalWidth = self.frame.size.width;
    
    NSInteger totalItemCount = 0;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfItemsInBar:)]) {
        totalItemCount = [self.dataSource numberOfItemsInBar:self];
    }
    
    CGFloat itemWidth = totalWidth/totalItemCount;
    CGFloat itemHeight = self.frame.size.height;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDidStopSelector:@selector(didSelectAnimationStop)];
    [UIView setAnimationWillStartSelector:@selector(willSelectAnimationStart)];
    [UIView setAnimationDelegate:self];
    
    selectedBackImgView.frame = CGRectMake(itemWidth*index,0,itemWidth,itemHeight);
    
    [UIView commitAnimations];
}

#pragma mark - item 选择代理方法
- (void)didTapOnSubBaritem:(UserSubBarItem *)item
{
    NSInteger selectIndex = item.tag - 2233;
    
    if (selectedIndex == selectIndex) {
        return;
    }
    lastSelectIndex = selectedIndex;
    selectedIndex = selectIndex;

    [self shouldSelectedAtIndex:selectedIndex];

    if(self.dataSource && [self.dataSource respondsToSelector:@selector(userSubBar:didSelectAtIndex:)]){
    
        [self.dataSource userSubBar:self didSelectAtIndex:selectedIndex];
    }
}

- (void)reloadData
{
    for (UIView *view in self.subviews) {
        
        [view removeFromSuperview];
    }
    
    [self initSubViews];
}

@end
