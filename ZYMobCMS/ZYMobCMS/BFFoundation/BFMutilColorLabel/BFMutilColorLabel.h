//
//  BFMutilColorLabel.h
//  PPFIpad
//
//  Created by ZYVincent on 12-10-19.
//  Copyright (c) 2012年 li sha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFMutilColorLabel : UILabel
@property (nonatomic,copy)NSString *keywords;
@property (nonatomic,retain)UIColor *keywordColor;
@property (nonatomic,retain)UIFont *textFont;
@property (nonatomic,retain)UIColor *normalTextColor;
@property (nonatomic)BOOL isNeedBold;
@property (nonatomic)BOOL isNormal;
@property (nonatomic,copy)NSMutableAttributedString  *contentAttriString;


- (id)initWithContent:(NSString*)content withAttributeDict:(NSDictionary*)dict;

- (void)swtichToNormal;
- (void)swtichToSelected;

+ (NSMutableAttributedString*)returnKeyAttributedStringFromString:(NSString*)source withKeyWord:(NSString*)keyword withFont:(UIFont*)font withKeyColor:(UIColor*)keyColor isBold:(BOOL)state;

+ (NSMutableAttributedString *)returnKeyAttributedStringFromString:(NSString*)source withName:(NSString*)name withNameColor:(UIColor*)nameColor
                                                       withKeyword:(NSString*)keyword withKeywordColor:(UIColor *)keyColor withFont:(UIFont*)font isBold:(BOOL)state;

+ (CGFloat)boundingHeightWithNSMutableStateString:(NSMutableAttributedString*)source;

+ (CGFloat)boundingHeightWithWidth:(CGFloat)width withStateString:(NSMutableAttributedString*)source;

@end
