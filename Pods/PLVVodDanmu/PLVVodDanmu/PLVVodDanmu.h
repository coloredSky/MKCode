//
//  PLVVodDanmu.h
//  PolyvVodSDK
//
//  Created by BqLin on 2017/11/7.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 弹幕模式
typedef NS_ENUM(NSInteger, PLVVodDanmuMode) {
	PLVVodDanmuModeRoll,
	PLVVodDanmuModeTop,
	PLVVodDanmuModeBottom
};

static NSString * const PLVVodDanmuDidSendNotification = @"PLVVodDanmuDidSendNotification";
static NSString * const PLVVodDanmuWillSendNotification = @"PLVVodDanmuWillSendNotification";
static NSString * const PLVVodDanmuEndSendNotification = @"PLVVodDanmuEndSendNotification";

@interface PLVVodDanmu : NSObject

/// 弹幕内容
@property (nonatomic, copy) NSString *content;

/// 弹幕时间
@property (nonatomic, assign) NSTimeInterval time;

/// 颜色
@property (nonatomic, assign) NSUInteger colorHex;

/// 字体大小，推荐：12，14，18; 14, 18, 24
@property (nonatomic, assign) int fontSize;

/// 弹幕类型
@property (nonatomic, assign) PLVVodDanmuMode mode;

/// UIColor 颜色值
- (UIColor *)color;

@end
