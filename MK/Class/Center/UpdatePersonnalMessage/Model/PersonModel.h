//
//  PersonModel.h
//  MK
//
//  Created by ginluck on 2019/6/13.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "userInfo.h"
#import "JapaneseLanguageAbilityList.h"
#import "LanguageSchoolList.h"
#import "LanguageSchoolTimeList.h"
#import "VolunteerUniversityList.h"
#import "VolunteerFacultyList.h"
#import "VolunteerDisciplineList.h"
NS_ASSUME_NONNULL_BEGIN

@interface PersonModel : NSObject

@property(nonatomic,strong)NSArray <JapaneseLanguageAbilityList *>*japaneseLanguageAbilityList;//用户日语能力选择

@property(nonatomic,strong)NSArray <LanguageSchoolList *>*languageSchoolList;//语言学校选择
@property(nonatomic,strong)NSArray <LanguageSchoolTimeList *>*languageSchoolTimeList;//语言学校时间选择

@property(nonatomic,strong)NSArray <VolunteerUniversityList *>*volunteerUniversityList;//志愿学校
@property(nonatomic,strong)NSArray <VolunteerFacultyList *>*volunteerFacultyList;//志愿学部
@property(nonatomic,strong)NSArray <VolunteerDisciplineList *>*volunteerDisciplineList;//志愿学科

@property(nonatomic,strong)userInfo * userInfo;//用户个人信息

@end

NS_ASSUME_NONNULL_END
