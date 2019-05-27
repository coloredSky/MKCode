//
//  HomePublicCourseModel.h
//  MK
//
//  Created by 周洋 on 2019/4/23.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePublicCourseModel : NSObject
@property (nonatomic, copy) NSString *courseName;//课程名字
@property (nonatomic, copy) NSString *courseUrl;//课程Url
@property (nonatomic, copy) NSString *lectureName;//课时名字
@property (nonatomic, copy) NSString *startTime;//开始时间
@property (nonatomic, copy) NSString *endTime;//结束时间
@property (nonatomic, copy) NSString *courseImage;//课程简介图
@end

NS_ASSUME_NONNULL_END
