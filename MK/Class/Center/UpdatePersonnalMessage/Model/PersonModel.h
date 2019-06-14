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
@property(nonatomic,strong)NSArray <JapaneseLanguageAbilityList *>*japaneseLanguageAbilityList;
@property(nonatomic,strong)NSArray <LanguageSchoolList *>*languageSchoolList;
@property(nonatomic,strong)NSArray <LanguageSchoolTimeList *>*languageSchoolTimeList;
@property(nonatomic,strong)NSArray <VolunteerUniversityList *>*volunteerUniversityList;
@property(nonatomic,strong)NSArray <VolunteerFacultyList *>*volunteerFacultyList;
@property(nonatomic,strong)NSArray <VolunteerDisciplineList *>*volunteerDisciplineList;
@property(nonatomic,strong)userInfo * userInfo;
@end

NS_ASSUME_NONNULL_END
