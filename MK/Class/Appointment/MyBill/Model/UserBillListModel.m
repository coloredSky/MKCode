//
//  UserBillListModel.m
//  MK
//
//  Created by 周洋 on 2019/6/17.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "UserBillListModel.h"

@implementation UserBillListModel

// 当 JSON 转为 Model 完成后，该方法会被调用。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    return YES;
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"payments" : [UserBillPaymentModel class],
             };
}

//+ (NSDictionary *)modelCustomPropertyMapper {
//    // 将personId映射到key为id的数据字段
//    return @{
//             };
//}

@end

@implementation UserBillPaymentModel

@end
