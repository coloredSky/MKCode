//
//  PLVMarquee.m
//  PolyvVodSDK
//
//  Created by BqLin on 2017/11/1.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import "PLVMarquee.h"

@implementation PLVMarquee

- (instancetype)init {
	if (self = [super init]) {
		_fadeDuration = 0.5;
		_displayDuration = 8.0;
		_alpha = 1;
		_color = [UIColor whiteColor];
		_font = [UIFont systemFontOfSize:16];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        _content =  app_Name;
		_maxFadeInterval = 1;
		_maxRollInterval = 1;
		_type = PLVMarqueeTypeRollFade;
	}
	return self;
}

@end
