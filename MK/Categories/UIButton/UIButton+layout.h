//
//  UIButton+layout.h
//  MaiQiDanGao
//
//  Created by zhouyang on 15/12/17.
//  Copyright © 2015年 ZhouYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton(UIButton_layout)

-(void)setNormalTitle:(NSString *)normalTitle font:(UIFont *)font titleColor:(UIColor *)titleColor;

-(void)setSelectedImage:(NSString *)SelectedImageStr andSelectedTitle:(NSString *)SelectedTitle titleColor:(UIColor *)titleColor;

-(void)setSelectedTitle:(NSString *)SelectedTitle titleColor:(UIColor *)titleColor;

-(void)setNormalImage:(NSString *)normalImageStr andSelectedImage:(NSString *)SelectedImageStr;

-(void)setNormalBackgroundImage:(UIImage *)image andTitle:(NSString *)title andFont:(UIFont *)font textColor:(UIColor *)textColor;

-(void)setSelectedBackgroundImage:(UIImage *)image andTitle:(NSString *)title andFont:(UIFont *)font textColor:(UIColor *)textColor;

@end
