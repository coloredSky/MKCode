//
//  MKCourseDetailModel.m
//  MK
//
//  Created by 周洋 on 2019/4/24.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKCourseDetailModel.h"

@implementation MKLessonModel

+ (NSDictionary *)modelCustomPropertyMapper
{
    // 将personId映射到key为id的数据字段
    return @{@"lessonID":@"id",
             @"lessonName" : @"name",
             @"lessonTarget" : @"target",
             @"lessonDetail" : @"detail"
             };
}
@end

@implementation MKCourseInfoModel
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    if ([NSString isEmptyWithStr:_courseDetail]) {
        _courseDetail = @"";
    }
    return YES;
}
+ (NSDictionary *)modelCustomPropertyMapper
{
    // 将personId映射到key为id的数据字段
    return @{
             @"courseID" : @"id",
             @"courseName" : @"name",
             @"courseLanguage" : @"language",
             @"coursePrice" : @"price",
             @"courseLevel" : @"level",
             @"courseConsumingTime" : @"days",
             @"courseDetail" : @"detail"
             };
}
@end

@implementation MKCourseDetailModel
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    if (_courseInfo.count > 0) {
        _courseInfoDetail = _courseInfo[0];
    }
    return YES;
}

+ (NSDictionary *)modelCustomPropertyMapper
{
    // 将personId映射到key为id的数据字段
    return @{
             @"video_id" : @"playInfo.video_id",
             @"video_ts":@"playInfo.ts",
             @"video_sign" : @"playInfo.sign",
             @"teacher_id" : @"lecturerInfo.id",
             @"teacher_name" : @"lecturerInfo.name",
             @"teacher_avatar" : @"lecturerInfo.avatar",
             @"teacher_detail" : @"lecturerInfo.detail",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"lessonList" : [MKLessonModel class], @"courseInfo" : [MKCourseInfoModel class]};
}
@end
