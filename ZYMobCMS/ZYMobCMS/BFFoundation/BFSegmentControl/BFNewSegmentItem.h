//
//  BFNewSegmentItem.h
//  PPFIphone
//
//  Created by ZYVincent on 12-11-30.
//  Copyright (c) 2012年 li sha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFNewSegmentItem;
@protocol BFNewSegmentItemDelegate <NSObject>
- (void)didTapOnSegmentItem:(BFNewSegmentItem*)item;
@end

@interface BFNewSegmentItem : UIView
{
    id<BFNewSegmentItemDelegate> delegate;
}
@property (nonatomic,assign)id<BFNewSegmentItemDelegate> delegate;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UIImageView *backgroundImgView;

@property (nonatomic,copy)NSString *normalImgName;
@property (nonatomic,copy)NSString *selectImgName;
@property (nonatomic,copy)NSString *sepatorImgName;
@property (retain, nonatomic) IBOutlet UIImageView *sepratorLineImgView;

- (id)initWithFrame:(CGRect)frame withNormalImgName:(NSString*)nName withSelectImgName:(NSString*)sName withSepratorName:(NSString*)seName withTitle:(NSString*)title;

- (void)switchToNormal;

- (void)switchToSelected;

- (void)switchToSlidingState;
- (void)switchToFinishState;

@end
