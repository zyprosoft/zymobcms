//
//  BFSegmentItem.h
//  BFCustomSegmenControl
//
//  Created by ZYVincent on 12-10-18.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFSegmentItem;
@protocol BFSegmentItemDelegate <NSObject>
- (void)didTapOnItem:(BFSegmentItem*)item;
@end
@interface BFSegmentItem : UIView
{
    UIImageView *gripImgView;
    
    UIImageView *backgroundImgView;
    UIImageView *sepratorLine;
    UILabel *titleLabel;
    
    NSInteger index;
    id<BFSegmentItemDelegate> delegate;
}
@property (nonatomic,retain)UIImageView *sepratorLine;
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic)NSInteger index;
@property (nonatomic,assign)id<BFSegmentItemDelegate> delegate;
@property (nonatomic,retain)UIImageView *backgroundImgView;

- (id)initWithFrame:(CGRect)frame withSepratorLine:(UIImage*)sepImage withTitle:(NSString*)title isLastRightItem:(BOOL)state withBackgroundImage:(UIImage*)backImage;

- (void)switchToSelected;
- (void)switchToNormal;

@end
