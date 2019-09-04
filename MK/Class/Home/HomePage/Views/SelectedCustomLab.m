//
//  SelectedCustomLab.m
//  com.yocto.jzy
//
//  Created by zhouyang on 16/10/12.
//  Copyright © 2016年 com.yocto. All rights reserved.
//



#import "SelectedCustomLab.h"

@interface SelectedCustomLab()
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;
@end

@implementation SelectedCustomLab

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame: frame])
    {
//        [self setFont:TitleLabFont textColor:K_Text_grayColor withBackGroundColor:nil];
        self.normalColor = K_Text_grayColor;
        self.selectedColor = K_Text_WhiteColor;
        return  [self initWithFrame:frame andNormalColor:K_Text_grayColor selectedColor:K_Text_WhiteColor];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame andNormalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor
{
    if (self=[super initWithFrame: frame])
    {
        [self setFont:TitleLabFont textColor:normalColor withBackGroundColor:nil];
        self.normalColor = normalColor;
        self.selectedColor = selectedColor;
    }
    return self;
}

-(void)setSelected:(BOOL)selected
{
    if (selected)
    {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [UIView animateWithDuration:.3 animations:^{
                [self setTextColor:self.selectedColor];
//            }];
//        });
       
    }
    else
    {
//            [UIView animateWithDuration:.3 animations:^{
                [self setTextColor:self.normalColor];
//            }];
    }
}
@end
