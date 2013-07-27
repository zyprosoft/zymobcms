//
//  ZYProgressHUD.h
//  XiangQinXiangAi
//
//  Created by ZYVincent on 12-3-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCGIFImageView.h"
#import "ZYProgressHUDConfig.h"

@interface ZYProgressHUD : UIView
{
    UILabel *messageLabel;
    

}
@property (nonatomic,retain)UILabel *messageLabel;


+ (void)showHUDToView:(UIView *)view withMessage:(NSString *)message;

+ (void)showZYProgressHUDAddToView:(UIView *)view withGifName:(NSString *)name withMessage:(NSString *)message;
+ (void)hideZYProgressHUDToView:(UIView *)view;
- (id)initWithGifNmae:(NSString *)gifName withFitFrame:(CGRect)frame;
@end
