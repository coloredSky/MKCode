//
//  HomePublicCourseModel.m
//  MK
//
//  Created by 周洋 on 2019/4/23.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "HomePublicCourseModel.h"

@implementation HomePublicCourseModel

+ (NSDictionary *)modelCustomPropertyMapper {
    // 将personId映射到key为id的数据字段
    return @{@"courseImage":@"img",
             @"courseUrl" : @"url",
             };
}

@end
