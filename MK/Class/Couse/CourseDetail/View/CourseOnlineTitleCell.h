//
//  CourseOnlineTitleCell.h
//  MK
//
//  Created by 周洋 on 2019/3/25.
//  Copyright © 2019年 周洋. All rights reserved.
//
@class MKCourseDetailModel;
#import "MKBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

/**
 课程介绍-名字-课时-人数
 */
@interface CourseOnlineTitleCell : MKBaseTableViewCell
@property (nonatomic, copy) void(^courseCollectionBlock)(UIButton *sender);

-(void)cellRefreshDataWithCourseDetailModel:(MKCourseDetailModel *)courseDetailMode;

@end

NS_ASSUME_NONNULL_END
