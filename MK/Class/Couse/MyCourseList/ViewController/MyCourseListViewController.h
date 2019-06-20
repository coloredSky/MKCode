//
//  MyCourseListViewController.h
//  MK
//
//  Created by 周洋 on 2019/4/10.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCourseListManager.h"
@class MKCourseListModel;

NS_ASSUME_NONNULL_BEGIN

@interface MyCourseListViewController : MKNavViewController

@property (nonatomic, strong) NSArray<MKCourseListModel *> *courseList;
@property (nonatomic, assign) UserCourseListViewShowType courseListShowType;
@end

NS_ASSUME_NONNULL_END
