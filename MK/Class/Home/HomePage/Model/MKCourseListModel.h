//
//  MKCourseListModel.h
//  MK
//
//  Created by 周洋 on 2019/4/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserCourseOfflineClassList;

NS_ASSUME_NONNULL_BEGIN

@interface MKCourseListModel : NSObject

@property (nonatomic, copy) NSString *courseID;//课程ID
@property (nonatomic, copy) NSString *courseName;//课程名字
@property (nonatomic, copy) NSString *courseDescription;//课程简介
@property (nonatomic, copy) NSString *teacherNmae;//课程老师
@property (nonatomic, copy) NSString *coursePrice;//价格
@property (nonatomic, copy) NSString *is_live;//是否是直播
@property (nonatomic, copy) NSString *courseImage;//课程图片
@property (nonatomic, copy) NSString *is_online;//线上线下课程
@property (nonatomic, copy) NSString *has_class;//线下课程,是否选班
@property (nonatomic, strong) NSArray <UserCourseOfflineClassList *>*class_list;//线下课程,可以选班的班级列表


//我的课程中最上部的视频播放用到
@property (nonatomic, copy) NSString *video_name;//视频名称
@property (nonatomic, copy) NSString *view_time;//视频时间
@property (nonatomic, copy) NSString *lessonID;//课时ID


//线下课程
//@property (nonatomic, copy) NSString *course_id;//
//@property (nonatomic, copy) NSString *course_name;//
@property (nonatomic, copy) NSString *class_adviser;//
@property (nonatomic, copy) NSString *min_date;//
@property (nonatomic, copy) NSString *max_date;//
@property (nonatomic, copy) NSString *total_les_num;//
@property (nonatomic, copy) NSString *study_les_num;//
//@property (nonatomic, copy) NSString *teacher_name;//老师名字
@property (nonatomic, copy) NSString *process;//进度

@end

NS_ASSUME_NONNULL_END
