//
//  PLVVodDanmu.m
//  PolyvVodSDK
//
//  Created by BqLin on 2017/11/7.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import "PLVVodDanmu.h"

@implementation PLVVodDanmu

/// 初始化
- (instancetype)init {
	if (self = [super init]) {
		_content = @"";
		_time = 0.0;
		_colorHex = 0;
		_fontSize = 12;
	}
	return self;
}

- (NSString *)description {
	NSMutableString *description = [super.description stringByAppendingString:@":\n"].mutableCopy;
	[description appendFormat:@" content: %@;\n", _content];
	[description appendFormat:@" time: %f;\n", _time];
	[description appendFormat:@" colorHex: %zdx;\n", _colorHex];
	[description appendFormat:@" fontSize: %d;\n", _fontSize];
	[description appendFormat:@" mode: %zd;\n", _mode];
	return description;
}

- (UIColor *)color {
	return [self.class colorWithHex:self.colorHex alpha:1];
}

#pragma mark - tool

/// 十六进制转颜色
+ (UIColor *)colorWithHex:(NSUInteger)hexValue alpha:(CGFloat)alpha {
	return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
						   green:((float)((hexValue & 0xFF00) >> 8))/255.0
							blue:((float)(hexValue & 0xFF))/255.0
						   alpha:alpha];
}

@end
