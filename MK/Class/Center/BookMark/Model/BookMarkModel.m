//
//  BookMarkModel.m
//  MK
//
//  Created by 周洋 on 2019/6/20.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "BookMarkModel.h"

@implementation BookMarkModel

@end


@implementation BookMarkListModel

// 当 JSON 转为 Model 完成后，该方法会被调用。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    if ([NSString isEmptyWithStr:_category]) {
        _category = @"";
    }
    if ([NSString isEmptyWithStr:_name]) {
        _name = @"";
    }
    return YES;
}


@end

