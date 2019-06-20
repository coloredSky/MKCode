//
//  EmptyView.h
//  MK
//
//  Created by 周洋 on 2019/6/3.
//  Copyright © 2019 周洋. All rights reserved.
//

/**
 默认视图显示

 - EmptyViewShowTypeUnknown: unknow
 - EmptyViewShowTypeAppointmentNoLogin: 未登录
 - EmptyViewShowTypeNoAskForLeave: 没有请假的课程
 - EmptyViewShowTypeNoChangeClass: 没有换班的课程
 - EmptyViewShowTypeNoAppointment: 没有预约
 - EmptyViewShowTypeNoUserCourse: 没有课程
 EmptyViewShowTypeUserCourseNoLogin 我的课程里面没有登录
 */
typedef NS_ENUM(NSInteger, EmptyViewShowType) {
    EmptyViewShowTypeUnknown = -1,
    EmptyViewShowTypeAppointmentNoLogin,
    EmptyViewShowTypeNoAskForLeave,
    EmptyViewShowTypeNoChangeClass,
    EmptyViewShowTypeNoAppointment,
    EmptyViewShowTypeNoUserCourse,
    EmptyViewShowTypeUserCourseNoLogin,
};

#import <UIKit/UIKit.h>
@class EmptyView;

NS_ASSUME_NONNULL_BEGIN

@protocol EmptyViewDelegate <NSObject>

-(void)emptyViewClickTargetWithView:(EmptyView *)view;

@end

@interface EmptyView : UIView
@property (nonatomic, assign) EmptyViewShowType showType;
@property (nonatomic, assign) id<EmptyViewDelegate> delegate;

//-(void)EmptyViewConfigWithImage:(NSString *)contentImage signString:(NSString *)signString viewShowType:(EmptyViewShowType )showType;
@end

NS_ASSUME_NONNULL_END
