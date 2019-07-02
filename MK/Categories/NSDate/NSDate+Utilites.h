//
//  NSDate+Utilites.h
//  XHBorrow
//
//  Created by caoyong on 2018/10/11.
//  Copyright © 2018年 caoyong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Utilites)
/**
  * 通过给的格式获取当前时间
  *
  * @param format 时间格式， 如 YYYY-MM-dd HH:mm:ss
  *
  * @return 当前时间
  */
+ (NSString *)getCurrentTimeWithFormat:(NSString *)format;

/**
 * 获取当前时间戳
 */
+ (NSTimeInterval) getTimerIntervalSince1970;

/**
 * 通过具体时间获取时间戳
 *
 * @param formatTime 具体时间，是距离1970年到当前的秒
 *
 * @return 时间戳
 */
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

/**
 *  @author Yan deguang, 16-07-21 10:07:10
 *
 *  将时间字符串转化成时间戳
 *
 *  @param dateString 时间字符串，如：2016-07-21 10:10:21
 *  @param dateFormat 时间字符串格式，必须与所给定时间字符串格式一样，如：yyyy-MM-dd HH:mm:ss
 *
 *  @return 时间字符串对应的时间戳
 */

+ (NSTimeInterval)timeIntervalByDateString:(NSString *)dateString
                            withDateFormat:(NSString *)dateFormat;

/**
 由毫秒时间戳得到时间

 @param timeintervalString 毫秒时间戳
 @param dateFormat 时间格式
 @return 时间
 */
+(NSString *)getDateFormMillisecondTimeInterval:(NSString *)timeintervalString withDateFormat:(NSString *)dateFormat;

/**
 由毫秒时间戳得到距离当前的时间 ： 刚刚 n小时前 n天前

 @param timeintervalString 传入的时间戳
 @return 时间
 */
+(NSString *)getDistanceTimeFromMillisecondTimeInterval:(NSString *)timeintervalString;


/**
 与当前的时间比较

 @param compareDateString 比较的时间
 @param dateFormatterString 比较时间的格式
 @return 结构 1： 没有过期  0： 和现在的时间相等 -1：过期
 */
+(NSInteger )compareDatefromCurrentDateWithDate:(NSString *)compareDateString dateFormatter:(NSString *)dateFormatterString;
@end

NS_ASSUME_NONNULL_END
