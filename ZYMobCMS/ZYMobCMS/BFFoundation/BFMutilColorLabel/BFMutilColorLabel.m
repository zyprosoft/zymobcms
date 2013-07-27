//
//  BFMutilColorLabel.m
//  PPFIpad
//
//  Created by ZYVincent on 12-10-19.
//  Copyright (c) 2012年 li sha. All rights reserved.
//

#import "BFMutilColorLabel.h"
#import <coreText/coreText.h>

@interface BFMutilColorLabel()
@property (nonatomic,strong)NSMutableAttributedString *mutableContentString;
@end
@implementation BFMutilColorLabel
@synthesize keywords;
@synthesize keywordColor;
@synthesize textFont;
@synthesize normalTextColor;
@synthesize isNeedBold;
@synthesize isNormal;
@synthesize contentAttriString;
@synthesize mutableContentString;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)dealloc
{
    if (self.contentAttriString) {
        self.contentAttriString = nil;
    }
    if (self.mutableContentString) {
        self.mutableContentString = nil;
    }
    self.keywordColor = nil;
    self.keywords = nil;
    self.textFont = nil;
    [super dealloc];
}
- (id)initWithContent:(NSString *)content withAttributeDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        
                
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (highlighted) {
//        [self swtichToSelected];
    }else {
//        [self swtichToNormal];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

+ (NSMutableAttributedString*)returnKeyAttributedStringFromString:(NSString *)source withKeyWord:(NSString *)keyword withFont:(UIFont *)font withKeyColor:(UIColor *)keyColor isBold:(BOOL)state
{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]
                                            
                                            initWithString:source];
    
    if (keyword!=nil) {
        
        CTFontRef helvetica = CTFontCreateWithName(CFSTR("Helvetica-Light"),font.pointSize , NULL);
        
        
        [attString addAttribute:(NSString*)(kCTForegroundColorAttributeName)  value:(id)[UIColor blackColor].CGColor range:NSMakeRange(0, source.length)];
        
        
        [attString addAttribute:(id)kCTFontAttributeName
                          value:(id)helvetica
                          range:NSMakeRange(0, source.length)];
        CFRelease(helvetica);

        
        //创建文本对齐方式
        CTTextAlignment alignment = kCTLeftTextAlignment;//左对齐
        CTParagraphStyleSetting alignmentStyle;
        alignmentStyle.spec=kCTParagraphStyleSpecifierAlignment;//指定为对齐属性
        alignmentStyle.valueSize=sizeof(CTTextAlignment);
        alignmentStyle.value=&alignment;
        
        CTParagraphStyleRef alignRef = CTParagraphStyleCreate(&alignmentStyle,1);
        
        [attString addAttribute:(NSString*)kCTParagraphStyleAttributeName value:(id)alignRef range:NSMakeRange(0,[source length])];
        
        CFRelease(alignRef);
        
        //创建文本行间距
        CGFloat lineSpace=6.0f;//间距数据
        CTParagraphStyleSetting lineSpaceStyle;
        lineSpaceStyle.spec=kCTParagraphStyleSpecifierLineSpacing;//指定为行间距属性
        lineSpaceStyle.valueSize=sizeof(CGFloat);
        lineSpaceStyle.value=&lineSpace;
        CTParagraphStyleRef lineRef = CTParagraphStyleCreate(&lineSpaceStyle,1);

        [attString addAttribute:(NSString*)kCTParagraphStyleAttributeName value:(id)lineRef range:NSMakeRange(0,[source length])];
        CFRelease(lineRef);
        
        //字体更细致
        CGFloat widthValue = -1.0;
        
        CFNumberRef strokeWidth = CFNumberCreate(NULL,kCFNumberFloatType,&widthValue);
        
        [attString addAttribute:(NSString*)(kCTStrokeWidthAttributeName) value:(id)strokeWidth range:NSMakeRange(0,[source length])];
        
        if (state) {
            [attString addAttribute:(NSString*)(kCTStrokeColorAttributeName) value:(id)[[UIColor blackColor] CGColor] range:NSMakeRange(0,[source length])];
        }else {
            [attString addAttribute:(NSString*)(kCTStrokeColorAttributeName) value:(id)[[UIColor whiteColor] CGColor] range:NSMakeRange(0,[source length])];
        }
        CFRelease(strokeWidth);

        //绘制关键字颜色
        NSMutableArray *rangeArray = [[NSMutableArray alloc]init];
        
        for (int i = 0; i < [source length]; i++) {
            NSString *keyString = [source substringWithRange:NSMakeRange(i, 1)];
            
            if([keyword rangeOfString:keyString].length > 0)//判断
            {
                NSRange range = [source rangeOfComposedCharacterSequenceAtIndex:i];
                NSValue *value = [NSValue valueWithRange:range];                
                if (range.length > 0) {
                    
                    [rangeArray addObject:value];
                }
            }
            
        }
        
        for (NSValue *value in rangeArray) {
            
            NSRange keyRange = [value rangeValue];
            
            [attString addAttribute:(NSString *)(kCTForegroundColorAttributeName) value:(id)keyColor.CGColor range:keyRange]; 
            
        }
        [rangeArray release];
        
    }
   
    return [attString autorelease];
}

+ (NSMutableAttributedString*)returnKeyAttributedStringFromString:(NSString *)source withName:(NSString *)name withNameColor:(UIColor *)nameColor withKeyword:(NSString *)keyword withKeywordColor:(UIColor *)keyColor withFont:(UIFont*)font isBold:(BOOL)state
{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]
                                            
                                            initWithString:source];

    if (keyword!=nil) {
        
        CTFontRef helvetica = CTFontCreateWithName(CFSTR("Helvetica-Light"),font.pointSize , NULL);
        
        
        [attString addAttribute:(NSString*)(kCTForegroundColorAttributeName)  value:(id)[UIColor blackColor].CGColor range:NSMakeRange(0, source.length)];
        
        
        [attString addAttribute:(id)kCTFontAttributeName
                          value:(id)helvetica
                          range:NSMakeRange(0, source.length)];
        CFRelease(helvetica);
        
        
        //创建文本对齐方式
        CTTextAlignment alignment = kCTLeftTextAlignment;//左对齐
        CTParagraphStyleSetting alignmentStyle;
        alignmentStyle.spec=kCTParagraphStyleSpecifierAlignment;//指定为对齐属性
        alignmentStyle.valueSize=sizeof(CTTextAlignment);
        alignmentStyle.value=&alignment;
        
        CTParagraphStyleRef alignRef = CTParagraphStyleCreate(&alignmentStyle,1);
        
        [attString addAttribute:(NSString*)kCTParagraphStyleAttributeName value:(id)alignRef range:NSMakeRange(0,[source length])];
        
        CFRelease(alignRef);
        
        //创建文本行间距
        CGFloat lineSpace=6.0f;//间距数据
        CTParagraphStyleSetting lineSpaceStyle;
        lineSpaceStyle.spec=kCTParagraphStyleSpecifierLineSpacing;//指定为行间距属性
        lineSpaceStyle.valueSize=sizeof(CGFloat);
        lineSpaceStyle.value=&lineSpace;
        CTParagraphStyleRef lineRef = CTParagraphStyleCreate(&lineSpaceStyle,1);
        
        [attString addAttribute:(NSString*)kCTParagraphStyleAttributeName value:(id)lineRef range:NSMakeRange(0,[source length])];
        CFRelease(lineRef);
        
        //字体更细致
        CGFloat widthValue = -1.0;
        
        CFNumberRef strokeWidth = CFNumberCreate(NULL,kCFNumberFloatType,&widthValue);
        
        [attString addAttribute:(NSString*)(kCTStrokeWidthAttributeName) value:(id)strokeWidth range:NSMakeRange(0,[source length])];
        
        if (state) {
            [attString addAttribute:(NSString*)(kCTStrokeColorAttributeName) value:(id)[[UIColor blackColor] CGColor] range:NSMakeRange(0,[source length])];
        }else {
            [attString addAttribute:(NSString*)(kCTStrokeColorAttributeName) value:(id)[[UIColor whiteColor] CGColor] range:NSMakeRange(0,[source length])];
        }
        CFRelease(strokeWidth);
        
        //绘制名字颜色
        NSRange nameRange = [source rangeOfString:name];
        [attString addAttribute:(NSString *)(kCTForegroundColorAttributeName) value:(id)nameColor.CGColor range:nameRange]; 
                
        //除去名字计算
        NSString *contentString = [source substringWithRange:NSMakeRange(nameRange.location+nameRange.length+1,source.length-nameRange.length-1)];
        
        //绘制关键字颜色
        NSMutableArray *rangeArray = [[NSMutableArray alloc]init];
        for (int i = nameRange.length+1 ; i < [contentString length]; i++) {
            NSString *keyString = [source substringWithRange:NSMakeRange(i, 1)];
            
            if([keyword rangeOfString:keyString].length > 0)//判断
            {
                NSRange range = [source rangeOfComposedCharacterSequenceAtIndex:i];
                NSValue *value = [NSValue valueWithRange:range];                
                if (range.length > 0) {
                    
                    [rangeArray addObject:value];
                }
            }
            
        }        
        
        for (NSValue *value in rangeArray) {
            
            NSRange keyRange = [value rangeValue];
            
            [attString addAttribute:(NSString *)(kCTForegroundColorAttributeName) value:(id)keyColor.CGColor range:keyRange]; 
            
        }
        

        
        [rangeArray release];
        
        
        
    }else {
        
        
        CTFontRef helvetica = CTFontCreateWithName(CFSTR("Helvetica-Light"),font.pointSize , NULL);
        
        
        [attString addAttribute:(NSString*)(kCTForegroundColorAttributeName)  value:(id)[UIColor blackColor].CGColor range:NSMakeRange(0, source.length)];
        
        
        [attString addAttribute:(id)kCTFontAttributeName
                          value:(id)helvetica
                          range:NSMakeRange(0, source.length)];
        CFRelease(helvetica);
        
        
        //创建文本对齐方式
        CTTextAlignment alignment = kCTLeftTextAlignment;//左对齐
        CTParagraphStyleSetting alignmentStyle;
        alignmentStyle.spec=kCTParagraphStyleSpecifierAlignment;//指定为对齐属性
        alignmentStyle.valueSize=sizeof(CTTextAlignment);
        alignmentStyle.value=&alignment;
        
        CTParagraphStyleRef alignRef = CTParagraphStyleCreate(&alignmentStyle,1);
        
        [attString addAttribute:(NSString*)kCTParagraphStyleAttributeName value:(id)alignRef range:NSMakeRange(0,[source length])];
        
        CFRelease(alignRef);
        
        //创建文本行间距
        CGFloat lineSpace=6.0f;//间距数据
        CTParagraphStyleSetting lineSpaceStyle;
        lineSpaceStyle.spec=kCTParagraphStyleSpecifierLineSpacing;//指定为行间距属性
        lineSpaceStyle.valueSize=sizeof(CGFloat);
        lineSpaceStyle.value=&lineSpace;
        CTParagraphStyleRef lineRef = CTParagraphStyleCreate(&lineSpaceStyle,1);
        
        [attString addAttribute:(NSString*)kCTParagraphStyleAttributeName value:(id)lineRef range:NSMakeRange(0,[source length])];
        CFRelease(lineRef);
        
        //字体更细致
        CGFloat widthValue = -1.0;
        
        CFNumberRef strokeWidth = CFNumberCreate(NULL,kCFNumberFloatType,&widthValue);
        
        [attString addAttribute:(NSString*)(kCTStrokeWidthAttributeName) value:(id)strokeWidth range:NSMakeRange(0,[source length])];
        
        if (state) {
            [attString addAttribute:(NSString*)(kCTStrokeColorAttributeName) value:(id)[[UIColor blackColor] CGColor] range:NSMakeRange(0,[source length])];
        }else {
            [attString addAttribute:(NSString*)(kCTStrokeColorAttributeName) value:(id)[[UIColor whiteColor] CGColor] range:NSMakeRange(0,[source length])];
        }
        CFRelease(strokeWidth);
        
        //绘制名字颜色        
        NSRange nameRange = [source rangeOfString:name];
        [attString addAttribute:(NSString *)(kCTForegroundColorAttributeName) value:(id)nameColor.CGColor range:nameRange]; 
        

    }
    
    
    
    
    return [attString autorelease];
}

- (void)setContentAttriString:(NSMutableAttributedString *)acontentAttriString
{
    if (self.mutableContentString != acontentAttriString) {
        self.mutableContentString = [acontentAttriString mutableCopy];
        [self setNeedsDisplay];
    }
}

- (void)drawTextInRect:(CGRect)rect
{    
    if (self.mutableContentString != nil) {
        
        CGContextRef context = UIGraphicsGetCurrentContext();//获取上下文
        CGContextSaveGState(context);
        
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);//设置坐标翻转
        CGContextTranslateCTM(context, 0, self.bounds.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, self.bounds);
        
        CTFramesetterRef framesetter =
        CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef)self.mutableContentString); //要创建的字符串
        CTFrameRef frame =
        CTFramesetterCreateFrame(framesetter,
                                 CFRangeMake(0, [self.mutableContentString length]), path, NULL);//加到要绘制的区域上
        CFRelease(framesetter);
        CFRelease(path);
        
        CTFrameDraw(frame, context); //4 绘制
        CFRelease(frame); //5
                        
        CGContextRestoreGState(context);
        
    }else {
        [super drawTextInRect:rect];
    }
}
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//    
//    [self drawTextInRect:rect];
//}

+ (CGFloat)boundingHeightWithNSMutableStateString:(NSMutableAttributedString*)source
{
    CTFramesetterRef framesetter =CTFramesetterCreateWithAttributedString( (CFMutableAttributedStringRef)source);
    CGSize suggestedSize =CTFramesetterSuggestFrameSizeWithConstraints(framesetter,CFRangeMake(0, 0), NULL,CGSizeMake(310,CGFLOAT_MAX), NULL);
    CFRelease(framesetter);
    return suggestedSize.height;
}

+ (CGFloat)boundingHeightWithWidth:(CGFloat)width withStateString:(NSMutableAttributedString *)source
{
    CTFramesetterRef framesetter =CTFramesetterCreateWithAttributedString( (CFMutableAttributedStringRef)source);
    CGSize suggestedSize =CTFramesetterSuggestFrameSizeWithConstraints(framesetter,CFRangeMake(0, 0), NULL,CGSizeMake(width,CGFLOAT_MAX), NULL);
    CFRelease(framesetter);
    return suggestedSize.height;
}
#pragma mark - change state
- (void)swtichToNormal
{
    isNormal = YES;
}
- (void)swtichToSelected
{
    isNormal = NO;
}


@end
