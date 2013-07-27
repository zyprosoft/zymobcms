//
//  BFImageListViewController.h
//  PPFIphone
//
//  Created by ZYVincent on 12-8-23.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFImageListCell.h"
#import "BFImageListView.h"

@interface BFImageListViewController : UIViewController<BFImageListViewDelegate,BFImageListViewDataSource>
{
    BFImageListView *_imageListView;
    
    NSMutableArray *sourceArray;

}


@end
