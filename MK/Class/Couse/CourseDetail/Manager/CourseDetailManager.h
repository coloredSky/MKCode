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
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseDetailManager : NSObject

+(void)callBackCourseDetailRequestWithHudShow:(BOOL )hudShow courseID:(NSString *)course_id andCompletionBlock:(void(^)(BOOL isSuccess, NSString *message, MKCourseDetailModel *courseDetailModel))completionBlock;
@end

NS_ASSUME_NONNULL_END
