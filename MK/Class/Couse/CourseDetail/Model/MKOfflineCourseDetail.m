//
//  MKOfflineCourseDetail.m
//  MK
//
//  Created by 周洋 on 2019/6/19.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "MKOfflineCourseDetail.h"

@implementation MKOfflineLesson

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    if (![NSString isEmptyWithStr:_lessonDecription]) {
        _lessonDecription = [NSString filterHTML:_lessonDecription];
    }else{
        _lessonDecription = @"";
    }
    if (![NSString isEmptyWithStr:_start_time]) {
        _start_time = [NSString timeTransformWithDate:_start_time WithFormModel:@"YYYY-MM-dd HH:mm:ss" toModel:@"HH:mm"];
    }else{
        _start_time = @"";
    }
    if (![NSString isEmptyWithStr:_end_time]) {
        _end_time = [NSString timeTransformWithDate:_end_time WithFormModel:@"YYYY-MM-dd HH:mm:ss" toModel:@"HH:mm"];
    }else{
        _end_time = @"";
    }
    return YES;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    // 将personId映射到key为id的数据字段
    return @{@"lessonDecription":@"description"
             };
}

@end

@implementation MKOfflineCourseDetail

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    if ([NSString isEmptyWithStr:_classroom_name]) {
        _classroom_name = @"---";
    }
    if ([NSString isEmptyWithStr:_classroom_name]) {
        _classroom_name = @"";
    }
    if ([NSString isEmptyWithStr:_class_adviser]) {
        _class_adviser = @"";
    }
    if ([NSString isEmptyWithStr:_advisor_school]) {
        _advisor_school = @"";
    }
    if ([NSString isEmptyWithStr:_advisor_highest_education]) {
        _advisor_highest_education = @"";
    }
    _teacher_description = [NSString stringWithFormat:@"%@ %@",_advisor_school,_advisor_highest_education];
    return YES;
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"lessons" : [MKOfflineLesson class],
             };
}

@end
