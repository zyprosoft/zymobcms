//
//  BFNetDataLoadOperation.h
//  OPinion
//
//  Created by ZYVincent on 12-7-24.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface BFNetDataLoadOperation : NSOperation
{
    NSURL *_url;
    
    id _delegate;
    
}
- (id)initWithUrl:(NSURL *)url withFinishDelegate:(id)aDelegate;
@end
