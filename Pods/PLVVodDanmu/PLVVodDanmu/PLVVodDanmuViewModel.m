//
//  PLVVodDanmuViewModel.m
//  PolyvVodSDK
//
//  Created by BqLin on 2017/11/20.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import "PLVVodDanmuViewModel.h"

const double PLVVodDefaultAnimationDuration = 5.0;
const double PLVVodFadeDuration = 1;

@interface PLVVodDanmuViewModel ()<CAAnimationDelegate>

@property (nonatomic, strong) PLVVodDanmu *danmu;

@property (nonatomic, strong) CALayer *danmuItemLayer;

@property (nonatomic, assign) CGSize contentSize;

@end

@implementation PLVVodDanmuViewModel

#pragma mark - dealloc & init
+ (instancetype)viewModelWithDanmu:(PLVVodDanmu *)danmu {
	return [[self alloc] initWithDanmu:danmu];
}

- (instancetype)initWithDanmu:(PLVVodDanmu *)danmu {
	if (self = [super init]) {
		_danmu = danmu;
		_animationDuration = PLVVodDefaultAnimationDuration;
		[self performSelectorOnMainThread:@selector(setupLayer) withObject:nil waitUntilDone:YES];
	}
	return self;
}

#pragma mark - property

- (CALayer *)superlayer {
	if (!_superlayer) {
		_superlayer = self.superview.layer;
	}
	return _superlayer;
}

- (void)setTrack:(PLVVodDanmuTrack *)track {
	_track = track;
	if (!track) {
		return;
	}
	[track.danmus addObject:self.danmu];
}

- (void)setFrameWithTrack:(PLVVodDanmuTrack *)track {
	CGPoint origin = CGPointZero;
	switch (self.danmu.mode) {
		case PLVVodDanmuModeRoll:{
			origin = CGPointMake(CGRectGetWidth(self.superlayer.bounds), track.bounds.origin.y);
		}break;
		case PLVVodDanmuModeTop:
		case PLVVodDanmuModeBottom:{
			CGFloat x = (track.bounds.size.width - self.contentSize.width)/2;
			CGFloat y = (track.bounds.size.height - self.contentSize.height)/2 + track.bounds.origin.y;
			origin = CGPointMake(x, y);
		}break;
		default:{}break;
	}
	self.danmuItemLayer.frame = (CGRect){origin, self.contentSize};
}

- (void)setState:(PLVVodDanmuState)state {
	_state = state;
	if (self.stateDidChangeBlock) self.stateDidChangeBlock(self, state);
}

#pragma mark - UI

- (void)setupLayer {
	if (!self.danmu) {
		return;
	}
	// 配置
	NSMutableDictionary *danmuAttr = [NSMutableDictionary dictionary];
	danmuAttr[NSFontAttributeName] = [UIFont systemFontOfSize:self.danmu.fontSize];
	danmuAttr[NSForegroundColorAttributeName] = self.danmu.color;
	NSMutableAttributedString *danmuText = [[NSMutableAttributedString alloc] initWithString:self.danmu.content attributes:danmuAttr];
	//NSLog(@"danmu text: %@", danmuText);
	
	CATextLayer *textLayer = [CATextLayer layer];
	textLayer.string = danmuText;
	textLayer.contentsScale = [UIScreen mainScreen].scale;
	textLayer.anchorPoint = CGPointZero;
	textLayer.frame = (CGRect){CGPointZero, danmuText.size};
	self.contentSize = danmuText.size;
	self.danmuItemLayer = textLayer;
	
	// for test
	//self.danmuItemLayer.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
//	self.superview.backgroundColor = [UIColor redColor];
}

- (void)show {
	[self setFrameWithTrack:self.track];
	[self.superlayer addSublayer:self.danmuItemLayer];
	[self addAnimation];
	self.track.occupied = YES;
	//NSLog(@"%f\tshow danmu: %@, %@", self.danmu.time, self.danmu.content, NSStringFromCGRect(self.danmuItemLayer.frame));
}
- (void)stop {
	self.track = nil;
	__weak typeof(self) weakSelf = self;
	dispatch_async(dispatch_get_main_queue(), ^{
		[self.danmuItemLayer removeAllAnimations];
		[self.danmuItemLayer removeFromSuperlayer];
		weakSelf.state = PLVVodDanmuStateFinish;
	});
}

- (void)pause {
	NSTimeInterval pauseTime = [self.danmuItemLayer convertTime:CACurrentMediaTime() fromLayer:nil];
	self.danmuItemLayer.timeOffset = pauseTime;
	self.danmuItemLayer.speed = 0;
	self.state = PLVVodDanmuStatePause;
}

- (void)resume {
	NSTimeInterval timeSincePause = CACurrentMediaTime() - self.danmuItemLayer.timeOffset;
	self.danmuItemLayer.timeOffset = 0;
	self.danmuItemLayer.beginTime = timeSincePause;
	self.danmuItemLayer.speed = 1;
	self.state = PLVVodDanmuStateRunning;
}

- (void)cleanTrack {
	self.track.occupied = NO;
	[self.track.danmus removeObject:self.danmu];
	self.track = nil;
}

+ (CGFloat)maxHeight {
	CGSize size = [@"龍" sizeWithAttributes:@{NSForegroundColorAttributeName: [UIFont systemFontOfSize:18]}];
	return size.height;
}

#pragma mark - Animation
- (void)addAnimation {
	switch (self.danmu.mode) {
		case PLVVodDanmuModeRoll:{
			[self.danmuItemLayer addAnimation:[self rollAnimation] forKey:@"roll"];
		}break;
		case PLVVodDanmuModeTop:
		case PLVVodDanmuModeBottom:{
			[self.danmuItemLayer addAnimation:[self fadeAnimation] forKey:@"fade"];
		}break;
		default:{}break;
	}
}

- (CAAnimation *)fadeAnimation {
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
	animation.duration = self.animationDuration;
	animation.removedOnCompletion = NO;
	animation.values = @[@0, @1, @1, @0];
	animation.keyTimes = @[@0, @(PLVVodFadeDuration/self.animationDuration), @(1-PLVVodFadeDuration/self.animationDuration), @1];
	animation.delegate = self;
	return animation;
}

- (CAAnimation *)rollAnimation {
	CGSize superSize = self.superlayer.bounds.size;
	CGRect frame = self.danmuItemLayer.frame;
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
	animation.fromValue = [NSValue valueWithCGPoint:frame.origin];
	animation.toValue = [NSValue valueWithCGPoint:CGPointMake(-frame.size.width, frame.origin.y)];
	animation.duration = superSize.width / (frame.size.width + frame.origin.x) * self.animationDuration;
	animation.delegate = self;
	return animation;
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)animation {
	self.state = PLVVodDanmuStateRunning;
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)finished {
	//NSLog(@"%s - %@", __FUNCTION__, [NSThread currentThread]);
	[self cleanTrack];
	[self.danmuItemLayer removeFromSuperlayer];
	self.state = PLVVodDanmuStateFinish;
}

@end
