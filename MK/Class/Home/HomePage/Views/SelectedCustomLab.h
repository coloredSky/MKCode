//
//  SelectedCustomLab.h
//  com.yocto.jzy
//
//  Created by zhouyang on 16/10/12.
//  Copyright © 2016年 com.yocto. All rights reserved.
//

#define TitleLabFont [UIFont boldSystemFontOfSize:16]

#import <UIKit/UIKit.h>

@interface SelectedCustomLab : UILabel

-(instancetype)initWithFrame:(CGRect)frame andNormalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;

@property(nonatomic,assign)BOOL selected;
@end
