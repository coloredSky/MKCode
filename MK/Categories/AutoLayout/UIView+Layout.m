//
//  UIView+Layout.m
//  layout
//
//  Created by zhouyang on 15/9/18.
//  Copyright (c) 2015年 ZhouYang. All rights reserved.
//

#import "UIView+Layout.h"

@implementation UIView(UIView_Layout)

/**
 *  获取/设置 视图的原点横坐标
 */

-(CGFloat)originX
{
    return self.frame.origin.x;
}
- (void)setOriginX:(CGFloat)originX
{
    self.center = CGPointMake(originX+self.width/2, self.centerY);
}
/**
 *  获取/设置 视图的原点纵坐标
 */

-(CGFloat)originY
{
    return self.frame.origin.y;
}
- (void)setOriginY:(CGFloat)originY
{
    self.center = CGPointMake(self.centerX, self.height/2+originY);
}
/**
 *  获取/设置 视图的中心点横坐标
 */
- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.centerY);
}

/**
 *  获取/设置 视图的中心点纵坐标
 */
- (CGFloat)centerY
{
    return self.center.y;
    
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.centerX, centerY);
}

/**
 *  获取/设置 视图的顶边位置
 */
- (CGFloat)topY
{
    return self.centerY - self.height / 2.0;
}
- (void)setTopY:(CGFloat)topY
{
    self.centerY = topY + self.height / 2.0;
}

/**
 *  获取/设置 视图的底边位置
 */
- (CGFloat)bottomY
{
    return self.centerY + self.height / 2.0;
}
- (void)setBottomY:(CGFloat)bottomY
{
    self.originY = bottomY - self.height / 2.0;
}

/**
 *  获取/设置 视图的左边位置
 */
- (CGFloat)leftX
{
    return self.centerX - self.width / 2.0;
}
- (void)setLeftX:(CGFloat)leftX
{
    self.centerX = leftX + self.width / 2.0;
}

/**
 *  获取/设置 视图的右边位置
 */
- (CGFloat)rightX
{
    return self.centerX + self.width / 2.0;
}
- (void)setRightX:(CGFloat)rightX
{
    self.centerX = rightX - self.width / 2.0;
}

/**
 *  获取/设置 视图的宽度
 */
- (CGFloat)width
{
    return self.bounds.size.width;
}
- (void)setWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.leftX, self.topY, width, self.height);
}

/**
 *  获取/设置 视图的高度
 */
- (CGFloat)height
{
    return self.bounds.size.height;
}
- (void)setHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.leftX, self.topY, self.width, height);
}

/**
 *  获取/设置 视图的大小
 */
- (CGSize)size
{
    return self.bounds.size;
}
- (void)setSize:(CGSize)size
{
    self.bounds = CGRectMake(0, 0, size.width, size.height);
}

/**
 
 ** 设置宽高最好使用bounds属性 **
 
 **
 *  获取/设置 视图的宽度
 *
 - (CGFloat)width
 {
 return self.frame.size.width;
 }
 - (void)setWidth:(CGFloat)width
 {
 self.bounds = CGRectMake(0, 0, width, self.height);
 }
 
 **
 *  获取/设置 视图的高度
 *
 - (CGFloat)height
 {
 return self.frame.size.height;
 }
 - (void)setHeight:(CGFloat)height
 {
 self.bounds = CGRectMake(0, 0, self.width, height);
 }
 
 */

@end
