//
//  UserTextView.h
//  FWRACProject
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 he. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTextView : UITextView

@property (nonatomic) IBInspectable NSString *placeholder;//提示文本

@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;//提示文本的颜色

@property (nonatomic, strong) IBInspectable UIColor *contentTextColor;//输入内容的颜色

/**
 创建输入框
 
 @param frame 大小
 @param placeholder 提示文本
 @param placeholderColor 提示文本的颜色
 @param contentTextColor 输入内容的颜色
 @return 视图对象
 */
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder placeholderColor:(UIColor *)placeholderColor contentTextColor:(UIColor *)contentTextColor;

@end
