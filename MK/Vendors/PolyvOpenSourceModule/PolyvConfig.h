//
//  PolyvConfig.h
//  MK
//
//  Created by 周洋 on 2019/5/5.
//  Copyright © 2019年 周洋. All rights reserved.
//

#ifndef PolyvConfig_h
#define PolyvConfig_h

// UIScreen width.
#define PLV_ScreenWidth   [UIScreen mainScreen].bounds.size.width
// UIScreen height.
#define PLV_ScreenHeight  [UIScreen mainScreen].bounds.size.height
// iPhone X
#define PLV_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define PLV_iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
// 横屏时左右安全区域
#define PLV_Landscape_Left_And_Right_Safe_Side_Margin  44
// 横屏时底部安全区域
#define PLV_Landscape_Left_And_Right_Safe_Bottom_Margin  21
// 状态栏高度
#define PLV_StatusBarHeight ((PLV_iPhoneX || PLV_iPhoneXR) ? 44.f: 20.f)
// 状态栏+导航栏高度
#define PLV_StatusAndNaviBarHeight ((PLV_iPhoneX || PLV_iPhoneXR) ? 88.f: 64.f)
// 各个机型最小逻辑分辨率宽度
#define PLV_Min_ScreenWidth 320
#define PLV_Max_ScreenWidth 414

#endif /* PolyvConfig_h */
