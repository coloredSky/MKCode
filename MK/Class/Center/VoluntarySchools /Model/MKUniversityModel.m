//
//  MKUniversityModel.m
//  MK
//
//  Created by 周洋 on 2019/6/25.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "MKUniversityModel.h"

@implementation MKUniversityDisciplineListModel


@end

@implementation MKUniversityFacultyListModel

// 当 JSON 转为 Model 完成后，该方法会被调用。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    
    return YES;
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"disciplineList" : [MKUniversityDisciplineListModel class],
             };
}

@end

@implementation MKUniversityModel

+ (NSDictionary *)modelCustomPropertyMapper {
    // 将personId映射到key为id的数据字段
    return @{@"universityID":@"id",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"facultyList" : [MKUniversityFacultyListModel class],
             };
}
@end
