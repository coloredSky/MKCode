//
//  PLVMarquee.h
//  PolyvVodSDK
//
//  Created by BqLin on 2017/11/1.
//  Copyright © 2017年 POLYV. All rights reserved.
//
// 跑马灯模型
// 随机因素：
// - 出现位置
// - 出现间隔

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PLVMarqueeType) {
	/// 闪现
	PLVMarqueeTypeFade,
	/// 滚动
	PLVMarqueeTypeRoll,
	/// 滚动+闪现
	PLVMarqueeTypeRollFade
};

@interface PLVMarquee : NSObject

/// 跑马灯类型
@property (nonatomic, assign) PLVMarqueeType type;

/// 单次跑马灯显示时长，不包含动画时长
@property (nonatomic, assign) NSTimeInterval displayDuration;

/// 渐变动画时长
@property (nonatomic, assign) NSTimeInterval fadeDuration;

/// 两次闪现的最大间隔时长，实际的间隔时长是取 0~maxFadeInterval 的随机值
@property (nonatomic, assign) NSTimeInterval maxFadeInterval;

/// 两次滚动的最大间隔时长，实际的间隔时长是取 0~maxRollInterval 的随机值
@property (nonatomic, assign) NSTimeInterval maxRollInterval;

/// 跑马灯内容
@property (nonatomic, copy) NSString *content;

/// 跑马灯颜色
@property (nonatomic, strong) UIColor *color;

/// 跑马灯透明度
@property (nonatomic, assign) CGFloat alpha;

/// 跑马灯字体
@property (nonatomic, strong) UIFont *font;

@end
