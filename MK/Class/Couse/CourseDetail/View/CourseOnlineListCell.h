//
//  CourseOnlineListCell.h
//  MK
//
//  Created by 周洋 on 2019/3/25.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKBaseTableViewCell.h"
@class MKLessonModel;

NS_ASSUME_NONNULL_BEGIN

/**
 线上课程视频列表
 */
@interface CourseOnlineListCell : MKBaseTableViewCell
-(void)cellRefreshDataWithLessonModel:(MKLessonModel *)model;
@end

NS_ASSUME_NONNULL_END
