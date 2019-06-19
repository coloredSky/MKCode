//
//  CourseOfflineTitleCell.h
//  MK
//
//  Created by 周洋 on 2019/3/27.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKBaseTableViewCell.h"
@class MKOfflineCourseDetail;

NS_ASSUME_NONNULL_BEGIN

/**
 线下课程的课程介绍cell
 */
@interface CourseOfflineTitleCell : MKBaseTableViewCell
-(void)cellRefreshDataWithMKOfflineCourseDetail:(MKOfflineCourseDetail *)offlineCourseModel;
@end

NS_ASSUME_NONNULL_END
