//
//  BAFUitils.m
//  OPinion
//
//  Created by ZYVincent on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BFUitils.h"
#import "SBJson.h"
#import <CommonCrypto/CommonDigest.h>

@implementation BFUitils

//将身份证字符串拆解成单个字符组成得数组 ，方法是直接从c＋＋得方法里面得到的，用oc写出来而已
+ (NSMutableArray *)returnSingleFromNSString:(NSString *)sourceString
{
    NSString *subString = nil;
    NSString *subString2 = nil;
    NSMutableArray *resultArray = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    
    for (int i = 0; i< [sourceString length]; i++) {
        if (i == 0) {
            [resultArray addObject:[sourceString substringToIndex:1]];
        }else{
            subString2 = [sourceString substringFromIndex:i];
            subString = [subString2 substringToIndex:1];
            [resultArray addObject:subString];
        }
        
    }
    return resultArray;
}

+ (BOOL)checkIfPersonalIDNumber:(NSString *)IDNumber
{
    NSArray *factorArray = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1",@"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    NSArray *checkArray = [NSArray arrayWithObjects:@"1", @"0", @"10",@"9",@"8",@"7",@"6", @"5",@"4",@"3",@"2", nil];
    
    if ([IDNumber length] != 18) {
        return FALSE;
    }
    //将身份证号字符串分解成单个字符组成得数组
    NSMutableArray *resultArray = [self returnSingleFromNSString:IDNumber];
    
    //检查是否合法
    NSInteger checkSum = 0;
    NSInteger resultNumber;
    NSInteger checkIndex;
    NSInteger checkNumber;
    
    //校验身份证得方法，网络上找得，验证有效
    for ( int i = 0; i < 17; i++) {        
        checkSum += [[resultArray objectAtIndex:i] intValue] * [[factorArray objectAtIndex:i]intValue];
    }
    resultNumber = [[resultArray objectAtIndex:17]intValue];
    checkIndex = checkSum % 11;
    checkNumber = [[checkArray objectAtIndex:checkIndex]intValue];
    
    if (resultNumber == checkNumber || ([[resultArray objectAtIndex:17] isEqualToString:@"x"]&&[[checkArray objectAtIndex:checkIndex]intValue]== 10)) {
        return YES;
    }else{
        return FALSE;
    }
}
//返回当前时间
+ (NSString*)returnCurrentDateTime
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc]init]autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDateTime = [dateFormatter stringFromDate:[NSDate date]];
    
    return currentDateTime;
}
+(bool) urlExist:(NSString *) url{
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
	
	NSHTTPURLResponse *response;
	NSError *error;
	
	[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	int status = [response statusCode];
	[request release];
	//NSLog(@"Status = %d",status);
	return status == 200;
}
+(NSString *) pathForFileInDocument:(NSString *) file{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docPath = [paths objectAtIndex:0];
	return [docPath stringByAppendingPathComponent:file];
}

+ (NSString *) pathForFileInBundle:(NSString *) file{
	return [[NSBundle mainBundle] pathForResource:file ofType:nil];
}

+ (NSString *) pathForFile:(NSString *) file inBundle:(NSString *) bundle{
	return [[NSBundle bundleWithIdentifier:bundle] pathForResource:file ofType:nil];
}
+ (id) readPlist:(NSString *) file{
	NSString *path = [self pathForFileInBundle:file];
	NSFileManager *manager = [NSFileManager defaultManager];
	NSData *data = [manager contentsAtPath:path];
	NSPropertyListFormat f;
    
	return [NSPropertyListSerialization propertyListWithData:data options:0 format:&f error:nil];
}
+ (BOOL) fileExist:(NSString *) path{
	return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (BOOL) copyFile:(NSString *) spath to:(NSString *) dpath{
	return [[NSFileManager defaultManager] copyItemAtPath:spath toPath:dpath error:nil];
}
//计算某个日期与现在的时间差
+ (NSString *)intervalSinceNow:(NSString *)theDate
{
    //将字符串转化为指定日期
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    //该指定日期与1970年份的时间差
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    //获取当前日期
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    //当前日期与1970年份的时间差
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    //当前日期与1970年份时间差 减去 指定日期与1970年份时间差  之差
    NSTimeInterval cha=now-late;
    
    //时间差转化
    
    //60s * 60m = 1h 时间差不足一小时
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    // 60s * 60m * 24 = 1d 时间差超过一小时 且 不足一天
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    //时间差超过一天
    if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
        
    }
    [date release];
    return timeString;
}
+(NSString *) MD5:(NSString *) str{
	const char *cStr = [str UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5( cStr, strlen(cStr), result );
	return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
			];
	
}
+ (NSString *)convertArrayToString:(NSArray *)array{
	NSMutableString *string = [NSMutableString stringWithCapacity:0];
	for( NSInteger i=0;i<[array count];i++ ){
		[string appendFormat:@"%@%@",(NSString *)[array objectAtIndex:i], (i<([array count]-1))?@",":@""];
	}
	return string;
}

+ (NSArray *)convertStringToArray:(NSString *)string{
	return [string componentsSeparatedByString:@","];
}

+(NSString *)convertDictToJSON:(NSDictionary *)dict
{
    SBJsonWriter *writer = [[[SBJsonWriter alloc]init]autorelease];
    return [writer stringWithObject:dict];
}
+(NSDictionary *)convertJSONToDict:(NSString *)string
{
    SBJsonParser *parser = [[[SBJsonParser alloc]init]autorelease];
    return [parser objectWithString:string];
}
+(BOOL)validateEmail:(NSString *)candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    return [emailTest evaluateWithObject:candidate];
}
+ (BOOL)validateCellPhone:(NSString *)candidate{
	NSString *phoneRegex = @"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)"; 
	NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex]; 
	return [phoneTest evaluateWithObject:candidate];
}

+ (NSArray *)getLetters
{
	return [NSArray arrayWithObjects:@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
}

+ (NSArray *)getUpperLetters
{
	return [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
}

+ (CGFloat)getRGB:(NSInteger)value
{
	return value/255.0f;
}

+ (NSString *)md5:(NSString *)str{
	const char *concat_str = [str UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(concat_str, strlen(concat_str), result);
	NSMutableString *hash = [NSMutableString string];
	for (int i = 0; i < 16; i++){
		[hash appendFormat:@"%02X", result[i]];
	}
	return [hash lowercaseString];
	
}


+ (NSString *)getIPAddress
{
	NSString *address = @"Unknown";
	struct ifaddrs *interfaces = NULL;
	struct ifaddrs *temp_addr = NULL;
	int success = 0;
    
	// retrieve the current interfaces - returns 0 on success
	success = getifaddrs(&interfaces);
	if (success == 0)
	{
		// Loop through linked list of interfaces
		temp_addr = interfaces;
		while(temp_addr != NULL)
		{
			if(temp_addr->ifa_addr->sa_family == AF_INET)
			{
				// Check if interface is en0 which is the wifi connection on the iPhone
				if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
				{
					// Get NSString from C String
					address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
				}
			}
            
			temp_addr = temp_addr->ifa_next;
		}
	}
    
	// Free memory
	freeifaddrs(interfaces);
    
	return address;
}

+ (NSString *)getFreeMemory{
    mach_port_t host_port;
    mach_msg_type_number_t host_size;
    vm_size_t pagesize;
    
    host_port = mach_host_self();
    host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    host_page_size(host_port, &pagesize);        
    
    vm_statistics_data_t vm_stat;
    
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS)
        NSLog(@"Failed to fetch vm statistics");
    
    /* Stats in bytes */ 
    natural_t mem_used = (vm_stat.active_count +
                          vm_stat.inactive_count +
                          vm_stat.wire_count) * pagesize;
    natural_t mem_free = vm_stat.free_count * pagesize;
    //  natural_t mem_total = mem_used + mem_free;
    return [NSString stringWithFormat:@"%0.1f MB used/%0.1f MB free", mem_used/1048576.f, mem_free/1048576.f];
    //    NSLog(@"used: %u free: %u total: %u", mem_used, mem_free, mem_total);
}

+ (NSString *)getDiskUsed
{
    NSDictionary *fsAttr = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    float diskSize = [[fsAttr objectForKey:NSFileSystemSize] doubleValue] / 1073741824.f;
    float diskFreeSize = [[fsAttr objectForKey:NSFileSystemFreeSize] doubleValue] / 1073741824.f;
    float diskUsedSize = diskSize - diskFreeSize;
    return [NSString stringWithFormat:@"%0.1f GB of %0.1f GB", diskUsedSize, diskSize];
}
+ (CGFloat)getDistanceOfPoint1:(CGPoint)point1 Point2:(CGPoint)point2
{
    return sqrtf(powf(point1.x - point2.x, 2) + powf(point1.y - point2.y, 2));
}

+ (BOOL)createDirectory:(NSString *)direct
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *root = [paths objectAtIndex:0];
    
    NSFileManager *df = [NSFileManager defaultManager];
    if ([df createDirectoryAtPath:[root stringByAppendingPathComponent:direct] withIntermediateDirectories:NO attributes:nil error:nil]) {
        return YES;
    }
    return NO;
}

+ (NSString *)replaceNull:(id)source
{    
    if (source == nil) {
        return @"无内容";
    }
    //    NSLog(@"source :%@",source);
    
    
    NSString *result = nil;
    
    if ([source isKindOfClass:[NSNumber class]]) {
        result  = [NSString stringWithFormat:@"%d",[(NSNumber *)source intValue]];
    }
    
    else if ([source isKindOfClass:[NSNull class]]) {
        result = @"未知";
    }
    
    else if ([source isKindOfClass:[NSString class]]) {
        if ([(NSString *)source isEqualToString:@""]) {
            result = @"收到为空";
        }
        result = (NSString*)source;
    }
    
    return result;
}

+ (NSString *)returnFitlerString:(NSString *)sourceString
{
    
    //    NSLog(@"source :%@",sourceString);
    NSString *checkString = [self replaceNull:sourceString];
    
    NSMutableString *newString = [NSMutableString stringWithString:checkString];
    NSRange range = NSMakeRange(0, [newString length]);
    
    NSArray *checkArray = [NSArray arrayWithObjects:@"\\",@"\t",@"\r",@"&ldquo",@"&rdquo",@";",@"/",@"-",@"<em>",@"</em>",@"!",@"|", nil];
    
    for (int i=0 ; i<[checkArray count];i++) {
        [newString replaceOccurrencesOfString:[checkArray objectAtIndex:i] withString:@"" options:NSCaseInsensitiveSearch range:range];
        range = NSMakeRange(0,[newString length]);
    }
    
    NSArray *spaceArray = [NSArray arrayWithObjects:@"&nbsp",@"</br>",nil];
    for (int i=0 ; i<[spaceArray count];i++) {
        [newString replaceOccurrencesOfString:[spaceArray objectAtIndex:i] withString:@" " options:NSCaseInsensitiveSearch range:range];
        range = NSMakeRange(0,[newString length]);
    }
    
    NSArray *lineArray = [NSArray arrayWithObjects:@"<br>",nil];
    for (int i=0 ; i<[lineArray count];i++) {
        [newString replaceOccurrencesOfString:[lineArray objectAtIndex:i] withString:@"\n" options:NSCaseInsensitiveSearch range:range];
        range = NSMakeRange(0,[newString length]);
    }
    
    return newString;
}


+ (NSString*)returnFitlerStringWithReplaceSpace:(NSString *)sourceString
{
    //    NSLog(@"source :%@",sourceString);
    NSString *checkString = [self replaceNull:sourceString];
    
    NSMutableString *newString = [NSMutableString stringWithString:checkString];
    NSRange range = NSMakeRange(0, [newString length]);
    
    NSArray *checkArray = [NSArray arrayWithObjects:@"\\",@"\t",@"\r",@"&ldquo",@"&rdquo",@";",@"/",@"-",@"<em>",@"</em>",@"!",@"|",@"&nbsp",@"<br>",@"</br>",@"&bull",@" ",@"\n",nil];
    
    for (int i=0 ; i<[checkArray count];i++) {
        [newString replaceOccurrencesOfString:[checkArray objectAtIndex:i] withString:@"" options:NSCaseInsensitiveSearch range:range];
        range = NSMakeRange(0,[newString length]);
    }
    
    return newString;
}

+ (NSString *)returnFitlerSpace:(NSString *)sourceString
{
    NSString *checkString = [self replaceNull:sourceString];
    
    return [checkString stringByReplacingOccurrencesOfString:@" " withString:@""];
}


+ (UIView*)viewFromNibWithName:(NSString *)name owner:(id)owner
{
    return [[[NSBundle mainBundle]loadNibNamed:name owner:owner options:nil]objectAtIndex:0];
}

+ (BOOL)isIOSVersionOver5
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>5.0) {
        return YES;
    }else {
        return NO;
    }
}

+ (UIImage*)streghtImageWithName:(NSString *)imageName
{
    return [[UIImage imageNamed:imageName]stretchableImageWithLeftCapWidth:2 topCapHeight:2];
}

+ (UIImage*)streghtImage:(UIImage *)image
{
    return [image stretchableImageWithLeftCapWidth:2 topCapHeight:2];
}

+ (UIColor*)rgbColor:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}

+ (void)clearBlurryForSubView:(UIView *)subView
{
    CGRect newTitleFrame = subView.frame;
    CGFloat newOffX = round(newTitleFrame.origin.x);
    CGFloat newOffY = roundf(newTitleFrame.origin.y);
    subView.frame = CGRectMake(newOffX,newOffY,newTitleFrame.size.width,newTitleFrame.size.height);
}

@end
