//
//  UserCourseListManager.h
//  MK
//
//  Created by 周洋 on 2019/4/10.
//  Copyright © 2019年 周洋. All rights reserved.
//

typedef NS_ENUM(NSUInteger, UserCourseListViewShowType) {
    UserCourseListViewShowTypeOnline,
    UserCourseListViewShowTypeOfflineUnderWay,
    UserCourseListViewShowTypeOfflineNotStart,
    UserCourseListViewShowTypeOfflineHaveEnd
};

#import <Foundation/Foundation.h>
@class MKCourseListModel;
@class UserCourseModel;

NS_ASSUME_NONNULL_BEGIN

@interface UserCourseListManager : NSObject


/**
 用户课程列表

 @param completionBlock 回调
 */
//+(void)callBackUserCourseListWithCompletionBlock:(void(^)(BOOL isSuccess,NSArray <NSArray *>*userCourseList,NSArray < MKCourseListModel*>*onLineCourseList,NSArray <MKCourseListModel *>*offLineCourseList,NSString *message))completionBlock;

+(void)callBackUserCourseListWithCompletionBlock:(void(^)(BOOL isSuccess,MKCourseListModel *lastCourseListModel,NSArray <UserCourseModel *>*userCourseList,NSArray <MKCourseListModel *>*offLineCourseList,NSArray <MKCourseListModel *>*onLineCourseList,NSString *message))completionBlock;


/**
 学生未分班课程选择班级

 @param course_id 课程ID
 @param class_id 班级ID
 @param completionBlock 回调
 */
+(void)callBackUserCourseJoinClassWithParameterCourse_id:(NSString *)course_id class_id:(NSString *)class_id completionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;

@end

NS_ASSUME_NONNULL_END
