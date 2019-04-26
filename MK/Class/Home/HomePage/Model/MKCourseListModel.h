//
//  MKCourseListModel.h
//  MK
//
//  Created by 周洋 on 2019/4/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//@interface MKLecturerListModel : NSObject
//@property (nonatomic, copy) NSString *lecturerID;
//@property (nonatomic, copy) NSString *teacherName;
//@end

@interface MKCourseListModel : NSObject
@property (nonatomic, copy) NSString *courseID;//课程ID
@property (nonatomic, copy) NSString *courseName;//课程名字
@property (nonatomic, copy) NSString *courseDescription;//课程简介
@property (nonatomic, copy) NSString *teacherNmae;//课程老师
@property (nonatomic, copy) NSString *coursePrice;//价格
@property (nonatomic, copy) NSString *is_live;//是否是直播
@property (nonatomic, copy) NSString *courseImage;//课程图片
@property (nonatomic, copy) NSString *is_online;//线上线下课程

@end

NS_ASSUME_NONNULL_END
