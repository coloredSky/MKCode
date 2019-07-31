//
//  MKCourseListModel.m
//  MK
//
//  Created by 周洋 on 2019/4/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKCourseListModel.h"
#import "UserCourseOfflineClassList.h"

@implementation MKCourseListModel

-(instancetype)init
{
    if (self = [super init]) {
        _className_list = [NSMutableArray array];
    }
    return self;
}

// 当 JSON 转为 Model 完成后，该方法会被调用。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    if (![NSString isEmptyWithStr:dic[@"detail"]]) {
        NSString *courseDescription = [NSString htmlStringTransToString:dic[@"detail"]];
        _courseDescription = [NSString filterHTML:courseDescription];
    }
    
    if (_class_list.count >0) {
        for (UserCourseOfflineClassList *model in _class_list) {
            [_className_list addObject:model.name];
        }
    }
    return YES;
}

+ (NSDictionary *)modelCustomPropertyMapper
{
//    @"bookID" : @[@"ID",@"id",@"book_id"]
    // 将personId映射到key为id的数据字段
    return @{
             @"courseID" : @[@"id",@"course_id"],
             @"courseName" : @[@"name",@"course_name"],
             @"teacherNmae" : @[@"lecturer_name",@"teacher_name",@"lectureName"],
             @"courseImage" : @[@"img",@"url",@"course_img"],
             @"coursePrice" : @"price",
             @"courseDescription" : @"detail",
             @"lessonID" : @"video_id",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"class_list" : [UserCourseOfflineClassList class]};
}
@end

//@implementation MKLecturerListModel
//+ (NSDictionary *)modelCustomPropertyMapper {
//    // 将personId映射到key为id的数据字段
//    return @{@"lecturerID":@"id",
//             @"teacherName" : @"name"
//             };
//}
//@end
