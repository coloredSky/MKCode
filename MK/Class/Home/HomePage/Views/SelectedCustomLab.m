//
//  SelectedCustomLab.m
//  com.yocto.jzy
//
//  Created by zhouyang on 16/10/12.
//  Copyright © 2016年 com.yocto. All rights reserved.
//



#import "SelectedCustomLab.h"

@implementation SelectedCustomLab

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame: frame])
    {
        [self setFont:TitleLabFont textColor:K_Text_grayColor withBackGroundColor:nil];
    }
    return self;
}
-(void)setSelected:(BOOL)selected
{
    if (selected)
    {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [UIView animateWithDuration:.3 animations:^{
                [self setTextColor:K_Text_WhiteColor];
//            }];
//        });
       
    }
    else
    {
//            [UIView animateWithDuration:.3 animations:^{
                [self setTextColor:K_Text_grayColor];
//            }];
    }
}
@end
