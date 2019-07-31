//
//  MKMessageModel.m
//  MK
//
//  Created by 周洋 on 2019/3/27.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKMessageModel.h"

@implementation MKMessageModel
-(instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    CGSize contentSize = [_content getStrSizeWithSize:CGSizeMake(KScreenWidth-K_Padding_Home_LeftPadding*2-K_Padding_LeftPadding-KScaleWidth(40)-KScaleWidth(22)-KScaleWidth(12), 3000) font:K_Font_Text_Normal_little];
    if (contentSize.height <= 30) {
        _cellHeight = KScaleHeight(110)+KScaleHeight(30);
    }else{
        _cellHeight = KScaleHeight(110)+contentSize.height;
    }
    if (![NSString isEmptyWithStr:_add_time]) {
        _add_time = [NSString timeTransformWithDate:_add_time WithFormModel:@"YY-MM-dd HH:mm:ss" toModel:@"YY/MM/dd HH:mm"];
    }
    return YES;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    // 将personId映射到key为id的数据字段
    return @{@"messageID":@"id",
             @"content" : @"detail",
             };
}

@end
