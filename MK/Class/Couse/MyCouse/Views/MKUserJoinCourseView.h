//
//  MKUserJoinCourseView.h
//  MK
//
//  Created by 周洋 on 2019/7/29.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKUserJoinCourseView : UIView

@property (nonatomic, copy)void(^userJoinClassBlock)(NSInteger selectedIndex);

-(void)userJoinCourseViewReloadDataWithClassList:(NSArray <NSString *>*)classList;

@end

NS_ASSUME_NONNULL_END
