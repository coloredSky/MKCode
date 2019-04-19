//
//  MKCourseListModel.m
//  MK
//
//  Created by 周洋 on 2019/4/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKCourseListModel.h"

@implementation MKCourseListModel
// 当 JSON 转为 Model 完成后，该方法会被调用。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    if (_lecturersList.count >0) {
        MKLecturerListModel *lecturerListModel = _lecturersList[0];
        _teacherNmae = [NSString stringWithFormat:@"%@、等",lecturerListModel.teacherName];
    }
    return YES;
}

+ (NSDictionary *)modelCustomPropertyMapper
{
    // 将personId映射到key为id的数据字段
    return @{@"courseID":@"id",
             @"courseName" : @"name",
             @"coursePrice" : @"price",
             @"courseName" : @"name",
             @"lecturersList" : @"lecturers"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"lecturersList" : [MKLecturerListModel class]};
}
@end

@implementation MKLecturerListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    // 将personId映射到key为id的数据字段
    return @{@"lecturerID":@"id",
             @"teacherName" : @"name"
             };
}
@end
