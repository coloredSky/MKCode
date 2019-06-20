//
//  MKOfflineCourseDetail.h
//  MK
//
//  Created by 周洋 on 2019/6/19.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKOfflineLesson : NSObject

@property (nonatomic, copy) NSString *course_id;//
@property (nonatomic, copy) NSString *attendance_status_zh;//上课状态
@property (nonatomic, copy) NSString *attendance_status;//
@property (nonatomic, copy) NSString *date;//
@property (nonatomic, copy) NSString *name;//
@property (nonatomic, copy) NSString *lessonDecription;//
@property (nonatomic, copy) NSString *is_over;//
@property (nonatomic, copy) NSString *total_hour;//
@property (nonatomic, copy) NSString *start_time;//
@property (nonatomic, copy) NSString *end_time;//


@end

@interface MKOfflineCourseDetail : NSObject

@property (nonatomic, copy) NSString *course_id;//课程ID
@property (nonatomic, copy) NSString *course_name;//课程名字
@property (nonatomic, copy) NSString *course_description;//课程描述
@property (nonatomic, copy) NSString *advisor_id;//
@property (nonatomic, copy) NSString *class_adviser;//老师
@property (nonatomic, copy) NSString *teacher_description;//老师简介
@property (nonatomic, copy) NSString *advisor_highest_education;//老师教育程度
@property (nonatomic, copy) NSString *advisor_school;//老师毕业学校
@property (nonatomic, copy) NSString *advisor_avatar;//老师头像
@property (nonatomic, copy) NSString *class_name;//
@property (nonatomic, copy) NSString *maximun_number;//
@property (nonatomic, copy) NSString *classroom_name;//教室
@property (nonatomic, copy) NSString *total_hour;//上课耗时
@property (nonatomic, copy) NSString *progress;//进度
@property (nonatomic, strong) NSArray <MKOfflineLesson *>*lessons;

@end

NS_ASSUME_NONNULL_END
