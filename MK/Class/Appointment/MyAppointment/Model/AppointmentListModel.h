//
//  AppointmentListModel.h
//  MK
//
//  Created by 周洋 on 2019/6/3.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppointmentListModel : NSObject

@property (nonatomic, copy) NSString *applyID;//申请ID
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *class_id;
@property (nonatomic, copy) NSString *classNewID;
@property (nonatomic, copy) NSString *reason;
@property (nonatomic, copy) NSString *reject_reason;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *add_time;//添加的时间
@property (nonatomic, copy) NSString *update_time;

@property (nonatomic, copy) NSString *type;//预约相谈的类型名字
@property (nonatomic, copy) NSString *staff_name;//老师名字
@property (nonatomic, copy) NSString *selected_time;
@property (nonatomic, copy) NSString *select_time_one;//预约时间1
@property (nonatomic, copy) NSString *select_time_two;//预约时间2
@property (nonatomic, copy) NSString *select_time_three;//预约时间3
@property (nonatomic, copy) NSString *show_time_one;
@property (nonatomic, copy) NSString *show_time_two;
@property (nonatomic, copy) NSString *show_time_three;
@property (nonatomic, copy) NSString *address;//预约地址
@property (nonatomic, copy) NSString *confirm_staff_id;
@property (nonatomic, copy) NSString *confirm_time;
@property (nonatomic, copy) NSString *confirm_detail;
@property (nonatomic, copy) NSString *status_msg;

@end

NS_ASSUME_NONNULL_END
