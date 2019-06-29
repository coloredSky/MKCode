//
//  PersonModel.m
//  MK
//
//  Created by ginluck on 2019/6/13.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "PersonModel.h"


@implementation PersonModel



+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"japaneseLanguageAbilityList" : [JapaneseLanguageAbilityList class],
             @"languageSchoolList" : [LanguageSchoolList class],
             @"languageSchoolTimeList" : [LanguageSchoolTimeList class],
             @"volunteerUniversityList" : [MKUniversityModel class],
             @"userInfo" : [userInfo class],
             };
}

@end
