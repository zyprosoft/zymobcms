//
//  BFNewSegmentItem.m
//  PPFIphone
//
//  Created by ZYVincent on 12-11-30.
//  Copyright (c) 2012年 li sha. All rights reserved.
//

#import "BFNewSegmentItem.h"

@implementation BFNewSegmentItem
@synthesize sepratorLineImgView;
@synthesize titleLabel;
@synthesize backgroundImgView;
@synthesize normalImgName,selectImgName;
@synthesize delegate;
@synthesize sepatorImgName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self = (BFNewSegmentItem*)[BFUitils viewFromNibWithName:@"BFNewSegmentItem" owner:nil];
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];

        self.backgroundImgView.frame = CGRectMake(0,0,frame.size.width-2,frame.size.height);
        self.sepratorLineImgView.frame = CGRectMake(self.backgroundImgView.frame.size.width, 0,2,frame.size.height);
        self.titleLabel.frame = CGRectMake(0,0,frame.size.width,frame.size.height);
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withNormalImgName:(NSString *)nName withSelectImgName:(NSString *)sName withSepratorName:(NSString *)seName withTitle:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        
        
        self = (BFNewSegmentItem*)[BFUitils viewFromNibWithName:@"BFNewSegmentItem" owner:nil];
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];

        self.selectImgName = sName;
        self.sepatorImgName = seName;
        self.normalImgName = nName;
        
        if (self.sepatorImgName == nil) {
            self.backgroundImgView.frame = CGRectMake(0,0,frame.size.width,frame.size.height);
            self.sepratorLineImgView.frame = CGRectMake(self.backgroundImgView.frame.size.width, 0,0,frame.size.height);
        }else {
            self.backgroundImgView.frame = CGRectMake(0,0,frame.size.width,frame.size.height);
            self.sepratorLineImgView.frame = CGRectMake(self.backgroundImgView.frame.size.width, 0,2,frame.size.height);
        }
        
        self.backgroundImgView.hidden = YES;
        self.sepratorLineImgView.hidden = YES;
        
//        self.sepratorLineImgView.image = [OPCommon getThemeImage:sepatorImgName];
        self.titleLabel.frame = CGRectMake(0,0,frame.size.width,frame.size.height);
        
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.titleLabel.text = title;
        self.titleLabel.textColor = [UIColor whiteColor];

//        [BFUitils clearBlurryForSubView:self.titleLabel];
        
        //
        UITapGestureRecognizer *tapR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnSelf)];
        [self addGestureRecognizer:tapR];
        [tapR release];
        
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

- (void)tapOnSelf
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapOnSegmentItem:)]) {
        
        [self.delegate didTapOnSegmentItem:self];
    }
}
- (void)dealloc {
    self.selectImgName = nil;
    self.normalImgName = nil;
    self.sepatorImgName = nil;
    
    [titleLabel release];
    [backgroundImgView release];
    [sepratorLineImgView release];
    [super dealloc];
}

- (void)switchToNormal
{
    backgroundImgView.hidden = YES;
//    self.backgroundImgView.image = [OPCommon getThemeImage:self.normalImgName];
    self.titleLabel.textColor = [UIColor whiteColor];
    
//    self.backgroundImgView.frame = CGRectMake(0,0,self.frame.size.width,self.frame.size.height);

}

- (void)switchToSelected
{
    backgroundImgView.hidden = NO;
    
    self.backgroundImgView.frame = CGRectMake(0,1,self.frame.size.width,self.frame.size.height);

//    UIImage *sImg = [BFUitils streghtImage: [OPCommon getThemeImage:self.selectImgName]];

//    self.backgroundImgView.image = sImg;
    
    
    self.titleLabel.textColor = [UIColor colorWithRed:0 green:160/255.0 blue:255/255.0 alpha:1];
    
}

- (void)switchToSlidingState
{
    self.backgroundImgView.hidden = YES;
}
- (void)switchToFinishState
{  
    self.backgroundImgView.hidden = NO;
}
@end
