//
//  PLVVodDanmuManager.m
//  PolyvVodSDK
//
//  Created by BqLin on 2017/11/17.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import "PLVVodDanmuManager.h"
#import "PLVVodDanmuViewModel.h"

@interface PLVVodDanmuManager ()

/// 弹幕数据
@property (nonatomic, strong) NSArray<PLVVodDanmu *> *danmus;

@property (nonatomic, strong) NSMutableArray<PLVVodDanmu *> *tempDanmus;
@property (nonatomic, strong) NSMutableArray<PLVVodDanmuViewModel *> *currentViewModels;

@property (nonatomic, strong) NSArray<PLVVodDanmuTrack *> *tracks;

/// 轨道高度
@property (nonatomic, assign) CGFloat trackHeight;

@property (nonatomic, weak) UIView *superview;

@end

@implementation PLVVodDanmuManager

- (instancetype)init {
	if (self = [super init]) {
		_insets = UIEdgeInsetsZero;
	}
	return self;
}

- (instancetype)initWithDanmus:(NSArray<PLVVodDanmu *> *)danmus inView:(UIView *)superview insets:(UIEdgeInsets)insets {
	self = [self init];
	// 按时间排序弹幕数组
	NSArray *sortedDanmus = [danmus sortedArrayUsingComparator:^NSComparisonResult(PLVVodDanmu *obj1, PLVVodDanmu *obj2) {
		return [@(obj1.time) compare:@(obj2.time)];
	}];
	_danmus = sortedDanmus;
	self.trackHeight = [PLVVodDanmuViewModel maxHeight];
	for (PLVVodDanmu *danmu in sortedDanmus) {
		CGSize danmuContentSize = [danmu.content sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:danmu.fontSize]}];
		if (danmuContentSize.height < self.trackHeight) {
			self.trackHeight = danmuContentSize.height;
		}
//		PLVVodDanmuViewModel *viewModel = [PLVVodDanmuViewModel viewModelWithDanmu:danmu];
//		viewModel.superview = superView;
//		[danmuViewModels addObject:viewModel];
	}
	self.tempDanmus = _danmus.mutableCopy;
	self.state = PLVVodDanmuStateStop;
	_superview = superview;
	_insets = insets;
	[self performSelectorOnMainThread:@selector(setupTracks) withObject:nil waitUntilDone:NO];
	
	return self;
}
- (instancetype)initWithDanmus:(NSArray<PLVVodDanmu *> *)danmus inView:(UIView *)superview {
	return [self initWithDanmus:danmus inView:superview insets:UIEdgeInsetsZero];
}

#pragma mark - property

- (void)setCurrentTime:(NSTimeInterval)currentTime {
	if (currentTime < _currentTime) {
		[self cleanTracks];
		_tempDanmus = self.danmus.mutableCopy;
	}
	_currentTime = currentTime;
}
- (void)setInsets:(UIEdgeInsets)insets {
	_insets = insets;
	[self performSelectorOnMainThread:@selector(setupTracks) withObject:nil waitUntilDone:NO];
}

- (NSMutableArray<PLVVodDanmuViewModel *> *)currentViewModels {
	if (!_currentViewModels) {
		_currentViewModels = [NSMutableArray array];
	}
	return _currentViewModels;
}

#pragma mark - private

- (void)cleanTracks {
	[self stop];
	for (PLVVodDanmuTrack *track in self.tracks) {
		track.occupied = NO;
		track.danmus = nil;
	}
}

/// 创建轨道
- (void)setupTracks {
	CGRect superBounds = self.superview.bounds;
	superBounds = UIEdgeInsetsInsetRect(superBounds, self.insets);
	CGFloat height = superBounds.size.height;
	CGFloat width = superBounds.size.width;
	CGFloat insetY = superBounds.origin.y;
	CGFloat itemHeight = self.trackHeight + 8;
	NSInteger trackCount = height / itemHeight;

	// 重新分配轨道
	NSMutableArray *tracks = [NSMutableArray array];
	for (int i = 0; i < trackCount; i++) {
		PLVVodDanmuTrack *track = [[PLVVodDanmuTrack alloc] init];
		CGFloat y = itemHeight * i + insetY;
		track.bounds = CGRectMake(0, y, width, self.trackHeight);
		[tracks addObject:track];
		//NSLog(@"track bounds: %@", NSStringFromCGRect(track.bounds));
	}
	self.tracks = tracks;
}

/// 分配最优弹道
- (void)distributeOptimumTrackWithDanmuViewModel:(PLVVodDanmuViewModel *)danmuViewModel {
	//NSLog(@"tracks: %@", self.tracks);
	PLVVodDanmu *danmu = danmuViewModel.danmu;
	switch (danmu.mode) {
		case PLVVodDanmuModeRoll:
		case PLVVodDanmuModeTop:{
			for (int i = 0; i < self.tracks.count; i++) {
				PLVVodDanmuTrack *track = self.tracks[i];
				if ([self configDanmuViewModel:danmuViewModel track:track]) {
					break;
				}
			}
		}break;
		case PLVVodDanmuModeBottom:{
			for (NSUInteger i = self.tracks.count; i > 0; i--) {
				PLVVodDanmuTrack *track = self.tracks[i-1];
				if ([self configDanmuViewModel:danmuViewModel track:track]) {
					break;
				}
			}
		}break;
		default:{}break;
	}
}

- (BOOL)configDanmuViewModel:(PLVVodDanmuViewModel *)danmuViewModel track:(PLVVodDanmuTrack *)track {
	BOOL hasSameTypeDanmu = NO;
	for (PLVVodDanmu *danmu in track.danmus) {
		if (danmuViewModel.danmu.mode == danmu.mode) {
			hasSameTypeDanmu = YES;
			break;
		}
	}
	BOOL config = NO;
	if (!track.occupied || !hasSameTypeDanmu) {
		danmuViewModel.track = track;
		config = YES;
	}
	return config;
}

#pragma mark - operation

- (void)pause {
	for (PLVVodDanmuViewModel *viewModel in self.currentViewModels) {
		//NSLog(@"danmu: %@ - %f", viewModel.danmu.content, viewModel.danmu.time);
		[viewModel pause];
	}
	self.state = PLVVodDanmuStatePause;
}
- (void)resume {
	for (PLVVodDanmuViewModel *viewModel in self.currentViewModels) {
		[viewModel resume];
	}
	self.state = PLVVodDanmuStateRunning;
}
- (void)stop {
	for (PLVVodDanmuViewModel *viewModel in self.currentViewModels) {
		[viewModel stop];
	}
	self.state = PLVVodDanmuStateStop;
}

- (void)synchronouslyShowDanmu {
	if (!self.tempDanmus.count) {
		//NSLog(@"弹幕发送完毕");
		self.state = PLVVodDanmuStateFinish;
		return;
	}
	PLVVodDanmu *danmu = self.tempDanmus.firstObject;
	NSTimeInterval lessTime = self.currentTime - 1.0;
	if (lessTime <= danmu.time && danmu.time <= self.currentTime) {
		PLVVodDanmuViewModel *viewModel = [self showDanmu:danmu];
		__weak typeof(self) weakSelf = self;
		viewModel.stateDidChangeBlock = ^(PLVVodDanmuViewModel *viewModel, PLVVodDanmuState state) {
			switch (state) {
				case PLVVodDanmuStateStop:{}break;
				case PLVVodDanmuStateRunning:{}break;
				case PLVVodDanmuStatePause:{}break;
				case PLVVodDanmuStateFinish:{
					[weakSelf.currentViewModels removeObject:viewModel];
				}break;
				default:{}break;
			}
		};
		[self.currentViewModels addObject:viewModel];
		[self.tempDanmus removeObjectAtIndex:0];
		[self synchronouslyShowDanmu];
	} else if (danmu.time < lessTime) {
		[self.tempDanmus removeObjectAtIndex:0];
	}
}

- (PLVVodDanmuViewModel *)showDanmu:(PLVVodDanmu *)danmu {
	PLVVodDanmuViewModel *viewModel = [PLVVodDanmuViewModel viewModelWithDanmu:danmu];
	viewModel.superview = self.superview;
	[self distributeOptimumTrackWithDanmuViewModel:viewModel];
	[viewModel show];
	//NSLog(@"layer frame: %@", NSStringFromCGRect(viewModel.danmuItemLayer.frame));
	//NSLog(@"layer track frame: %@", NSStringFromCGRect(viewModel.track.bounds));
	
	return viewModel;
}

- (void)insetDanmu:(PLVVodDanmu *)danmu {
	NSMutableArray *danmus = self.danmus.mutableCopy;
	NSUInteger insertIndex = 0;
	for (int i = 0; i < self.danmus.count; i++) {
		if (danmu.time > self.danmus[i].time) {
			insertIndex = i;
			break;
		}
	}
	[danmus insertObject:danmu atIndex:insertIndex];
	self.danmus = danmus;
	
	[self showDanmu:danmu];
}

- (void)testDanmu:(NSUInteger)index {
	if (index >= self.danmus.count) {
		index = self.danmus.count - 1;
	}
	PLVVodDanmuViewModel *viewModel = [PLVVodDanmuViewModel viewModelWithDanmu:self.danmus[index]];
	[self distributeOptimumTrackWithDanmuViewModel:viewModel];
	[viewModel show];
}

@end
