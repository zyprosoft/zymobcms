//
//  BFImageDownloader.m
//  OPinion
//
//  Created by ZYVincent on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BFImageDownloader.h"
#import "BFImageCache.h"

static BFImageDownloader *_instance = nil;
@implementation BFImageDownloader

- (id)init{
    if (self = [super init]) {
        
        _loadQueue = [[NSOperationQueue alloc]init];
    }
    return self;
}
- (void)dealloc{
    [_loadQueue release];
    [super dealloc];
}

+ (BFImageDownloader *)shareLoader
{
    @synchronized(self){
        if (_instance == nil) {
            _instance = [[self alloc]init];
        }
    }
    return _instance;
}

//load image operation method
- (void)loadImageWithArguments:(NSObject *)arguments
{
    NSArray *paramArray = (NSArray *)arguments;
    
    NSURL *imageUrl = [NSURL URLWithString:[paramArray objectAtIndex:0]];
//    BFLogObject(imageUrl);
    UIImageView *imageView = [paramArray objectAtIndex:1];
    BOOL state = [[paramArray objectAtIndex:2]boolValue];
    
    UIImage *loadImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
//    BFLogObject(loadImage);
    
    if (loadImage != nil) {
        
        if (state) {
            CGSize itemSize = CGSizeMake(imageView.bounds.size.width, imageView.bounds.size.height);
            UIGraphicsBeginImageContext(itemSize);
            CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
            [loadImage drawInRect:imageRect];
            loadImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            imageView.image = loadImage;//圆角
        }else {
            imageView.image = loadImage;//圆角
        }
        
        //缓存图片
        [BFImageCache cacheImage:loadImage withUrl:[imageUrl absoluteString]];
    }else {
        
        imageView.image = nil;
    }
}

- (void)downloadImageWithUrl:(NSString *)url forView:(UIView *)view
{
    [self downloadImageWithUrl:url forView:view shouldResize:NO];
}

- (void)downloadImageWithUrl:(NSString *)url forView:(UIView *)view shouldResize:(BOOL)state
{
    if (url == nil) {
        return;
    }
    if (view == nil) {
        return;
    }
    
    if ([BFImageCache imageForUrl:url] != nil) {
        //直接去缓存获取图片
        UIImageView *forView = (UIImageView *)view;
        UIImage *cacheImage = [BFImageCache imageForUrl:url];
        forView.image = cacheImage;
        [forView setNeedsDisplay];
        
//        BFMLog(cacheImage);
//        BFMLog(url);
    }else {
//        BFMLog(url);
        NSArray *arguments = [NSArray arrayWithObjects:url,view,[NSNumber numberWithBool:state],nil];
        
        NSInvocationOperation *loadOperation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(loadImageWithArguments:) object:arguments];
        
        [_loadQueue addOperation:loadOperation];
        [loadOperation release];
    }
}

@end
