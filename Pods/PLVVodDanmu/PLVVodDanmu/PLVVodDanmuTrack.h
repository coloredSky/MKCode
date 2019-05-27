//
//  PLVVodDanmuTrack.h
//  PolyvVodSDK
//
//  Created by BqLin on 2017/11/20.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLVVodDanmu.h"

@interface PLVVodDanmuTrack : NSObject

/// 是否正在使用
@property (nonatomic, assign) BOOL occupied;

/// 边框
@property (nonatomic, assign) CGRect bounds;

/// 承载弹幕
@property (nonatomic, strong) NSMutableArray<PLVVodDanmu *> *danmus;

@end
