//
//  HomePageCell.h
//  MK
//
//  Created by 周洋 on 2019/3/14.
//  Copyright © 2019年 周洋. All rights reserved.
//
@class MKCourseListModel;
#import "MKBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

/**
 首页课程cell
 */
@interface HomePageCell : MKBaseTableViewCell

//刷新数据
-(void)cellRefreshDataWithMKCourseListModel:(MKCourseListModel *)model;
@end

NS_ASSUME_NONNULL_END
