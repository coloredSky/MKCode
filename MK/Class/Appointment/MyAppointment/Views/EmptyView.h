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
 - EmptyViewShowTypeNoAppointment: 没有预约的课程
 */
typedef NS_ENUM(NSInteger, EmptyViewShowType) {
    EmptyViewShowTypeUnknown = -1,
    EmptyViewShowTypeAppointmentNoLogin,
    EmptyViewShowTypeNoAskForLeave,
    EmptyViewShowTypeNoChangeClass,
    EmptyViewShowTypeNoAppointment,
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
@end

NS_ASSUME_NONNULL_END
