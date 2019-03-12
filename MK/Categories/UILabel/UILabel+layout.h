//
//  UILabel+layout.h
//  MaiQiDanGao
//
//  Created by zhouyang on 15/12/17.
//  Copyright © 2015年 ZhouYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel(UILabel_layout)



-(void)setFont:(UIFont *)font textColor:(UIColor *)textColor withBackGroundColor:(UIColor *)backGroundColor;

-(void)setLabelSpaceWithText:(NSString *)text  andLineSpacValue:(float)lineSpace  andWordSpace:(float)wordSpace withFont:(UIFont*)font;

/// 定义富文本即有格式的字符串
-(void)setAttributeTitles:(NSArray *)titles fonts: (NSArray *)fonts colors: (NSArray *)colors;

@end
