//
//  ZYProgressHUD.m
//  XiangQinXiangAi
//
//  Created by ZYVincent on 12-3-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZYProgressHUD.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat frameWitdth = 0.f;
static CGFloat frameHeight = 0.f;

@implementation ZYProgressHUD
@synthesize messageLabel;

+ (void)showHUDToView:(UIView *)view withMessage :(NSString *)message
{
    //重新找到大小
    CGSize fSize = [message sizeWithFont:[UIFont boldSystemFontOfSize:ZYPROGRESS_MESSAGELABEL_FONT_SIZE]];
    frameWitdth = fSize.width;
    frameHeight = fSize.height;
}
+ (void)showZYProgressHUDAddToView:(UIView *)view withGifName:(NSString *)name withMessage:(NSString *)message
{
    //重新找到大小
    CGSize fSize = [message sizeWithFont:[UIFont boldSystemFontOfSize:ZYPROGRESS_MESSAGELABEL_FONT_SIZE]];
    frameWitdth = fSize.width;
    frameHeight = fSize.height;
    
    ZYProgressHUD *hud = [[ZYProgressHUD alloc]initWithGifNmae:name withFitFrame:CGRectMake((320-frameWitdth)/2, (480-frameHeight-ZYPROGRESSGIFHEIGHT)/2, frameWitdth, frameHeight)];
    hud.messageLabel.text = message;
    
    [view addSubview:hud];
    [hud release];
}
+ (void)hideZYProgressHUDToView:(UIView *)view
{
    UIView *viewToRemove = nil;
	for (UIView *v in [view subviews]) {
		if ([v isKindOfClass:[ZYProgressHUD class]]) {
			viewToRemove = v;
		}
	}
	if (viewToRemove != nil) {
		ZYProgressHUD *HUD = (ZYProgressHUD *)viewToRemove;
        [HUD removeFromSuperview];
    }
} 
- (id)initWithGifNmae:(NSString *)gifName withFitFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code 
        
        SCGIFImageView *view = [[SCGIFImageView alloc]initWithGIFFile:gifName];
        view.backgroundColor = [UIColor clearColor];
        view.frame = CGRectMake((frame.size.width-ZYPROGRESSGIFWIDTH)/2,0, ZYPROGRESSGIFWIDTH, ZYPROGRESSGIFHEIGHT);
        [self addSubview:view];
        [view release];
        
        messageLabel = [[UILabel alloc]init];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.frame = CGRectMake(0,ZYPROGRESSGIFHEIGHT, frame.size.width, frame.size.height);
        messageLabel.textAlignment = UITextAlignmentCenter;
        messageLabel.textColor = [UIColor colorWithRed:ZYPROGRESS_MESSAGELABEL_TEXTCOLOR_RED/225.0 green:ZYPROGRESS_MESSAGELABEL_TEXTCOLOR_GREEN/225.0 blue:ZYPROGRESS_MESSAGELABEL_TEXTCOLOR_BLUE/225.0 alpha:1];
        messageLabel.font = [UIFont boldSystemFontOfSize:ZYPROGRESS_MESSAGELABEL_FONT_SIZE];
        [self addSubview:messageLabel];
        [messageLabel release];
    }
    return self;
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
- (void)dealloc{
    [super dealloc];
}
@end
