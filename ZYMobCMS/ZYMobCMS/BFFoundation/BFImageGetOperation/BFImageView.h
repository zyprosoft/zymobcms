//
//  BFImageView.h
//  OPinion
//
//  Created by ZYVincent on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFImageGetOperation.h"

@interface BFImageView : UIImageView
{
    NSString *_imageUrl;
    NSOperationQueue *_loadImageOueue;
}

- (id)initWithImageUrl:(NSString *)url;
- (void)setImageUrl:(NSString *)url;
- (void)setPlaceHolder:(UIImage *)pImage;

@end
