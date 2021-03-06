//
//  AskForLeaveQueryViewController.h
//  MK
//
//  Created by 周洋 on 2019/4/3.
//  Copyright © 2019年 周洋. All rights reserved.
//

typedef NS_ENUM(NSUInteger, AskForLeaveQueryCheckType) {
    AskForLeaveQueryCheckTypeCanEdit,
    AskForLeaveQueryCheckTypeNotEdit,
};

#import <UIKit/UIKit.h>
#import "AppointmentManager.h"
@class AppointmentListModel;

NS_ASSUME_NONNULL_BEGIN

/**
 请假查询--等待结果
 */
@interface AskForLeaveQueryViewController : MKNavViewController
@property (nonatomic, strong) AppointmentListModel *appointmentModel;
@property (nonatomic, assign) AppointmentDisplayType showType;
@property (nonatomic, assign) AskForLeaveQueryCheckType checkType;
@end

NS_ASSUME_NONNULL_END
