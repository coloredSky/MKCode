//
//  CourseDetailManager.h
//  MK
//
//  Created by 周洋 on 2019/4/10.
//  Copyright © 2019年 周洋. All rights reserved.
//

/**
 课程状态
 
 - CourseSituationTypeUnkown: 未知
 - CourseSituationTypeOnline: 线上
 - CourseSituationTypeOffline: 线下
 */
typedef NS_ENUM(NSUInteger, CourseSituationType) {
    CourseSituationTypeOnline,
    CourseSituationTypeOffline,
};

@class MKCourseDetailModel;
@class MKOfflineCourseDetail;
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseDetailManager : NSObject


/**
 线上课程详情

 @param hudShow 是否loading
 @param course_id 课程ID
 @param completionBlock 回调
 */
+(void)callBackCourseDetailRequestWithHudShow:(BOOL )hudShow courseID:(NSString *)course_id andCompletionBlock:(void(^)(BOOL isSuccess, NSString *message, MKCourseDetailModel *courseDetailModel))completionBlock;



/**
 线下课程详情

 @param course_id 课程ID
 @param completionBlock 回调
 */
+(void)callBackOfflineCourseDetailRequestWithCourseID:(NSString *)course_id andCompletionBlock:(void(^)(BOOL isSuccess, NSString *message, MKOfflineCourseDetail *courseDetailModel))completionBlock;

/**
 课程收藏

 @param course_id 课程ID
 @param type 课程类型：1 - 线上课程；2 - 线下课程
 @param completionBlock 回调
 */
+(void)callBackCourseCollectionRequestWithCourseID:(NSString *)course_id type:(NSInteger )type andCompletionBlock:(void(^)(BOOL isSuccess, NSString *message))completionBlock;

/**
 课程x取消收藏
 
 @param course_id 课程ID
 @param type 课程类型：1 - 线上课程；2 - 线下课程
 @param completionBlock 回调
 */
+(void)callBackCourseCancleCollectionRequestWithCourseID:(NSString *)course_id type:(NSInteger )type andCompletionBlock:(void(^)(BOOL isSuccess, NSString *message))completionBlock;

/**
 记录视频播放

 @param video_id 视频ID
 @param completionBlock 回调
 */
+(void)callBackRecordLessonPlayRequestWithVideo_id:(NSString *)video_id andCompletionBlock:(void(^)(BOOL isSuccess, NSString *message))completionBlock;

@end

NS_ASSUME_NONNULL_END
