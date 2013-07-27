//
//  BFDataActiveMonitor.m
//  OPinion
//
//  Created by ZYVincent on 12-8-1.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import "BFDataActiveMonitor.h"

@implementation BFDataActiveMonitor



+ (BOOL)writeDataActiveActionToFile:(NSString *)action
{
    NSString *actionTime = [BFUitils returnCurrentDateTime];
    
    NSString *log = [NSString stringWithFormat:@"%@ do at ====> %@",action,actionTime];
    
    NSData *logData = [log dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *filePath = [BFUitils pathForFileInDocument:BFDATALOGFILE];
        
    
    BOOL isWirte = [logData writeToFile:filePath atomically:YES];
        
    if (isWirte) {
        return YES;
    }
    return NO;
    
}

+(void)showAllActiveLogNow
{
    NSString *filePath = [BFUitils pathForFileInDocument:BFDATALOGFILE];
    
    NSString *logString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    if (logString != nil) {
        NSLog(@"%@",logString);
    }
}

@end
