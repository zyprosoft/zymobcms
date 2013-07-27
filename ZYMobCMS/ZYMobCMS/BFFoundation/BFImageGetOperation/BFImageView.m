//
//  BFImageView.m
//  OPinion
//
//  Created by ZYVincent on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BFImageView.h"
#import "BFImageCache.h"

@interface BFImageView(PrivateMethod)
- (void)imageDidLoad:(UIImage *)loadImage;
@end
@implementation BFImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _loadImageOueue = [[NSOperationQueue alloc]init];
    }
    return self;
}
- (void)dealloc
{
    [_imageUrl release];
    [_loadImageOueue release];
    [super dealloc];
}

- (id)initWithImageUrl:(NSString *)url
{
    if (self = [super init]) {
        
        _imageUrl = [url copy];
        
        //先检测有没有缓存图片
        if ([BFImageCache imageForUrl:url] != nil) {
            self.image = [BFImageCache imageForUrl:url];
        }else {
            BFImageGetOperation *loadOperation = [BFImageGetOperation initWithImageUrl:url withFinishDelegate:self withNewRect:self.frame];
            [_loadImageOueue addOperation:loadOperation];
        }
    }
    return self;
}
- (void)setImageUrl:(NSString *)url
{
    _imageUrl = [url copy];
    
    //先检测有没有缓存图片
    if ([BFImageCache imageForUrl:url] != nil) {
        self.image = [BFImageCache imageForUrl:url];
    }else {
        BFImageGetOperation *loadOperation = [BFImageGetOperation initWithImageUrl:url withFinishDelegate:self withNewRect:self.frame];
        [_loadImageOueue addOperation:loadOperation]; 
    }
    
}
- (void)setPlaceHolder:(UIImage *)pImage
{
    self.image = pImage;
}

//BFImageGetOperation CallBack Method
- (void)imageDidLoad:(UIImage *)loadImage
{
    self.image = loadImage;
    
    //缓存图片
    [BFImageCache cacheImage:self.image withUrl:_imageUrl]; 
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
