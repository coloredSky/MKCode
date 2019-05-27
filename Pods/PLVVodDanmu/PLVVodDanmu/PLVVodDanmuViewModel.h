//
//  PLVVodDanmuViewModel.h
//  PolyvVodSDK
//
//  Created by BqLin on 2017/11/20.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLVVodDanmu.h"
#import "PLVVodDanmuManager.h"
#import "PLVVodDanmuTrack.h"

@interface PLVVodDanmuViewModel : NSObject

@property (nonatomic, strong, readonly) PLVVodDanmu *danmu;

/// 父视图
@property (nonatomic, weak) CALayer *superlayer;
@property (nonatomic, weak) UIView *superview;

/// 弹幕项图层
@property (nonatomic, strong, readonly) CALayer *danmuItemLayer;

/// 动画时长
@property (nonatomic, assign) NSTimeInterval animationDuration;

/// 状态
@property (nonatomic, assign) PLVVodDanmuState state;
@property (nonatomic, copy) void (^stateDidChangeBlock)(PLVVodDanmuViewModel *viewModel, PLVVodDanmuState state);

/// 使用轨道
@property (nonatomic, strong) PLVVodDanmuTrack *track;

/// 使用danmu初始化
+ (instancetype)viewModelWithDanmu:(PLVVodDanmu *)danmu;

+ (CGFloat)maxHeight;

- (void)pause;
- (void)resume;

- (void)show;
- (void)stop;

@end
