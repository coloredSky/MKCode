//
//  UILabelEdgeInset.h
//  MaiQiDanGao
//
//  Created by zhouyang on 15/12/22.
//  Copyright © 2015年 ZhouYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabelEdgeInset : UILabel

@property(nonatomic) UIEdgeInsets insets;
@property (nonatomic) CGFloat fontSize;

-(id) initWithFrame:(CGRect)frame andInsets: (UIEdgeInsets) insets;
-(id) initWithInsets: (UIEdgeInsets) insets;

@end
