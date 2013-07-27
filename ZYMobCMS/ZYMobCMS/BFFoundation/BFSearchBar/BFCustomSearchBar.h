//
//  BFCustomSearchBar.h
//  BFCustomSegmenControl
//
//  Created by ZYVincent on 12-10-19.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFCustomSearchBar;
@protocol BFCustomSearchBarDelegate <NSObject>
- (void)searchBarGetFocusOnInputBox:(BFCustomSearchBar*)bar;
@end
@interface BFCustomSearchBar : UIControl<UITextFieldDelegate>
{
    @private
    UITextField *inputTextField;
    id _destTarget;
    SEL _destSelector;
    
    @public
    UIImageView *backgroundImageView;
    UIImageView *iconImageView;
    UIButton *deleteButton;
    
    id<BFCustomSearchBarDelegate> delegate;
    
}
@property (nonatomic,retain)UIImageView *backgroundImageView;
@property (nonatomic,retain)UIImageView *iconImageView;
@property (nonatomic,retain)UIButton *deleteButton;
@property (nonatomic,retain)UITextField *inputTextField;
@property (nonatomic,assign)id<BFCustomSearchBarDelegate> delegate;

- (void)addTarget:(id)target forTapSearchButtonAction:(SEL)action;

- (void)reloadSearchBarWithFrame:(CGRect)frame isBigSize:(BOOL)state;

- (void)swithToEditState;
- (void)swithtoNormalState;

@end
