//
//  FeedBackTypeModel.m
//  MK
//
//  Created by 周洋 on 2019/6/20.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "FeedBackTypeModel.h"

@implementation FeedBackTypeModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    return YES;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    // 将personId映射到key为id的数据字段
    return @{@"feedBackID":@"id",
             @"feedBackTitle" : @"name",
             };
}

@end
