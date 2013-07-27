//
//  BFElement.h
//  OPinion
//
//  Created by ZYVincent on 12-7-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    
    BFElementFirstLevel = 0,
    BFElementSecondLevel,
    BFElementThirdLevel,
}BFElementLevel;

@interface BFElement : NSObject
{
    NSString *content;
    NSInteger levelFlag;
    NSInteger subCount; 
}
@property (nonatomic,copy)NSString *content;
@property (nonatomic)NSInteger levelFlag;
@property (nonatomic)NSInteger subCount;

- (id)initWithContent:(NSString *)newContent withLevelFlag:(BFElementLevel)level withSubCount:(NSInteger)count;

@end
