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

@property (nonatomic, copy) NSString *applyID;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *class_id;
@property (nonatomic, copy) NSString *classNewID;
@property (nonatomic, copy) NSString *reason;
@property (nonatomic, copy) NSString *reject_reason;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *update_time;

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *staff_name;
@property (nonatomic, copy) NSString *selected_time;
@property (nonatomic, copy) NSString *select_time_one;
@property (nonatomic, copy) NSString *select_time_two;
@property (nonatomic, copy) NSString *select_time_three;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *confirm_staff_id;
@property (nonatomic, copy) NSString *confirm_time;
@property (nonatomic, copy) NSString *confirm_detail;
@end

NS_ASSUME_NONNULL_END
