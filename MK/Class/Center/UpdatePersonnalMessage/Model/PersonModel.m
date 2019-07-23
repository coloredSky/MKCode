//
//  PersonModel.m
//  MK
//
//  Created by ginluck on 2019/6/13.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "PersonModel.h"


@implementation PersonModel

// 当 JSON 转为 Model 完成后，该方法会被调用。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    if (![NSString isEmptyWithStr:_userInfo.jlptID]){
        for (JapaneseLanguageAbilityList *jpModel in _japaneseLanguageAbilityList) {
            if ([jpModel.japaneseAbilityID integerValue] == [_userInfo.jlptID integerValue]) {
                _userInfo.jlptString = jpModel.name;
            }
        }
    }
    return YES;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"japaneseLanguageAbilityList" : [JapaneseLanguageAbilityList class],
             @"languageSchoolList" : [LanguageSchoolList class],
             @"languageSchoolTimeList" : [LanguageSchoolTimeList class],
             @"volunteerUniversityList" : [MKUniversityModel class],
             @"userInfo" : [userInfo class],
             };
}

@end
