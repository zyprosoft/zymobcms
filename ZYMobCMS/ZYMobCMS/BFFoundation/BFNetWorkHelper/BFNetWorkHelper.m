//
//  BAFNetWorkHelper.m
//  OPinion
//
//  Created by ZYVincent on 12-7-19.
//  Copyright (c) 2012年 __barfoo__. All rights reserved.
//

#import "BFNetWorkHelper.h"
#import "NSDictionary+UrlEncodedString.h"
#import "NSString+UrlCombine.h"
#import "CJSONDeserializer.h"
#import "JSONKit.h"
#import "ZYGlobalConfig.h"

static BFNetWorkHelper *_instance = nil;

@interface BFNetWorkHelper(PrivateMethod)
- (void)requestDone:(ASIFormDataRequest *)request;
- (void)requestWentFaild:(ASIFormDataRequest *)request;

@end

@implementation BFNetWorkHelper
@synthesize requestTimeoutInterval;

+ (BFNetWorkHelper *)shareHelper
{
    @synchronized(self){
        if (!_instance) {
            _instance = [[self alloc]init];
        }
    }
    return _instance;
}

#pragma mark - life cycle
- (id)init{
    self = [super init];
    if (self) {
        self.requestTimeoutInterval = 20;
        _connectionsForCallBackDict = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}
- (void)dealloc{
    
    [_connectionsForCallBackDict release];
    [super dealloc];
}

- (void)alertWithErrorCode:(NSInteger)errorCode
{
    NSString *errorMessage = nil;
    switch (errorCode) {
        case NSURLErrorBadURL:
            errorMessage = @"网络地址无效";
            break;
        case NSURLErrorCannotConnectToHost:
            errorMessage = @"服务器没有响应";
            break;
        case NSURLErrorCannotFindHost:
            errorMessage = @"无法找到指定主机";
            break;
        case NSURLErrorCannotParseResponse:
            errorMessage = @"无法解析回复";
            break;
        case NSURLErrorBadServerResponse:
            errorMessage = @"错误得服务器返回";
            break;
            
        default:
            errorMessage = nil;
            break;
    }
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"网络错误" message:errorMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

//合成请求接口地址
- (NSURL *)urlWithRequestType:(MBCRequestType)requestType
{
    NSURL *requestUrl = nil;
    
    //合成接口地址
    switch (requestType) {
            
                    
        default:
            break;
    }
    
    return requestUrl;
}


- (NSString *)pulicParams
{
    NSMutableString *turl = [NSMutableString stringWithCapacity:50];
    
    return turl;//[[Passport getCurrentUser]urlEncodedString];
}


#pragma mark - request method
//符合当前Opinion得请求类型
- (NSString*)requestDataWithApplicationType:(MBCRequestType)requestType withParams:(NSDictionary *)params withHelperDelegate:(id)CallBackDelegate withSuccessRequestMethod:(NSString *)successMethod withFaildRequestMethod:(NSString *)faildMethod
{
    
    //如果没有链接网络
    if (![BFNetWorkChecker isConnectedToNetWork]) {
        
        [CallBackDelegate performSelector:NSSelectorFromString(faildMethod) withObject:@"noNetwork" afterDelay:0.0f ];
        
        return nil;
    }
    
    //build URL with Requestion type
    NSURL *requestUrl = nil;
    //get url
    requestUrl = [self urlWithRequestType:requestType];
    
    //use url with function :RequestionMethod 
    //接收callbackDelegate 和 成功调用方法 失败调用方法
    NSMutableDictionary *callBackDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:CallBackDelegate,@"delegate",successMethod,@"success",faildMethod,@"faild",params,@"params", nil];
    
    //处理params
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSString *finalUrl = nil;
    //没有参数时附加公共参数
    NSString *string = paramDict ? [paramDict urlEncodedString] : @"";//编码成http页面能够接受得参数
    
    finalUrl = [NSString stringWithFormat:@"%@%@%@", [requestUrl absoluteString], [self pulicParams], string];
    

    //生成正确得请求地址
    requestUrl = [NSURL URLWithString:finalUrl];
    //设置请求参数
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:requestUrl];
    //https
    [request setValidatesSecureCertificate:NO];
    
    request.timeOutSeconds = self.requestTimeoutInterval;
    request.RequestType = requestType;
    request.requestFlagMark = [self getTimeStamp];
    request.responseEncoding = NSUTF8StringEncoding;
    [_connectionsForCallBackDict setObject:callBackDict forKey:request.requestFlagMark];
    
    request.delegate = self;
    [request setDidFailSelector:@selector(requestWentFaild:)];
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setRequestMethod:@"GET"];
    [request startAsynchronous];
    
    return request.requestFlagMark;
}

#pragma mark -
#pragma mark requestMethod

//请求数据
- (void)requestDataFromURL:(NSString *)url withParams:(NSDictionary *)params withHelperDelegate:(id)CallBackDelegate withSuccessRequestMethod:(NSString*)successMethod withFaildRequestMethod:(NSString*)faildMethod
{
    //check if there have network
    if(![BFNetWorkChecker isConnectedToNetWork])
    {
        [SVProgressHUD showErrorWithStatus:@"没有网络链接"];
        return;
    }
    //接收callbackDelegate 和 成功调用方法 失败调用方法
    NSMutableDictionary *callBackDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:CallBackDelegate,@"delegate",successMethod,@"success",faildMethod,@"faild", nil];
    
    NSDictionary *paramDict = params;
    NSMutableData *paramData = [NSMutableData data];
    NSMutableString *paramString = [NSMutableString string];
    //处理params
    if (nil == params) {
        
    }else{
        
        for (id key in [paramDict keyEnumerator]) {
            NSString *string = [NSString stringWithFormat:@"\"%@\":\"%@,",key,[params valueForKey:key]];
            [paramString appendString:string];
            
        }
        [paramData appendData:[[NSString stringWithFormat:@"{%@",paramString] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    //设置请求参数
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    request.timeOutSeconds = self.requestTimeoutInterval;
    request.RequestType = 8888;
    request.requestFlagMark = [self getTimeStamp];
    request.responseEncoding = NSUTF8StringEncoding;
    [_connectionsForCallBackDict setObject:callBackDict forKey:request.requestFlagMark];
    
    
    request.delegate = self;
    [request setDidFailSelector:@selector(requestWentFaild:)];
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setRequestMethod:@"GET"];
    [request startAsynchronous];
}

#pragma mark - request method
- (void)requestDone:(ASIFormDataRequest *)request
{
    NSData *data = [request responseData];
    NSDictionary *result = [data objectFromJSONData];
    
    NSDictionary *targetCallBack = [_connectionsForCallBackDict objectForKey:request.requestFlagMark];
    [[targetCallBack objectForKey:@"delegate"] performSelector:NSSelectorFromString([targetCallBack objectForKey:@"success"]) withObject:result];
    
	[_connectionsForCallBackDict removeObjectForKey:request.requestFlagMark];
    
    //隐藏网络请求提示
    if ([[_connectionsForCallBackDict allKeys]count]==0) {
        
        [ASIHTTPRequest hideNetworkActivityIndicator];
    }
}

- (void)requestWentFaild:(ASIFormDataRequest *)request
{
    NSDictionary *targetCallBack = [_connectionsForCallBackDict objectForKey:request.requestFlagMark];
	NSLog(@"request %@ went wrong with status code %d, and feedback body %@",request.requestFlagMark, [request responseStatusCode], [request responseString]);
    NSString *tips = @"connection error";
    //check if there have network
//    if(![BFNetWorkChecker isConnectedToNetWork])
//    {
//        tips = nil;
//    }
	[[targetCallBack objectForKey:@"delegate"] performSelector:NSSelectorFromString([targetCallBack objectForKey:@"faild"]) withObject:tips];
	[_connectionsForCallBackDict removeObjectForKey:request.requestFlagMark];
}

-(NSString *)getTimeStamp{
	NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
	return [NSString stringWithFormat:@"%u",timestamp];
}

//退出某个请求
- (void)cancelRequestWithTimeStamp:(NSString *)timeStamp
{
    //如果时间戳是空得,什么都不做
    if (timeStamp==nil) {
        return;
    }
    
    NSInteger condition = 1;
    NSConditionLock *lock = [[NSConditionLock alloc]initWithCondition:condition];
    [lock tryLockWhenCondition:1];
    
    //如果链接已经完成了
    if (![[_connectionsForCallBackDict allKeys]containsObject:timeStamp]) {
        return;
    }
    
    NSDictionary *callBackDict = [_connectionsForCallBackDict objectForKey:timeStamp];
    
    //如果链接没有完成还存在
    if (callBackDict) {
        
        ASIHTTPRequest *request = [callBackDict objectForKey:timeStamp];
        
        //退出请求
        [request clearDelegatesAndCancel];
        
        NSLog(@"finish cancel request by timeStamp ++++>>>>>>> :%@",timeStamp);
        
        [_connectionsForCallBackDict removeObjectForKey:timeStamp];
        
    }
    
    condition = 0;
    [lock unlockWithCondition:0];
    [lock release];
}


@end
