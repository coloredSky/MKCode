//
//  MKBannerModel.m
//  MK
//
//  Created by 周洋 on 2019/4/22.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKBannerModel.h"

@implementation MKBannerModel

+ (NSDictionary *)modelCustomPropertyMapper {
    // 将personId映射到key为id的数据字段
    return @{@"bannerImage":@"img",
             @"bannerILinkUrl" : @"url",
             @"bannerTitle" : @"info"
             };
}

@end
