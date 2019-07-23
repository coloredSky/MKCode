//
//  AppoinementReplyModel.m
//  MK
//
//  Created by 周洋 on 2019/6/13.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "AppoinementReplyModel.h"

@implementation AppoinementReplyModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    if (![NSString isEmptyWithStr:_content]) {
        CGFloat height = [_content getStrSizeWithSize:CGSizeMake(KScreenWidth-K_Padding_Home_LeftPadding*2-KScaleWidth(15+36), 3000) font:MKFont(13)].height;
        _rowHeight = height+KScaleHeight(10+20+30);
    }
    return YES;
}

@end
