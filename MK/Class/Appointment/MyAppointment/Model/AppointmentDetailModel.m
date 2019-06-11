//
//  AppointmentDetailModel.m
//  MK
//
//  Created by 周洋 on 2019/6/10.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "AppointmentDetailModel.h"

@implementation AppointmentDetailModel

// 当 JSON 转为 Model 完成后，该方法会被调用。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    if ([NSString isEmptyWithStr:_class_name]) {
        _class_name =@"";
    }
    if ([NSString isEmptyWithStr:_lesson_name]) {
        _lesson_name =@"";
    }
    return YES;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    // 将personId映射到key为id的数据字段
    return @{
             @"applyID" : @"id",
             };
}


@end
