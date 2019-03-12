//
//  UILabelEdgeInset.m
//  MaiQiDanGao
//
//  Created by zhouyang on 15/12/22.
//  Copyright © 2015年 ZhouYang. All rights reserved.
//

#import "UILabelEdgeInset.h"

@implementation UILabelEdgeInset


- (instancetype)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets
{
    self = [self initWithFrame:frame];
    if (self)
    {
        self.insets = insets;
    }
    return self;
}

- (id)initWithInsets:(UIEdgeInsets)insets
{
    self = [super init];
    if (self)
    {
        self.insets = insets;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect
{
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}

- (void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    self.font = [UIFont systemFontOfSize:fontSize];
}


@end
