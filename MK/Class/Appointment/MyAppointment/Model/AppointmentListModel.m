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
    return YES;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    // 将personId映射到key为id的数据字段
    return @{@"classNewID":@"new_class_id",
             };
}

@end
