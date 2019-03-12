//
//  UIView+Layout.h
//  layout
//
//  Created by zhouyang on 15/9/18.
//  Copyright (c) 2015年 ZhouYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(UIView_Layout)

/**
 *  视图的横坐标
 */
@property (nonatomic) CGFloat originX;
/**
 *  视图的纵坐标
 */
@property (nonatomic) CGFloat originY;
/**
 *  视图的中心点横坐标
 */
@property (nonatomic) CGFloat centerX;

/**
 *  视图的中心点纵坐标
 */
@property (nonatomic) CGFloat centerY;

/**
 *  视图的顶边位置
 */
@property (nonatomic) CGFloat topY;

/**
 *  视图的底边位置
 */
@property (nonatomic) CGFloat bottomY;

/**
 *  视图的左边位置
 */
@property (nonatomic) CGFloat leftX;

/**
 *  视图的右边位置
 */
@property (nonatomic) CGFloat rightX;

/**
 *  视图的宽度
 */
@property (nonatomic) CGFloat width;

/**
 *  视图的高度
 */
@property (nonatomic) CGFloat height;

/**
 *  视图的大小
 */
@property (nonatomic) CGSize size;


@end
