//
//  NSString+SizeOfString.m
//  WeiBoDemoEasy
//
//  Created by HB on 15/3/26.
//  Copyright (c) 2015年 Sh. All rights reserved.
//

#import "NSString+SizeOfString.h"

@implementation NSString (SizeOfString)
-(CGSize)getStrSizeWithSize:(CGSize)size font:(UIFont *)font
{
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
    return rect.size;
}
-(float)getStrWidthWithfont:(UIFont *)font
{
    CGSize size = [self sizeWithAttributes:@{NSFontAttributeName:font}];
    return size.width;
}
-(CGSize)getStrSizeWithSize:(CGSize)size withLineSpacValue:(float)lineSpace  andWordSpace:(float)wordSpace withFont:(UIFont*)font
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpace;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@(wordSpace)
                          };
    CGSize strSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return strSize;
}
@end
