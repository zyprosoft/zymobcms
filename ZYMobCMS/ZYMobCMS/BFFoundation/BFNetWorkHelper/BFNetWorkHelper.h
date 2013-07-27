//
//  BAFNetWorkHelper.h
//  OPinion
//
//  Created by ZYVincent on 12-7-19.
//  Copyright (c) 2012年 __barfoo__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "NetWorkConst.h"
#import "BFNetWorkChecker.h"


typedef enum {
    MBCRequestTypeLogin = 0,
    MBCRequestTypeRigist,
    
}MBCRequestType;

@interface BFNetWorkHelper : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,ASIHTTPRequestDelegate>
{
@private    
    NSTimeInterval requestTimeoutInterval;
    
    NSMutableDictionary *_connectionsForCallBackDict;
    
}
@property (nonatomic)NSTimeInterval requestTimeoutInterval;

+ (BFNetWorkHelper *)shareHelper;

- (NSString *)getTimeStamp;

- (void)cancelRequestWithTimeStamp:(NSString*)timeStamp;

//为特定应用程序请求数据
- (NSString*)requestDataWithApplicationType:(MBCRequestType)requestType 
                            withParams:(NSDictionary *)params 
                    withHelperDelegate:(id)CallBackDelegate 
              withSuccessRequestMethod:(NSString *)successMethod 
                withFaildRequestMethod:(NSString *)faildMethod;

//请求某个网络地址数据
- (void)requestDataFromURL:(NSString*)url 
                withParams:(NSDictionary*)params 
        withHelperDelegate:(id)CallBackDelegate 
  withSuccessRequestMethod:(NSString*)successMethod 
    withFaildRequestMethod:(NSString*)faildMethod;


@end
