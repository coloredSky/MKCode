//
//  MKFont.h
//  MK
//
//  Created by 周洋 on 2019/3/8.
//  Copyright © 2019年 周洋. All rights reserved.
//

#ifndef MKFont_h
#define MKFont_h

//主要字体名称
#define MainFontName @"Helvetica"
//数字字体、英文字体
#define MainNumberFontName @"Helvetica"

//字体大小
#define MKFont(x) [UIFont fontWithName:MainFontName size:x]
#define MKBoldFont(fontSize) [UIFont boldSystemFontOfSize:fontSize]

//nav font
#define K_Font_Nav_TitleFont  MKFont(20)
#define K_Font_Nav_LeftTextFont  MKFont(15)
#define K_Font_Nav_RightTextFont  MKFont(15)

//字体大小
#define K_Font_Text_Large_Max  MKFont(18)
#define K_Font_Text_Large  MKFont(17)
#define K_Font_Text_Large_Little  MKFont(16)

#define K_Font_Text_Normal_Max  MKFont(15)
#define K_Font_Text_Normal  MKFont(14)
#define K_Font_Text_Normal_little  MKFont(13)

#define K_Font_Text_Min_Max  MKFont(12)
#define K_Font_Text_Min  MKFont(11)
#define K_Font_Text_Min_Little  MKFont(11)

//底部按钮字体大小
#define K_Font_Btn_Title  MKFont(16)

//其他字体大小
//发现栏位下的星期几
#define K_Font_WeekDay_Text  MKBoldFont(24)


#endif /* MKFont_h */
