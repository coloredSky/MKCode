//
//  UITextView+WJPlaceholder.h
//  UITextViewPlaceDemo
//
//  Created by JianJian-Mac on 17/3/17.
//  Copyright © 2017年 Mecare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (WJPlaceholder)

@property(nonatomic,readonly)  UILabel *placeholdLabel;
@property(nonatomic,strong)  UIFont *placeholdFont;
@property(nonatomic,strong) IBInspectable NSString *placeholder;
@property(nonatomic,strong) IBInspectable UIColor *placeholderColor;
@property(nonnull,strong) NSAttributedString *attributePlaceholder;
@property(nonatomic,assign) CGPoint location;

+ (UIColor *)defaultColor;

@end
