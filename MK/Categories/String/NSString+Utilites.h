//
//  NSString+Utilites.h
//  XHBorrow
//
//  Created by caoyong on 2018/9/26.
//  Copyright © 2018年 caoyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utilites)

/**
 * @param currentStr 判断对象
 *
 * return BOOL 是否为空状态
 **/
+(BOOL)isEmptyWithStr:(NSString*)currentStr;

/**
 * @param mobile 手机号码
 *
 * return  BOOL  判断是否是是手机号码
 */
+ (BOOL)valiMobile:(NSString *)mobile;
/**
 * @param mobileNum 手机号码
 *
 * return  BOOL  判断是否是是座机号码
 */
+(BOOL)isTelPhoneNumber:(NSString *)mobileNum;
/**
 * @param number 手机号码
 *
 * return 判断手机号是否有用
 */
+(BOOL)isPhoneNumber:(NSString*)number;
/**
 *  md5加密对应的字符串
 *
 * @param inPutText 需要加密的字符串
 *
 * @return 返回用md5 加密后的字符串
 */
+(NSString *)md5Tranform:(NSString *)inPutText;
/**
 * 将传入对应的URL进行URL的Encode返回
 *
 * @param unencodedString 编码原URL
 */
+(NSString*)encodeString:(NSString*)unencodedString;
/**
 * 将传入对应的URL进行URL的Decode返回
 *
 * @param encodedString 编码原URL
 */
+(NSString *)decodeString:(NSString*)encodedString;
/**
 * 判断输入的卡号是否有效
 * @param cardNum 输入的卡号
 */
+(BOOL)isBankCardNumber:(NSString *)cardNum;
/**
 * 获取设备型号
 * @return 设备型号
 */
+ (NSString*)deviceModelName;

/*!
 * 忽略特殊字符
 *
 * @return common String
 */
+(NSString *)ignoreSpecialCharWithTransString:(NSString *)transString;

/*!
 过滤HTML中的特殊字符
 @param html htmlString
 @return 过滤后的字符
 */
+(NSString *)filterHTML:(NSString *)html;

/*!
 字符串加星号
 @param originalStr 待处理的字符
 @param startLocation 开始的位置
 @param lenght 结束的位置
 @return 处理后的字符
 */
+(NSString *)replaceStringWithAsterisk:(NSString *)originalStr startLocation:(NSInteger)startLocation lenght:(NSInteger)lenght;


/**
 验证f身份证
 @param value 身份证string
 */
+ (BOOL)validateIDCardNumber:(NSString *)value;


/**
 字符串中的targetString改变大小

 @param str 需要改变文字大小的字符
 @param font font
 @return 改变g后的字符
 */
-(NSAttributedString *)attributStrWithTargetStr:(NSString *)str font:(UIFont *)font;
- (NSAttributedString *)attributStrWithTargetStr:(NSString *)str color:(UIColor *)color;
- (NSAttributedString *)attributStrAddUnderlineWithTargetStr:(NSString *)str;

/**
 改变字符串的大小 颜色

 @param fontStr 需要改变大小的字符
 @param font 字体大小
 @param colorStr 需要改变z颜色的字符
 @param color 颜色
 @return 改变后的字符
 */
- (NSAttributedString *)attributStrWithFontTargetStr:(NSString *)fontStr font:(UIFont *)font andColorTargetStr:(NSString *)colorStr color:(UIColor *)color;


/**
 字符串自定义行间距 字间距

 @param text 字符串
 @param lineSpace 行间距
 @param wordSpace 字间距
 @param font 字符大小
 @return 结果字符
 */
+(NSAttributedString *)setStringSpaceWithText:(NSString *)text  andLineSpacValue:(float)lineSpace  andWordSpace:(float)wordSpace withFont:(UIFont*)font;

/**
 *  将日期格式化为NSString对象
 *
 *  @param date    时间对象
 *  @param formate 时间格式
 *
 *  @return 时间字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date formate:(NSDateFormatter *)formate;


/**
 秒转分钟  00:00:00 或 00:00

 @param secondsString 秒
 @return 转化后的字符
 */
+(NSString *)stringTurnSecondsStringIntoMinutesString:(NSString *)secondsString;

/**
 时间字符串转星期几

 @param dateString 时间字符
 @param dateFormatString 时间字符的格式
 @return 星期几
 */
+(NSString *)weekdayStringWithDateString:(NSString *)dateString  andDateFormatString:(NSString *)dateFormatString;

/**
 时间格式转换

 @param dateStr 需要转换的时间字符
 @param formModel 转换字符的时间格式
 @param toModel 转换后的时间格式
 @return 字符串
 */
+(NSString*)timeTransformWithDate:(NSString *)dateStr  WithFormModel:(NSString *)formModel toModel:(NSString *)toModel;


/**
 给HTML字符串转译

 @param htmlString 传入的HTML字符
 @return 返回转以后的字符
 */
+(NSString *)htmlStringTransToString:(NSString *)htmlString;


/**
 获取APP名字

 @return APP名字
 */
+(NSString *)getAppName;
/**
 得到APP版本号
 */
+(NSString *)getAppVersion;

+ (NSInteger)compareVersion:(NSString *)v2;
@end
