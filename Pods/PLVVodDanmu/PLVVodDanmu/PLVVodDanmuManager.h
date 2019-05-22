//
//  PLVVodDanmuManager.h
//  PolyvVodSDK
//
//  Created by BqLin on 2017/11/17.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLVVodDanmu.h"

typedef NS_ENUM(NSInteger, PLVVodDanmuState) {
	PLVVodDanmuStateStop,
	PLVVodDanmuStateRunning,
	PLVVodDanmuStatePause,
	PLVVodDanmuStateFinish
};

@interface PLVVodDanmuManager : NSObject

/// 内边距
@property (nonatomic, assign) UIEdgeInsets insets;

/// 状态
@property (nonatomic, assign) PLVVodDanmuState state;

/// 当前时间
@property (nonatomic, assign) NSTimeInterval currentTime;

- (instancetype)initWithDanmus:(NSArray<PLVVodDanmu *> *)danmus inView:(UIView *)superview;
- (instancetype)initWithDanmus:(NSArray<PLVVodDanmu *> *)danmus inView:(UIView *)superview insets:(UIEdgeInsets)insets;

- (void)pause;
- (void)resume;
- (void)stop;

/// 同步显示弹幕
- (void)synchronouslyShowDanmu;

/// 插入弹幕
- (void)insetDanmu:(PLVVodDanmu *)danmu;

- (void)testDanmu:(NSUInteger)index;

@end
