//
//  AppointmentPopView.h
//  MK
//
//  Created by 周洋 on 2019/3/21.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AppointmentOperationType) {
    AppointmentOperationTypeCancle,
    AppointmentOperationTypeMeeting,
    AppointmentOperationTypeAskForLeave,
    AppointmentOperationTypeChangeClass
};

@protocol AppointmentPopViewDelegate <NSObject>
@optional
-(void)AppointmentPopViewClickWithAppointmentType:(AppointmentOperationType )appointmentType;
@end
/**
 预约动画弹出界面
 */
@interface AppointmentPopView : UIView
@property (nonatomic, assign) id<AppointmentPopViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
