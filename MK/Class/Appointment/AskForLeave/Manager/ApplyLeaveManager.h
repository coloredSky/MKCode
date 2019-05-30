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

+(void)callBackAddApplyLeaveWithParameterClass_id:(NSString *)class_id lesson_id:(NSString *)lesson_id detail:(NSString *)detail completionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;

+(void)callBackEditApplyLeaveWithParameterApply_id:(NSString *)apply_id class_id:(NSString *)class_id lesson_id:(NSString *)lesson_id detail:(NSString *)detail completionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;
@end

NS_ASSUME_NONNULL_END
