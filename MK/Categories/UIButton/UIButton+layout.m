//
//  UIButton+layout.m
//  MaiQiDanGao
//
//  Created by zhouyang on 15/12/17.
//  Copyright © 2015年 ZhouYang. All rights reserved.
//

#import "UIButton+layout.h"

@implementation UIButton(UIButton_layout)

-(void)setNormalImage:(NSString *)normalImageStr andNormalTitle:(NSString *)normalTitle font:(UIFont *)font titleColor:(UIColor *)titleColor
{
    [self setImage:[UIImage imageNamed:normalImageStr] forState:UIControlStateNormal];
    [self setTitle:normalTitle forState:UIControlStateNormal];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    self.titleLabel.font = font;
}


-(void)setNormalTitle:(NSString *)normalTitle font:(UIFont *)font titleColor:(UIColor *)titleColor
{
        [self setTitle:normalTitle forState:UIControlStateNormal];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        self.titleLabel.font = font;
}

-(void)setSelectedImage:(NSString *)SelectedImageStr andSelectedTitle:(NSString *)SelectedTitle titleColor:(UIColor *)titleColor
{
    [self setImage:[UIImage imageNamed:SelectedImageStr] forState:UIControlStateSelected];
    [self setTitle:SelectedTitle forState:UIControlStateSelected];
    [self setTitleColor:titleColor forState:UIControlStateSelected];
}

-(void)setSelectedTitle:(NSString *)SelectedTitle titleColor:(UIColor *)titleColor
{
    [self setTitle:SelectedTitle forState:UIControlStateSelected];
    [self setTitleColor:titleColor forState:UIControlStateSelected];
}

-(void)setNormalImage:(NSString *)normalImageStr andSelectedImage:(NSString *)SelectedImageStr
{
    [self setImage:[UIImage imageNamed:normalImageStr] forState:UIControlStateNormal];
    
    [self setImage:[UIImage imageNamed:SelectedImageStr] forState:UIControlStateSelected];
}

-(void)setNormalBackgroundImage:(UIImage *)image andTitle:(NSString *)title andFont:(UIFont *)font textColor:(UIColor *)textColor
{
    if (image==nil)
    {
        [self setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
    }
    else
    {
        [self setBackgroundImage:image forState:UIControlStateNormal];
 
    }
    [self setTitle:title forState:UIControlStateNormal];
    self.titleLabel.font = font;
    [self setTitleColor:textColor forState:UIControlStateNormal];
}


-(void)setSelectedBackgroundImage:(UIImage *)image andTitle:(NSString *)title andFont:(UIFont *)font textColor:(UIColor *)textColor
{
    if (image==nil)
    {
        [self setBackgroundImage:[UIImage new] forState:UIControlStateSelected];
    }
    else
    {
        [self setBackgroundImage:image forState:UIControlStateSelected];
        
    }
    [self setTitle:title forState:UIControlStateSelected];
    self.titleLabel.font = font;
    [self setTitleColor:textColor forState:UIControlStateSelected];
}

@end
