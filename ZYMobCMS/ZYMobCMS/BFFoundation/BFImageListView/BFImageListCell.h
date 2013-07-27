//
//  BFImageListCell.h
//  PPFIphone
//
//  Created by ZYVincent on 12-8-23.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFIndexPath.h"

// ** 图片数据的特殊性，加载大量图片时，记住要重新确定图片的大小适应imageView的frame
// ** 请custom 这个View 并且在使用时采用 drawRect 内绘制内容来更新cellView的内容，比如图片或者文字

@interface BFImageListCell : UIView
{
    BFIndexPath *indexPath;
    NSString *reuseIdentifier;
}

@property (nonatomic,copy)NSString *reuseIdentifier;
@property (nonatomic,retain)BFIndexPath *indexPath;

- (id)initWithIdentifier:(NSString *)identifier;

@end
