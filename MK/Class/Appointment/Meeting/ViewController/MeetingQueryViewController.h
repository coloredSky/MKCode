//
//  MeetingQueryViewController.h
//  MK
//
//  Created by 周洋 on 2019/4/1.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppointmentManager.h"
@class AppointmentListModel;

NS_ASSUME_NONNULL_BEGIN


/**
 预约查询-等待回复。可编辑、删除
 */
@interface MeetingQueryViewController : MKNavViewController
@property (nonatomic, strong) AppointmentListModel *appointmentModel;
@property (nonatomic, assign) AppointmentDisplayType showType;
@end

NS_ASSUME_NONNULL_END
