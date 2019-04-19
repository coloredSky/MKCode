//
//  HomeCourseCategoryModel.m
//  MK
//
//  Created by 周洋 on 2019/4/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "HomeCourseCategoryModel.h"

@implementation HomeCourseCategoryModel

+ (NSDictionary *)modelCustomPropertyMapper {
    // 将personId映射到key为id的数据字段
    return @{@"categoryID":@"id",
             @"categoryName" : @"name"
             };
}
@end
