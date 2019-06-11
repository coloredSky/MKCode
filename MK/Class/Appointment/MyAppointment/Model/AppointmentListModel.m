//
//  AppointmentListModel.m
//  MK
//
//  Created by 周洋 on 2019/6/3.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "AppointmentListModel.h"

@implementation AppointmentListModel

// 当 JSON 转为 Model 完成后，该方法会被调用。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    if (![NSString isEmptyWithStr:_add_time]) {
        _add_time = [NSString timeTransformWithDate:_add_time WithFormModel:@"YYYY-MM-dd HH:mm:ss" toModel:@"MM月dd日 HH:mm"];;
    }
    if (![NSString isEmptyWithStr:_select_time_one]) {
        _show_time_one = [NSString timeTransformWithDate:_select_time_one WithFormModel:@"YYYY-MM-dd HH:mm:ss" toModel:@"YY年MM月dd日 HH:mm"];
    }else{
        _select_time_one = @"";
    }
    if (![NSString isEmptyWithStr:_select_time_two]) {
        _show_time_two = [NSString timeTransformWithDate:_select_time_two WithFormModel:@"YYYY-MM-dd HH:mm:ss" toModel:@"YY年MM月dd日 HH:mm"];
    }else{
        _select_time_two = @"";
    }
    if (![NSString isEmptyWithStr:_select_time_three]) {
        _show_time_three = [NSString timeTransformWithDate:_select_time_three WithFormModel:@"YYYY-MM-dd HH:mm:ss" toModel:@"YY年MM月dd日 HH:mm"];
    }else{
        _select_time_three = @"";
    }
    if ([NSString isEmptyWithStr:_type]) {
        _type = @"";
    }
    if ([NSString isEmptyWithStr:_staff_name]) {
        _staff_name = @"";
    }
    if ([NSString isEmptyWithStr:_address]) {
        _address = @"---";
    }
    return YES;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    // 将personId映射到key为id的数据字段
    return @{@"classNewID":@"new_class_id",
             @"applyID" : @"id",
             };
}

@end
