//
//  CourseDetailViewController.h
//  MK
//
//  Created by 周洋 on 2019/3/20.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKBaseViewController.h"
#import "CourseDetailScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseDetailViewController : MKNavViewController

@property (nonatomic, copy) NSString *course_id;//课程ID
@property (nonatomic, assign) CourseSituationType courseType;//显示类型：线上、线下

//从我的课程push过来  当有视频需要自动播放时
@property (nonatomic, copy) NSString *lessonID;
@property (nonatomic, assign) BOOL autoPlay;//自动播放

@end

NS_ASSUME_NONNULL_END
