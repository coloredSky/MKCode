//
//  PLVVodDanmuTrack.m
//  PolyvVodSDK
//
//  Created by BqLin on 2017/11/20.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import "PLVVodDanmuTrack.h"

@implementation PLVVodDanmuTrack

- (NSMutableArray<PLVVodDanmu *> *)danmus {
	if (!_danmus) {
		_danmus = [NSMutableArray array];
	}
	return _danmus;
}

- (NSString *)description {
	NSMutableString *description = [super.description stringByAppendingString:@":\n"].mutableCopy;
	[description appendFormat:@" occupied: %s;\n", _occupied?"YES":"NO"];
	[description appendFormat:@" boundsY: %f;\n", _bounds.origin.y];
	[description appendFormat:@" danmus: %@;\n", _danmus];
	return description;
}

@end
