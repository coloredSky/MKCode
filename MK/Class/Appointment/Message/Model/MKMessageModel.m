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
        NSString *content = @"1. 新增功能 ：增加了课程预约和调换班级，使用 每刻小管家即可轻松解决各种课程相关问题。\n1. 新增功能 ：增加了课程预约和调换班级，使用 每刻小管家即可轻松解决各种课程相关问题。";
        CGSize contentSize = [content getStrSizeWithSize:CGSizeMake(KScreenWidth-K_Padding_Home_LeftPadding*2-K_Padding_LeftPadding-KScaleWidth(40)-KScaleWidth(22)-KScaleWidth(12), 3000) font:K_Font_Text_Normal_little];
        if (contentSize.height <= 30) {
            _cellHeight = KScaleHeight(100)+KScaleHeight(30);
        }else{
            _cellHeight = KScaleHeight(100)+contentSize.height;
        }
    }
    return self;
}
@end
