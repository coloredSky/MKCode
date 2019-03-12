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

-(NSAttributedString *)attributStrWithTargetStr:(NSString *)str font:(UIFont *)font;
- (NSAttributedString *)attributStrWithFontTargetStr:(NSString *)fontStr font:(UIFont *)font andColorTargetStr:(NSString *)colorStr color:(UIColor *)color;
@end
