//
//  JapaneseLanguageAbilityList.m
//  MK
//
//  Created by ginluck on 2019/6/13.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "JapaneseLanguageAbilityList.h"

@implementation JapaneseLanguageAbilityList

+ (NSDictionary *)modelCustomPropertyMapper {
    // 将personId映射到key为id的数据字段
    return @{@"japaneseAbilityID":@"id"
             };
}

@end
