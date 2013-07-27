//
//  BAFUitils.h
//  OPinion
//
//  Created by ZYVincent on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <mach/mach.h>
#import <mach/mach_host.h>

#define IS_IPHONE_5 ([UIScreen mainScreen].bounds.size.height == 568.0)

@interface BFUitils : NSObject

//验证身份证号是否合法
+ (BOOL)checkIfPersonalIDNumber:(NSString *)IDNumber;
+ (NSString*)returnCurrentDateTime;
+ (bool) urlExist:(NSString *) url;
+ (NSString *) MD5:(NSString *) str;
+ (NSString *) pathForFileInDocument:(NSString *) file;
+ (NSString *) pathForFileInBundle:(NSString *) file;
+ (NSString *) pathForFile:(NSString *) file inBundle:(NSString *) bundle;
+ (id) readPlist:(NSString *) file;
+ (BOOL) fileExist:(NSString *) path;
+ (BOOL) copyFile:(NSString *) spath to:(NSString *) dpath;
//---- 计算某个日期与现在的时间差 -----//
+ (NSString*)intervalSinceNow:(NSString*)theDate;
+ (NSString *)convertArrayToString:(NSArray *)array;
+ (NSArray *)convertStringToArray:(NSString *)string;
+ (NSString *)convertDictToJSON:(NSDictionary *)dict;
+ (NSDictionary *)convertJSONToDict:(NSString *)string;
+ (BOOL)validateEmail:(NSString *)candidate;
+ (BOOL)validateCellPhone:(NSString *)candidate;
+ (NSString *)getIPAddress;
+ (NSArray *)getLetters;
+ (NSArray *)getUpperLetters;
+ (CGFloat)getRGB:(NSInteger)value;
+ (NSString *)getFreeMemory;
+ (NSString *)getDiskUsed;
+ (CGFloat)getDistanceOfPoint1:(CGPoint)point1 Point2:(CGPoint)point2;


//
+ (BOOL)createDirectory:(NSString *)direct;

+ (NSString *)returnFitlerString:(NSString *)sourceString;
+ (NSString *)returnFitlerSpace:(NSString *)sourceString;

+ (NSString *)returnFitlerStringWithReplaceSpace:(NSString*)sourceString;

+ (UIView*)viewFromNibWithName:(NSString*)name owner:(id)owner;

+ (BOOL)isIOSVersionOver5;

//返回拉伸图片
+ (UIImage*)streghtImageWithName:(NSString*)imageName;

+ (UIImage*)streghtImage:(UIImage*)image;

//RGB Color
+ (UIColor*)rgbColor:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

//取消系统的模糊bug
+ (void)clearBlurryForSubView:(UIView*)subView;
@end
