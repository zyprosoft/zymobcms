//
//  BFCustomSearchBar.m
//  BFCustomSegmenControl
//
//  Created by ZYVincent on 12-10-19.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import "BFCustomSearchBar.h"

@interface BFCustomSearchBar()
- (void)deleteAllText:(id)sender;
@end
@implementation BFCustomSearchBar
@synthesize backgroundImageView,iconImageView,deleteButton;
@synthesize inputTextField;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //set background
        backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
        [self addSubview:backgroundImageView];
        [backgroundImageView release];
        
        //set iconImageView
        iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width*23/25,frame.size.height*5/30/2,frame.size.width*2/20*5/10,frame.size.height*7/8*8/10)];
        iconImageView.hidden = YES;
        
        //set textfield
        inputTextField = [[UITextField alloc]initWithFrame:CGRectMake(frame.size.width*1/50,frame.size.height*2/9,frame.size.width*45/50,frame.size.height)];
        inputTextField.delegate = self;
        inputTextField.enablesReturnKeyAutomatically = YES;
        inputTextField.borderStyle = UITextBorderStyleNone;
        inputTextField.placeholder = @"请输入搜索关键字";
        inputTextField.backgroundColor = [UIColor clearColor];
        inputTextField.font = [UIFont systemFontOfSize:16];
        inputTextField.returnKeyType = UIReturnKeySearch;
        [self addSubview:inputTextField];
        [inputTextField release];
        
        [self addSubview:iconImageView];
        [iconImageView release];
        
        //set deleteImageView
        deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.frame =  CGRectMake(frame.size.width*23/25,frame.size.height*5/30/2,frame.size.width*2/20*5/10,frame.size.height*7/8*8/10);
        [deleteButton addTarget:self action:@selector(deleteAllText:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        
        //
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(observeInputSearchKeyword:) name:UITextFieldTextDidChangeNotification object:nil];
        
        
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    self.backgroundImageView = nil;
    self.iconImageView = nil;
    self.deleteButton = nil;
    [super dealloc];
}

- (void)addTarget:(id)target forTapSearchButtonAction:(SEL)action
{
    _destTarget = target;
    _destSelector = action;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - delete all text in input
- (void)deleteAllText:(id)sender
{    
    inputTextField.text = @"";
    
    [self swithtoNormalState];
    
}

#pragma mark - text filed delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (inputTextField.text == nil || [inputTextField.text isEqualToString:@""]) {
        return NO;
    }else {
        [_destTarget performSelector:_destSelector];
        [textField resignFirstResponder];
        return YES;
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{    
    
    if (self.delegate && [delegate respondsToSelector:@selector(searchBarGetFocusOnInputBox:)]) {
        [self.delegate searchBarGetFocusOnInputBox:self];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.text.length > 0) {
        [self swithToEditState];
    }
}

#pragma mark - open method
- (void)swithToEditState
{
//    iconImageView.hidden = YES;
    self.deleteButton.hidden = NO;
    
}

- (void)swithtoNormalState
{
//    iconImageView.hidden = NO;
    self.deleteButton.hidden = YES;
}

- (void)reloadSearchBarWithFrame:(CGRect)frame isBigSize:(BOOL)state
{
    self.frame = frame;
    
    //set background
    self.backgroundImageView.frame = CGRectMake(0,0,frame.size.width,frame.size.height);
    
    //set iconImageView
//    if (state) {
//        self.iconImageView.frame = CGRectMake(frame.size.width*26/28,frame.size.height*9/30/2,32*3/4,32*3/4);
//    }else {
//        self.iconImageView.frame = CGRectMake(frame.size.width*23/25,frame.size.height*9/30/2,32*3/4,32*3/4);
//    }
    
    //set textfield
    if (state) {
        inputTextField.frame = CGRectMake(frame.size.width*4/50,frame.size.height*2/9,frame.size.width*39/50,frame.size.height);
    }else{
        inputTextField.frame = CGRectMake(frame.size.width*5/50,frame.size.height*2/9,frame.size.width*37/50,frame.size.height);
    }

    
    //set deleteImageView
    if (state) {
        self.deleteButton.frame = CGRectMake(frame.size.width*27/29,frame.size.height*13/30/2,32*4/6,32*4/6);

    }else {
        self.deleteButton.frame = CGRectMake(frame.size.width*22/25,frame.size.height*13/30/2,32*4/6,32*4/6);

    }
    [self swithtoNormalState];            
}

#pragma mark -监视键盘输入
- (void)observeInputSearchKeyword:(NSNotification*)noti
{
    if (inputTextField.text.length > 0) {
        [self swithToEditState];
    }else {
        [self swithtoNormalState];
    }
}

@end
