//
//  MyOnlineCourseListView.h
//  MK
//
//  Created by 周洋 on 2019/4/10.
//  Copyright © 2019年 周洋. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "UserCourseListManager.h"


NS_ASSUME_NONNULL_BEGIN

@protocol MyOnlineCourseListViewDelagate <NSObject>
@optional
-(void)myOnlineCourseListViewDidSelectedCourseWithIndexPath:(NSIndexPath *)indexPath andUserCourseListViewShowType:(UserCourseListViewShowType )listViewShowType withCourseModel:(MKCourseListModel *)courseModel;
@end
/**
 线上课程List
 */
@interface MyOnlineCourseListView : UIView

@property (nonatomic, assign) id<MyOnlineCourseListViewDelagate> delegate;
@property (nonatomic, assign) UserCourseListViewShowType listViewShowType;

-(void)onlineCourseListViewRefreshDataWithContentArr:(NSArray<MKCourseListModel *> *)courseList;

@end

NS_ASSUME_NONNULL_END
