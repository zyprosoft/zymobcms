//
//  BFSecondLevelCell.h
//  OPinion
//
//  Created by ZYVincent on 12-7-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFTreeBaseCell.h"

@interface BFSecondLevelCell : BFTreeBaseCell
{
    UILabel *testLabel;
}
- (void)setLabelContent:(NSString *)content;

@end
