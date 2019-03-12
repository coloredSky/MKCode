//
//  MKDevice.h
//  MK
//
//  Created by 周洋 on 2019/3/8.
//  Copyright © 2019年 周洋. All rights reserved.
//

#ifndef MKDevice_h
#define MKDevice_h

//手机屏幕的宽度
#define _width_                                                                \
MIN([UIScreen mainScreen].bounds.size.width,                                 \
[UIScreen mainScreen].bounds.size.height)

//手机屏幕的高度
#define _height_                                                               \
MAX([UIScreen mainScreen].bounds.size.height,                                \
[UIScreen mainScreen].bounds.size.width)

#define Is_IPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define Is_IPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//判断iPHoneXr
#define Is_IPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !Is_IPad : NO)

//判断iPHoneX、iPHoneXs
#define Is_IPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !Is_IPad : NO)
#define Is_IPhone_XS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !Is_IPad : NO)

//判断iPhoneXs Max
#define Is_IPhone_XS_MAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !Is_IPad : NO)

#define IS_IPhoneX_All (Is_IPhoneXR || Is_IPhoneX || Is_IPhone_XS || Is_IPhone_XS_MAX)
//#define IS_IPhoneX_All ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)

#define KNaviHeight (IS_IPhoneX_All ? 88 : 64)
#define KTabbarHeight (IS_IPhoneX_All ? 83 : 49)
#define KBottomHeight (IS_IPhoneX_All ? 34 : 0)
#define KStatusBarHeight (IS_IPhoneX_All ? 44 : 20)

//基于iphone6 的屏幕宽度比
#define KiPhone6BreadthWidth [UIScreen mainScreen].bounds.size.width/375
#define KiPhone6BreadthHeight [UIScreen mainScreen].bounds.size.height/667
// 宽度适配
#define K_ScaleWidth(width) ( (width) * KiPhone6BreadthWidth)
// 高度适配
#define K_ScaleHeight(height) ((height)*KiPhone6BreadthHeight)


//Iphone Type
#define IS_IPHONE_4     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE_4S     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE_5      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE_6      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
//1125x2001 6+是放大模式下的分辨率
#define IS_IPHONE_6_PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)

//获取当前系统版本
#define _ios12_0_ ([[UIDevice currentDevice].systemVersion floatValue] >= 12.0)
#define _ios11_0_ ([[UIDevice currentDevice].systemVersion floatValue] >= 11.0)
#define _ios10_0_ ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
#define _ios9_0_ ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)
#define _ios8_0_ ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)

//设备型号
#define IS_IPAD          [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define IS_IPHONE        [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone

#endif /* MKDevice_h */
