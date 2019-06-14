//
//  ApplyLeaveCourseModel.h
//  MK
//
//  Created by 周洋 on 2019/5/29.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApplyLeaveLessonModel : NSObject
@property (nonatomic, copy) NSString *lesson_id;
@property (nonatomic, copy) NSString *lesson_name;
@end

@interface ApplyLeaveCourseModel : NSObject
@property (nonatomic, copy) NSString *class_id;
@property (nonatomic, copy) NSString *class_name;
@property (nonatomic, strong) NSArray *lessonList;
@property (nonatomic, strong) NSMutableArray *lessonNameList;
@end



NS_ASSUME_NONNULL_END
