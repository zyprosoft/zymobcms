//
//  BFPullRefreshViewController.h
//  OPinion
//
//  Created by ZYVincent on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFPullRefreshViewController : UITableViewController
{
    //头部增加得图片
    UIView *refreshHeadView;
    //下拉标签
    UILabel *refreshTextLabel;
    //箭头标签
    UIImageView *arrowImgView;
    //活动指示
    UIActivityIndicatorView *activeView;
    
    BOOL isLoading;//是否正在刷新
    BOOL isDragging;//是否正在下拉
    
    NSString *pullString;//下拉刷新
    NSString *releaseString;//释放刷新
    NSString *refreshString;//正在刷新
    
    UILabel *refreshTimeLabel;    
    
}
@property (nonatomic,retain)UIView *refreshHeadView;
@property (nonatomic,retain)UILabel *refreshTextLabel;
@property (nonatomic,retain)UIImageView *arrowImgView;
@property (nonatomic,retain)UIActivityIndicatorView *activeView;
@property (nonatomic)BOOL isLoading;
@property (nonatomic)BOOL isDragging;
@property (nonatomic,copy)NSString *pullString;
@property (nonatomic,copy)NSString *releaseString;
@property (nonatomic,copy)NSString *refreshString;
@property (nonatomic,retain)UILabel *refreshTimeLabel;

//开始刷新
- (void)startLoading;
//停止刷新
- (void)stopLoading;
//执行刷新时得方法，子类覆盖此方法
- (void)refresh;
//初始化头部字符串
- (void)setupStrings;
//插入头部试图到tableView里面
- (void)addHeadViewToTableView;
//设置刷新时间，子类覆盖此方法
- (void)setLastRefreshTime;
//- (NSString *)lastRefreshString;

@end
