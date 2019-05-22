//
//  CourseTeacherCell.h
//  MK
//
//  Created by 周洋 on 2019/3/25.
//  Copyright © 2019年 周洋. All rights reserved.
//

@class MKCourseDetailModel;
#import "MKBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

/**
 课程详情中老师的介绍
 */
@interface CourseTeacherCell : MKBaseTableViewCell
-(void)cellRefreshDataWithCourseDetailModel:(MKCourseDetailModel *)courseDetailMode;
@end

NS_ASSUME_NONNULL_END
