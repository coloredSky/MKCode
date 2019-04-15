//
//  AppointmentManager.h
//  MK
//
//  Created by 周洋 on 2019/4/15.
//  Copyright © 2019年 周洋. All rights reserved.
//

/**
 申请展示类型
 - AppointmentDisplayTypeChangeClass: 换班
 - AppointmentDisplayTypeAskForLeave: 请假
 - AppointmentDisplayTypeMeeting: 预约相谈
 */
typedef NS_ENUM(NSUInteger, AppointmentDisplayType) {
    AppointmentDisplayTypeChangeClass,
    AppointmentDisplayTypeAskForLeave,
    AppointmentDisplayTypeMeeting,
};

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppointmentManager : NSObject

@end

NS_ASSUME_NONNULL_END
