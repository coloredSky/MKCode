//
//  AskForLeaveEndViewController.h
//  MK
//
//  Created by 周洋 on 2019/4/3.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppointmentListModel;

NS_ASSUME_NONNULL_BEGIN

/**
 请假结束--查询
 */
@interface AskForLeaveEndViewController : MKNavViewController
@property (nonatomic, strong) AppointmentListModel *appointmentModel;
@end

NS_ASSUME_NONNULL_END
