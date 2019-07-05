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
    EmptyViewShowTypeChangeClassNoLogin,
    EmptyViewShowTypeAskForLeaveNoLogin,
    EmptyViewShowTypeAppointmentNoLogin,
    EmptyViewShowTypeNoAskForLeave,
    EmptyViewShowTypeNoChangeClass,
    EmptyViewShowTypeNoAppointment,
    EmptyViewShowTypeNoUserCourse,
    EmptyViewShowTypeUserCourseNoLogin,
};


/**
 默认视图操作类型

 - EmptyViewOperationTypeLogin: 登录
 - EmptyViewOperationVideoPlay: 视频播放
 - EmptyViewOperationDataRefresh: 刷新数据
 */
typedef NS_ENUM(NSUInteger, EmptyViewOperationType) {
    EmptyViewOperationTypeLogin,
    EmptyViewOperationVideoPlay,
    EmptyViewOperationDataRefresh,
};

#import <UIKit/UIKit.h>
@class EmptyView;
@class MKCourseListModel;

NS_ASSUME_NONNULL_BEGIN

@protocol EmptyViewDelegate <NSObject>

-(void)emptyViewClickTargetWithView:(EmptyView *)view withEmptyViewOperationType:(EmptyViewOperationType )operationType;

@end

@interface EmptyView : UIView

@property (nonatomic, assign) EmptyViewShowType showType;
@property (nonatomic, assign) id<EmptyViewDelegate> delegate;

//-(void)EmptyViewConfigWithImage:(NSString *)contentImage signString:(NSString *)signString viewShowType:(EmptyViewShowType )showType;

-(void)EmptyViewReloadDataWithMKCourseListModel:(MKCourseListModel *)courseModel;
@end

NS_ASSUME_NONNULL_END
