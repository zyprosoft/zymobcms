//
//  BFImageGetOperation.m
//  OPinion
//
//  Created by ZYVincent on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BFImageGetOperation.h"

@interface BFImageGetOperation(PrivateMethod)
- (id)initWithImageUrl:(NSString *)url withFinishDelegate:(id)aDelegate withNewRect:(CGRect)newRect;
- (id)initWithImageUrl:(NSString *)url withFinishDelegate:(id)aDelegate;
@end

@implementation BFImageGetOperation

- (id)initWithImageUrl:(NSString *)url withFinishDelegate:(id)aDelegate withNewRect:(CGRect)newRect
{
    if (self = [super init]) {
        
        _delegate = [aDelegate retain];
        _imageUrl = [url copy];
        
        _newRect = newRect;
        _setNewRect = YES;
        
    }
    return self;
}
- (id)initWithImageUrl:(NSString *)url withFinishDelegate:(id)aDelegate
{
    if (self = [super init]) {
        
        _delegate = [aDelegate retain];
        _imageUrl = [url copy];
        
        _setNewRect = NO;
        
    }
    return self;
}
- (void)dealloc
{
    [_delegate release];
    [_cacheName release];
    [_imageUrl release];
    [super dealloc];
}

+ (BFImageGetOperation *)initWithImageUrl:(NSString *)url withFinishDelegate:(id)aDelegate
{
    BFImageGetOperation *operation = [[[BFImageGetOperation alloc]initWithImageUrl:url withFinishDelegate:aDelegate]autorelease];
    
    return operation;
}
+ (BFImageGetOperation *)initWithImageUrl:(NSString *)url withFinishDelegate:(id)aDelegate withNewRect:(CGRect)newRect
{
    BFImageGetOperation *operation = [[[BFImageGetOperation alloc]initWithImageUrl:url withFinishDelegate:aDelegate withNewRect:newRect]autorelease];
    
    return operation;
}

- (void)main{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    if (!_imageUrl) {
        NSAssert(_imageUrl = nil,@"image url can't be nil");
        [self cancel];
    }
    if (_delegate == nil) {
        NSAssert(_delegate = nil,@"image get delegate can't be nil");
        [self cancel];
    }
    
    UIImage *loadImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imageUrl]]];

    if (loadImage != nil) {
        UIImage *newImage = nil;
        if (_setNewRect) {
            CGSize itemSize = CGSizeMake(_newRect.size.width, _newRect.size.height);
            UIGraphicsBeginImageContext(itemSize);
            CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
            [loadImage drawInRect:imageRect];
            newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        newImage = loadImage;
        if ([_delegate respondsToSelector:@selector(imageDidLoad:)]) {
            [_delegate performSelectorOnMainThread:@selector(imageDidLoad:) withObject:newImage waitUntilDone:NO];
        }
    }
    [pool drain];
}
@end
