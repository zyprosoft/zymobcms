//
//  BFVarHeightCell.h
//  OPinion
//
//  Created by ZYVincent on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//最好采用重绘来实现内容的展现
@interface BFVarHeightCell : UITableViewCell
{
    UILabel *testLabel;
}

- (void)updateCellWithContent:(NSString *)content;
+ (CGFloat)heightWithContent:(NSString *)content inTableView:(UITableView *)tView;
@end
