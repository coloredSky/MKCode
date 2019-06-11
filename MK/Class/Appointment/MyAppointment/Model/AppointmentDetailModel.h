//
//  AppointmentDetailModel.h
//  MK
//
//  Created by 周洋 on 2019/6/10.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppointmentDetailModel : NSObject

@property (nonatomic, copy) NSString *applyID;//申请ID
@property (nonatomic, copy) NSString *class_id;
@property (nonatomic, copy) NSString *lesson_id;
@property (nonatomic, copy) NSString *detail;//理由
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *class_name;
@property (nonatomic, copy) NSString *lesson_name;
@property (nonatomic, copy) NSString *class_room_name;//
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *sname;


@end

NS_ASSUME_NONNULL_END
