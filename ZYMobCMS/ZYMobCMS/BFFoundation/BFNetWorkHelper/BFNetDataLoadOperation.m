//
//  BFNetDataLoadOperation.m
//  OPinion
//
//  Created by ZYVincent on 12-7-24.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import "BFNetDataLoadOperation.h"
#import "CJSONDeserializer.h"

@implementation BFNetDataLoadOperation

- (id)initWithUrl:(NSURL *)url withFinishDelegate:(id)aDelegate
{
    if (self = [super init]) {
        
        _delegate = [aDelegate retain];
        
        _url = [url retain];
        
        
    }
    return self;
}
- (void)dealloc{
    [_delegate release];
    [_url release];
    [super dealloc];
}

- (NSObject *)requestUrlData
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:_url];
    request.timeOutSeconds = 30.0;
    
    NSError *error = [request error];
    NSDictionary *result = nil;
    
    [request startSynchronous];
    
    if (!error) {
        
        NSString *resopnse = [request responseString];
        BFLogObject(resopnse);
        
        if (resopnse) {
            NSData *jsonData = [resopnse dataUsingEncoding:NSUTF8StringEncoding];
            BFLogObject(resopnse);
            
            NSError *jerror = nil;
            result = [[CJSONDeserializer deserializer]deserialize:jsonData error:&jerror];
            if (jerror) {
                NSLog(@"this data is not format json data");
                return error;   
            }
            BFMLog(result);
            return result;
        }
        return error;
    }else {
        return error;
    }
}

- (void)main
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    if (_delegate == nil) {
        NSAssert(_delegate = nil,@"delegate can't be nil");
        return;
    }
    if (_url == nil) {
        NSAssert(_url == nil,@"url can't be nil");
        return;
    }
    
    NSObject *resultObj = [self requestUrlData];
    
    if ([resultObj isKindOfClass:[NSError class]]) {
        if (_delegate && [_delegate respondsToSelector:@selector(operationFaildLoadData:)]) {
            [_delegate performSelector:@selector(operationFaildLoadData:) withObject:self];
        }
    }
    if ([resultObj isKindOfClass:[NSDictionary class]]) {
        if (_delegate && [_delegate respondsToSelector:@selector(operation:finishLoadData:)]) {
            [_delegate performSelector:@selector(operation:finishLoadData:) withObject:self withObject:resultObj];
        }
    }
    [pool drain];
}

@end
