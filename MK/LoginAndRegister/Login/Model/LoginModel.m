//
//  LoginModel.m
//  MK
//
//  Created by ginluck on 2019/4/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel

// 当 JSON 转为 Model 完成后，该方法会被调用。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    if ([NSString isEmptyWithStr:dic[@"lastname"]]) {
        _lastname  = @"";
    }
    if ([NSString isEmptyWithStr:dic[@"firstname"]]) {
        _firstname  = @"";
    }
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init]; return [self yy_modelInitWithCoder:aDecoder];
}
@end
