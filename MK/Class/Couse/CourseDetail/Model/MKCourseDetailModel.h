//
//  MKCourseDetailModel.h
//  MK
//
//  Created by 周洋 on 2019/4/24.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKLessonModel : NSObject
@property (nonatomic, copy) NSString *lessonID;//课时ID
@property (nonatomic, copy) NSString *lessonImage;//课时图片
@property (nonatomic, copy) NSString *lessonName;//课时名字
@property (nonatomic, copy) NSString *lessonTarget;//
@property (nonatomic, copy) NSString *video_id;//视频ID
@property (nonatomic, copy) NSString *lecturer_id;
@property (nonatomic, copy) NSString *video_time;//课时耗时
@property (nonatomic, copy) NSString *order_list;//课时排序
@property (nonatomic, copy) NSString *lessonDetail;//课时简介
@property (nonatomic, assign) BOOL isSelected;
@end

@interface MKCourseInfoModel : NSObject
@property (nonatomic, copy) NSString *courseID;//课程ID
@property (nonatomic, copy) NSString *courseName;//课程名字
@property (nonatomic, copy) NSString *courseLanguage;//课程语言
@property (nonatomic, copy) NSString *courseLevel;//
@property (nonatomic, copy) NSString *coursePrice;//课程价格
@property (nonatomic, copy) NSString *courseConsumingTime;//课程耗时
@property (nonatomic, copy) NSString *courseDetail;//课程简介
@property (nonatomic, copy) NSString *courseImage;//课程简介图片
@property (nonatomic, copy) NSString *totalStudyNum;//课程学习人数


@end

@interface MKCourseDetailModel : NSObject
@property (nonatomic, copy) NSString *video_id;//视频ID
@property (nonatomic, copy) NSString *video_ts;
@property (nonatomic, copy) NSString *video_sign;
@property (nonatomic, copy) NSString *teacher_id;//讲师ID
@property (nonatomic, copy) NSString *teacher_name;//讲师名字
@property (nonatomic, copy) NSString *teacher_avatar;//讲师头像
@property (nonatomic, copy) NSString *teacher_detail;//讲师简介
@property (nonatomic, strong)MKCourseInfoModel *courseInfoDetail;

//@property (nonatomic, strong) NSArray <MKCourseInfoModel *>*courseInfo;
@property (nonatomic, strong) NSArray <MKLessonModel *>*lessonList;//课时列表
@end

NS_ASSUME_NONNULL_END
