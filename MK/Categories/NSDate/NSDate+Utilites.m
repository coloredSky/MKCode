//
//  NSDate+Utilites.m
//  XHBorrow
//
//  Created by caoyong on 2018/10/11.
//  Copyright © 2018年 caoyong. All rights reserved.
//
// 北京时间时区
#define BeiJingTimeZone  @"Asia/BeiJing"

#import "NSDate+Utilites.h"

@implementation NSDate (Utilites)

+ (NSString *)getCurrentTimeWithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:BeiJingTimeZone]];
    dateFormatter.calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSString *time = [dateFormatter stringFromDate:[NSDate date]];
    return time;
}

+(NSString *)getCurrentTime:(NSString *)shijianchuo
{
    //1. 获取当前系统的准确事件(+8小时)
    NSDate *date = [NSDate date]; // 获得时间对象
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
    NSDate *dateNow = [date dateByAddingTimeInterval:time];// 然后把差的时间加上,就是当前系统准确的时间
    //2. 获取当前系统事件并设置格式
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    [forMatter setDateFormat:shijianchuo];
    NSString *dateStr = [forMatter stringFromDate:dateNow];
    return dateStr;
}


+ (NSTimeInterval)getTimerIntervalSince1970
{
    return [[NSDate date] timeIntervalSince1970];
}

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:BeiJingTimeZone];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    if (date==nil) {
        timeSp = 0;
    }
    return timeSp;
}

+ (NSTimeInterval)timeIntervalByDateString:(NSString *)dateString
                            withDateFormat:(NSString *)dateFormat{
    NSTimeInterval timeInterval = [[self dateStringToDateWithDateFormat:dateFormat dateString:dateString] timeIntervalSince1970];
    return timeInterval;
}

+ (NSDate *) dateStringToDateWithDateFormat:(NSString *)dateFormat
                                 dateString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat;
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}
+(NSString *)getDateFormMillisecondTimeInterval:(NSString *)timeintervalString withDateFormat:(NSString *)dateFormat
{
    if (!timeintervalString) {
        return @"";
    }
    double timeinterval = [timeintervalString doubleValue];
    if (timeinterval < 1000.00)
    {
        return @"";
    }
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    [forMatter setDateFormat:dateFormat];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970: timeinterval/1000];
    NSString *resultString = [forMatter stringFromDate:date];
    return resultString;
}
+(NSString *)getDistanceTimeFromMillisecondTimeInterval:(NSString *)timeintervalString
{
    if (!timeintervalString)
    {
        return @"";
    }
    double timeInteval = [timeintervalString doubleValue];
    if (timeInteval < 1000.00)
    {
        return @"刚刚";
    }
    double beTime = timeInteval/1000;
    NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
    double distanceTime = now - beTime;
    NSString * distanceStr;
    
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm"];
    NSString * timeStr = [df stringFromDate:beDate];
    
    [df setDateFormat:@"dd"];
    NSString * nowDay = [df stringFromDate:[NSDate date]];
    NSString * lastDay = [df stringFromDate:beDate];
    
    if (distanceTime < 60) {//小于一分钟
        distanceStr = @"刚刚";
    }
    else if (distanceTime <60*60) {//时间小于一个小时
        distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
    }
    else if(distanceTime <24*60*60 && [nowDay integerValue] == [lastDay integerValue]){//时间小于一天
        distanceStr = [NSString stringWithFormat:@"今天 %@",timeStr];
    }
    else if(distanceTime<24*60*60*2 && [nowDay integerValue] != [lastDay integerValue]){
        
        if ([nowDay integerValue] - [lastDay integerValue] ==1 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1)) {
            distanceStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
        }
        else{
            [df setDateFormat:@"MM-dd HH:mm"];
            distanceStr = [df stringFromDate:beDate];
        }
        
    }
    else if(distanceTime <24*60*60*365){
        [df setDateFormat:@"MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    else{
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    return distanceStr;
}

+(NSInteger )compareDatefromCurrentDateWithDate:(NSString *)compareDateString dateFormatter:(NSString *)dateFormatterString
{
    if ([NSString isEmptyWithStr:dateFormatterString]) {
        return -1;
    }
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:dateFormatterString];
    NSDate *compareDate = [formatter dateFromString:compareDateString];
    NSTimeInterval compareDateTimeInterval =  [compareDate timeIntervalSinceNow];
    if (compareDateTimeInterval > 0) {
        return 1;
    }else if(compareDateTimeInterval == 0){
        return 0;
    }else{
        return -1;
    }
}
@end
