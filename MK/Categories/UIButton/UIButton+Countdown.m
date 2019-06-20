//
//  UIButton+Countdown.m
//  XHBorrow
//
//  Created by caoyong on 2018/9/28.
//  Copyright © 2018年 caoyong. All rights reserved.
//

#import "UIButton+Countdown.h"
#import <objc/runtime.h>

static const void *timerAssociated =&timerAssociated;

@implementation UIButton (Countdown)

@dynamic timer;
-(void)dealloc
{
    [self cancleDispatchSourceTimer];
}

-(void)setTimer:(dispatch_source_t)timer
{
    objc_setAssociatedObject(self, timerAssociated, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(dispatch_source_t)timer
{
    return objc_getAssociatedObject(self, timerAssociated);
}

-(void)cancleDispatchSourceTimer
{
    if (self.timer) {
       dispatch_source_cancel(self.timer);
    }
}

-(void)beginResumeCountdownFunction
{
    [self startCountdownTime:60 NormalTitle:@"获取验证码" countdownSubTitle:@"秒后重试" countdownTitleColor:[UIColor whiteColor] restoreTitleColor:[UIColor whiteColor] boardWidthColorNormal:[UIColor clearColor] countdownBoardWidthColor:[UIColor clearColor]];
}

-(void)beginResendCardCodeFunction
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    [self startCountdownTime:60 NormalTitle:@"重新发送" normalBgColor:[UIColor clearColor] countdownSubTitle:@"s" countdownTitleColor:UIColorFromRGB_0x(0X808080) countdownBgColor:[UIColor clearColor] countdownBorderColor:UIColorFromRGB_0x(0X808080) restoreTitleColor:UIColorFromRGB_0x(0X01a8ee)];
}

-(void)beginMsgResendCardCodeFunction
{
    [self startCountdownTime:60 NormalTitle:@"获取验证码" normalBgColor:[UIColor clearColor] countdownSubTitle:@"s" countdownTitleColor:UIColorFromRGB_0x(0X808080)  countdownBgColor:[UIColor clearColor] countdownBorderColor:[UIColor clearColor] restoreTitleColor:UIColorFromRGB_0x(0XF9BA1C)];
}

-(void)startCountdownTime:(NSInteger)startTime NormalTitle:(NSString*)title countdownSubTitle:(NSString*)subTitle countdownTitleColor:(UIColor*)titleColor restoreTitleColor:(UIColor*)restorTitleColor boardWidthColorNormal:(UIColor*)normalColor countdownBoardWidthColor:(UIColor*)countdownBoardWidthColor
{
    self.selected =YES;
    //倒计时时间
    __block NSInteger startCountdownTime = startTime;
    //全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
   //创建定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    self.timer = timer;
    //设置定时器(一秒执行一次)
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //执行事件处理
    dispatch_source_set_event_handler(timer, ^{
        if (startCountdownTime <= 0){
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = [UIColor blackColor];
                [self setTitle:title forState:UIControlStateNormal];
//                [self.layer setBorderColor:normalColor.CGColor];
                [self setTitleColor:restorTitleColor forState:UIControlStateNormal];
                self.selected = NO;
                self.userInteractionEnabled = YES;
            });
        }else
        {
            int allTime = (int)startTime + 1;//60 0==>59
            int seconds =(int)startCountdownTime % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = [UIColor blackColor];
//                [self.layer setBorderColor:countdownBoardWidthColor.CGColor];
                self.titleLabel.text = [NSString stringWithFormat:@"%@%@",timeStr,subTitle];
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                [self setTitleColor:titleColor forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            startCountdownTime--;
        }
        
    });
    dispatch_resume(timer);

}


-(void)startCountdownTime:(NSInteger)startTime NormalTitle:(NSString*)title normalBgColor:(UIColor *)normalBgColor countdownSubTitle:(NSString*)subTitle countdownTitleColor:(UIColor*)titleColor countdownBgColor:(UIColor *)countdownBgColor countdownBorderColor:(UIColor *)countdownBorderColor restoreTitleColor:(UIColor*)restorTitleColor
{
    self.selected =YES;
    //倒计时时间
    __block NSInteger startCountdownTime = startTime;
    //全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置定时器(一秒执行一次)
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //执行事件处理
    dispatch_source_set_event_handler(timer, ^{
        
        if (startCountdownTime <= 0)
        {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = normalBgColor;
                [self setTitle:title forState:UIControlStateNormal];
                [self setTitleColor:restorTitleColor forState:UIControlStateNormal];
                self.selected = NO;
                self.userInteractionEnabled = YES;
                self.layer.borderWidth = 0;
            });
        }else
        {
            int allTime = (int)startTime + 1;//60 0==>59
            int seconds =(int)startCountdownTime % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.layer.borderColor = countdownBorderColor.CGColor;
                self.layer.borderWidth = 1.f;
                self.backgroundColor = countdownBgColor;
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                [self setTitleColor:titleColor forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            startCountdownTime--;
        }
        
    });
    dispatch_resume(timer);
    
}
@end



