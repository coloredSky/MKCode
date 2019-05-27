//
//  CourseDetailViewController.h
//  MK
//
//  Created by 周洋 on 2019/3/20.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKBaseViewController.h"
#import "CourseDetailManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseDetailViewController : MKNavViewController
@property (nonatomic, copy) NSString *course_id;
@property (nonatomic, assign) CourseSituationType courseType;
@end

NS_ASSUME_NONNULL_END
