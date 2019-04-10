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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseDetailManager : NSObject

@end

NS_ASSUME_NONNULL_END
