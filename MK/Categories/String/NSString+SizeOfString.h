//
//  NSString+SizeOfString.h
//  WeiBoDemoEasy
//
//  Created by HB on 15/3/26.
//  Copyright (c) 2015年 Sh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (SizeOfString)

/**
 得到多行字符串高度

 @param size text所在的范围
 @param font 字体大小
 @return 字符串的size
 */
-(CGSize)getStrSizeWithSize:(CGSize)size font:(UIFont *)font;
/**
 得到单行字符的长度

 @param font 字体大小
 @return 字符的长度
 */
-(float)getStrWidthWithfont:(UIFont *)font;

/**
 得到自定义行间距的多行字符高度

 @param size text绘制的范围
 @param lineSpace 行间距
 @param wordSpace 字体间距
 @param font 字体大小
 @return text的高度
 */
-(CGSize)getStrSizeWithSize:(CGSize)size withLineSpacValue:(float)lineSpace  andWordSpace:(float)wordSpace withFont:(UIFont*)font;

@end
