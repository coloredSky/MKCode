//
//  UIButton+Countdown.h
//  XHBorrow
//
//  Created by caoyong on 2018/9/28.
//  Copyright © 2018年 caoyong. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * 倒计时间器
 */
@interface UIButton (Countdown)

@property(strong,nonatomic)dispatch_source_t timer;
// resume countdown
-(void)beginResumeCountdownFunction;

-(void)beginResendCardCodeFunction;

-(void)beginMsgResendCardCodeFunction;

-(void)cancleDispatchSourceTimer;

@end
