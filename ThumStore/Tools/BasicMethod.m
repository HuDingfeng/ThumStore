    //
//  BasicMethod.m
//
//
//  Created by huDingfeng on 15-6-29.
//  Copyright (c) 2015年 huDingfeng. All rights reserved.
//

#import "BasicMethod.h"
//#import "MyMD5.h"
#import "TimeTool.h"
@implementation BasicMethod

//当前时间---->时间戳
+(NSString*)createCurrentTimeToTimestamp
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];
   // 时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
}


//时间戳---->时间
+(NSString*)parsingTheTimestamp:(NSString *)timestamp type:(timeStampType)type
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    
    if (type == withSecond)
    {
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    else if (type == dateOnlyHorizonLine)
    {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    else if (type == dateOnlySlashLine)
    {
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    }
    NSDate *theday = [NSDate dateWithTimeIntervalSince1970:[timestamp floatValue]];
    NSString *day = [dateFormatter stringFromDate:theday];
    
    return day;
}

//+(NSString*)encryptionStr:(NSString *)str
//{
//    NSString * tmpStr = [NSString stringWithFormat:@"%@%@",str,@"YaoYao@2015"];
//    tmpStr = [MyMD5 md5:tmpStr];
//    return tmpStr;
//}

+(NSString*)calculateString:(NSString*)string
{
    NSMutableString *numberString = [NSMutableString stringWithString:string];
    NSString *valueString;
    NSRange range = [numberString rangeOfString:@"."];
    NSInteger i = range.location!=NSNotFound?range.location:[numberString length];
    while (i > 2) {
        i = i -3;
        [numberString insertString:@"," atIndex:i];
    }
    if([numberString hasPrefix:@","])
    {
        valueString = [numberString substringFromIndex:1];
    }
    else
    {
        valueString = [NSString stringWithFormat:@"%@",numberString];
    }
    return valueString;
}
/*
//压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
 */

-(NSDate *)getDateTimeFromMilliSeconds:(long long) miliSeconds{
    NSTimeInterval tempMilli = miliSeconds; NSTimeInterval seconds = tempMilli/1000.0; NSLog(@"seconds=%f",seconds);
    return [NSDate dateWithTimeIntervalSince1970:seconds];

}

//将NSDate类型的时间转换为NSInteger类型,从1970/1/1开始
-(long long)getDateTimeTOMilliSeconds:(NSDate *)datetime{
    NSTimeInterval interval = [datetime timeIntervalSince1970]; NSLog(@"interval=%f",interval); long long totalMilliseconds = interval*1000 ;
    NSLog(@"totalMilliseconds=%llu",totalMilliseconds);
    return totalMilliseconds;
}

+(NSString *)intervalSinceNow: (NSTimeInterval)theDate
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    
    NSString *timeString=@"";
    
    NSTimeInterval cha = now - theDate/1000;
    double interval = cha;
    if (interval/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", interval/60.f];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        
    }
    if (interval/3600>1&&interval/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", interval/3600.f];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    if (interval/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f", interval/86400.f];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
        
    }
    return timeString;
}

+(NSString *)getUniqueStrByUUID {
    
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef= CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *retStr = [NSString stringWithString:[NSString stringWithFormat:@"%@",uuidStrRef]];
    CFRelease(uuidStrRef);
    return retStr;
}

+(NSString *)getSaveValue:(NSDictionary *)dict ForKey:(NSString *)key
{
    if ([dict.allKeys containsObject:key]) {
        return [dict objectForKey:key];
    }else{
        return @"";
    }
}
@end
