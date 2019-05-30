//
//  ApplyLeaveCourseModel.m
//  MK
//
//  Created by 周洋 on 2019/5/29.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "ApplyLeaveCourseModel.h"

@implementation ApplyLeaveLessonModel

@end

@implementation ApplyLeaveCourseModel

-(instancetype)init
{
    if (self = [super init]) {
        _lessonNameList = [NSMutableArray array];
    }
    return self;
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    for (ApplyLeaveLessonModel *lessonModel in self.lessonList) {
        [_lessonNameList addObject:lessonModel.lesson_name];
    }
    return YES;
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
        @"lessonList" : [ApplyLeaveLessonModel class],
    };
}

@end
