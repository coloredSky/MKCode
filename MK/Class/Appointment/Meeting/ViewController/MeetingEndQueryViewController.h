//
//  MeetingEndQueryViewController.h
//  MK
//
//  Created by 周洋 on 2019/4/1.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppointmentListModel;

NS_ASSUME_NONNULL_BEGIN

/**
 预约结束--结果查询
 */
@interface MeetingEndQueryViewController : MKNavViewController
@property (nonatomic, strong) AppointmentListModel *appointmentModel;
@end

NS_ASSUME_NONNULL_END
