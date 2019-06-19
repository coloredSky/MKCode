//
//  CourseOfflineListCell.h
//  MK
//
//  Created by 周洋 on 2019/3/27.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKBaseTableViewCell.h"
@class MKLessonModel;
@class MKOfflineLesson;

NS_ASSUME_NONNULL_BEGIN

/**
 线下的课程列表
 */
@interface CourseOfflineListCell : MKBaseTableViewCell

-(void)cellRefreshDataWithLessonModel:(MKOfflineLesson *)model;

@end

NS_ASSUME_NONNULL_END
