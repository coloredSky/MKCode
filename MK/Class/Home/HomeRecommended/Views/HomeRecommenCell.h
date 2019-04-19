//
//  HomeRecommenCell.h
//  MK
//
//  Created by 周洋 on 2019/3/19.
//  Copyright © 2019年 周洋. All rights reserved.
//

@class MKCourseListModel;
#import "MKBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeRecommenCell : MKBaseTableViewCell
-(void)cellRefreshDataWithMKCourseListModel:(MKCourseListModel *)model;
@end

NS_ASSUME_NONNULL_END
