//
//  ApplyLeaveManager.h
//  MK
//
//  Created by 周洋 on 2019/5/29.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ApplyLeaveCourseModel;


NS_ASSUME_NONNULL_BEGIN

@interface ApplyLeaveManager : NSObject


/**
 得到请假的l课程列表

 @param is_studying_lesson 是否是还未结束的课时，1是,0否
 @param completionBlock 回调
 */
+(void)callBackApplyLeaveCourseListWithParameter:(NSString *)is_studying_lesson completionBlock:(void(^)(BOOL isSuccess,NSArray <ApplyLeaveCourseModel *>*courseList,NSString *message))completionBlock;

/**
 新增请假申请

 @param class_id 班级
 @param lesson_id 课程
 @param detail 理由
 @param completionBlock 回调
 */
+(void)callBackAddApplyLeaveWithParameterClass_id:(NSString *)class_id lesson_id:(NSString *)lesson_id detail:(NSString *)detail completionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;


/**
 编辑请假申请

 @param apply_id 申请ID
 @param class_id 班级
 @param lesson_id 课程
 @param detail 理由
 @param completionBlock 回调
 */
+(void)callBackEditApplyLeaveWithParameterApply_id:(NSString *)apply_id class_id:(NSString *)class_id lesson_id:(NSString *)lesson_id detail:(NSString *)detail completionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;


/**
 删除请假申请
 
 @param apply_id 申请ID
 @param completionBlock 回调
 */
+(void)callBackDeleteAskForLeaveRequestWithParameteApply_id:(NSString *)apply_id withCompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;

@end

NS_ASSUME_NONNULL_END
