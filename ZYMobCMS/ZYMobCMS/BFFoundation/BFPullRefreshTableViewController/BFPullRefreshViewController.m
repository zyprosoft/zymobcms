//
//  BFPullRefreshViewController.m
//  OPinion
//
//  Created by ZYVincent on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BFPullRefreshViewController.h"
#import <QuartzCore/QuartzCore.h>


#define REFRESH_HEAD_HEIGHT 60.f
#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]


@interface BFPullRefreshViewController ()

@end

@implementation BFPullRefreshViewController

@synthesize refreshHeadView,refreshTextLabel,arrowImgView,activeView;
@synthesize refreshString,pullString,releaseString;
@synthesize isLoading,isDragging;
@synthesize refreshTimeLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setupStrings];//初始化字符串
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (void)dealloc
{
    [refreshString release];
    [pullString release];
    [releaseString release];
    [super dealloc];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addHeadViewToTableView];//将头部视图添加到tableview得上部包围距离中
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setupStrings
{
    //设置静态字符串
    pullString = [[NSString alloc]init];
    pullString = @"下拉刷新列表数据";
    releaseString = [[NSString alloc]init];
    releaseString = @"释放开始刷新...";
    refreshString = [[NSString alloc]init];
    refreshString = @"正在刷新....";
}

- (void)addHeadViewToTableView
{
    //设置头部
    refreshHeadView = [[UIView alloc]initWithFrame:CGRectMake(0,-REFRESH_HEAD_HEIGHT, 320, REFRESH_HEAD_HEIGHT)];
    refreshHeadView.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
    
    //设置标签
    refreshTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, REFRESH_HEAD_HEIGHT/2+REFRESH_HEAD_HEIGHT/4)];
    refreshTextLabel.backgroundColor = [UIColor clearColor];
    refreshTextLabel.font = [UIFont boldSystemFontOfSize:14];
    refreshTextLabel.textAlignment = UITextAlignmentCenter;
    refreshTextLabel.textColor = TEXT_COLOR;
    
    //设置时间
    refreshTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, REFRESH_HEAD_HEIGHT/2, 320, 25)];
    refreshTimeLabel.backgroundColor = [UIColor clearColor];
    refreshTimeLabel.font = [UIFont systemFontOfSize:12.0];
    refreshTimeLabel.textAlignment = UITextAlignmentCenter;
    refreshTimeLabel.textColor = TEXT_COLOR;    
    //设置箭头位置
    arrowImgView = [[UIImageView alloc]init];
    arrowImgView.frame = CGRectMake(floorf((REFRESH_HEAD_HEIGHT - 27)/2), floorf((REFRESH_HEAD_HEIGHT - 44)/2), 27, 44);
    arrowImgView.image = [UIImage imageNamed:@"arrow.png"];
    
    //设置活动指示
    activeView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activeView.frame = CGRectMake(floorf((REFRESH_HEAD_HEIGHT -20)/2), floorf((REFRESH_HEAD_HEIGHT-20)/2), 20, 20);
    activeView.hidesWhenStopped = YES;
    
    //添加到头部视图
    [refreshHeadView addSubview:refreshTextLabel];
    [refreshHeadView addSubview:arrowImgView];
    [refreshHeadView addSubview:activeView];
    [refreshHeadView addSubview:refreshTimeLabel];
    
    [self.tableView addSubview:refreshHeadView];
    
    [refreshHeadView release];
    [refreshTextLabel release];
    [arrowImgView release];
    [activeView release];
    [refreshTimeLabel release];
    
}

//重写scollview得方法

//开始拖动得时得方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (isLoading) {
        return;
    }
    isDragging = YES;
}
//拖动中得方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (isLoading) {
        // 更改tableView被包围得头部边距
        if (scrollView.contentOffset.y > 0)
            self.tableView.contentInset = UIEdgeInsetsZero;//头部包围距离为0
        else if (scrollView.contentOffset.y >= -REFRESH_HEAD_HEIGHT)
            self.tableView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);//头部包围距离为偏移距离
    } else if (isDragging && scrollView.contentOffset.y < 0) {
        // 更改箭头得方向
        [UIView beginAnimations:nil context:NULL];
        if (scrollView.contentOffset.y < -REFRESH_HEAD_HEIGHT) {
            // 下拉超过了头部视图高度翻转箭头
            refreshTextLabel.text = self.releaseString;
            [arrowImgView layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        } else { // 已经在头部视图高度范围内则翻转箭头
            refreshTextLabel.text = self.pullString;
            [arrowImgView layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
        }
        [UIView commitAnimations];
    }
}
//结束拖动后开始减速得方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (isLoading) {
        return;
    }
    isDragging = NO;
    if (scrollView.contentOffset.y <= -REFRESH_HEAD_HEIGHT) {
        [self startLoading];
    }
    
}
//开始转动刷新
- (void)startLoading
{
    isLoading = YES;
    
    //显示头部,用动画缓和
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.tableView.contentInset = UIEdgeInsetsMake(REFRESH_HEAD_HEIGHT, 0, 0, 0);//改变tableview头部被包围状态
    self.refreshTextLabel.text = self.refreshString;
    self.arrowImgView.hidden = YES;
    [self.activeView startAnimating];
    
    [UIView commitAnimations];
    
    //执行刷新方法
    [self refresh];
    
}
//停止刷新
- (void)stopLoading
{
    isLoading = NO;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];//动画结束完执行完更改头部视图得内容
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);//恢复头部零距离包围tableview
    [arrowImgView layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    [self setLastRefreshTime];
    [UIView commitAnimations];
}
//animationdelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //刷新停止后需要恢复头部视图得内容
    self.refreshTextLabel.text = self.pullString;
    self.arrowImgView.hidden = NO;
    [self setLastRefreshTime];
    [self.activeView stopAnimating];
}
//刷新要执行得方法,需要覆盖此方法
- (void)refresh
{
    
}
//设置最后刷新时间
- (void)setLastRefreshTime
{
}

//- (NSString *)lastRefreshString {
//    NSInteger uptime = [[NSUserDefaults standardUserDefaults] integerForKey:textDataKey];
//    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
//    NSInteger differ = timestamp - uptime;
//    NSInteger m = 60;
//    NSInteger h = 60*m;
//    NSInteger d = 24*h;
//    NSInteger y = 365*d;
//    if (differ > y) {
//        return @"上次刷新时间：从未" ;
//    }
//    
//    NSInteger r = differ/d;
//    if (r > 0) {
//        return [NSString stringWithFormat:@"上次刷新时间：%d天前",r];
//    }else {
//        r = differ/h;
//        if (r > 0) {
//            return [NSString stringWithFormat:@"上次刷新时间：%d小时前",r];
//        }else {
//            r = differ/m;
//            if (r > 0) {
//                return [NSString stringWithFormat:@"上次刷新时间：%d分钟前",r];
//            }
//        }
//    }
//    return @"上次刷新时间：刚刚";
//}

@end
