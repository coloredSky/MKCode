//
//  MKColor.h
//  MK
//
//  Created by 周洋 on 2019/3/8.
//  Copyright © 2019年 周洋. All rights reserved.
//

#ifndef MKColor_h
#define MKColor_h

//UIColor 十进制RGB
#define UIColorFromRGB(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1]
//UIColor 十进制RGB_A
#define UIColorFromRGB_A(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]

//UIColor 十六进制RGB_0x
#define UIColorFromRGB_0x(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//十六进制 alpha
#define UIColorFromAlphaRGB_0x(rgbValue,A) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:A]

//背景色
#define K_BG_YellowColor UIColorFromRGB_0x(0xF7EE15)
#define K_BG_WhiteColor UIColorFromRGB_0x(0xffffff)
#define K_BG_blackColor UIColorFromRGB_0x(0x313030)
#define K_BG_GrayColor UIColorFromRGB_0x(0xeeeeee)
#define K_BG_deepGrayColor UIColorFromRGB_0x(0xf7f7f7)

//按钮背景色
//底部按钮背景色
#define K_Btn_BottomBtn_BGColor  UIColorFromRGB_0x(0x313030)
#define K_Btn_BottomBtn_TextColor  UIColorFromRGB_0x(0xffffff)

//字体颜色
#define K_Text_WhiteColor UIColorFromRGB_0x(0xffffff)
#define K_Text_YellowColor UIColorFromRGB_0x(0xF7EE15)
#define K_Text_BlackColor UIColorFromRGB_0x(0x313030)
#define K_Text_grayColor UIColorFromRGB_0x(0x727272)
#define K_Text_DeepGrayColor UIColorFromRGB_0x(0xb2b2b2)
#define K_Text_RedColor UIColorFromRGB_0x(0xfb5d43)
#define K_Text_BlueColor UIColorFromRGB_0x(0x74BAFF)

//线的颜色
#define K_Line_lineColor UIColorFromRGB_0x(0xdddddd)
//线的宽度
#define K_Line_lineWidth  (1 / [UIScreen mainScreen].scale)

#endif /* MKColor_h */
