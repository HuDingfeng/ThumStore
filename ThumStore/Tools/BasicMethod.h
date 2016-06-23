//
//  BasicMethod.h
//  YAOYAO
//
//  Created by huDingfeng on 15-6-29.
//  Copyright (c) 2015年 huDingfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    withSecond = 0,
    dateOnlyHorizonLine ,
    dateOnlySlashLine
} timeStampType;


@interface BasicMethod : NSObject

/* 时间------>时间戳 */
+(NSString*)createCurrentTimeToTimestamp;

/* 时间戳------>时间 */
+(NSString*)parsingTheTimestamp:(NSString*)timestamp type:(timeStampType)type;

+(NSString*)calculateString:(NSString*)string;

+(NSString*)encryptionStr:(NSString *)str;

//计算时间差
+(NSString *)intervalSinceNow: (NSTimeInterval) theDate;
//获取UUID
+(NSString *)getUniqueStrByUUID;

+(NSString *)getSaveValue:(NSDictionary *)dict ForKey:(NSString *)key;
@end
