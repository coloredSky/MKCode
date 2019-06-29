//
//  userInfo.m
//  MK
//
//  Created by ginluck on 2019/6/13.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "userInfo.h"

@interface userInfo()<NSCopying>

@end

@implementation userInfo

- (instancetype)copyWithZone:(NSZone *)zone {
    
    userInfo *userModel = [[self class]allocWithZone:zone];
    userModel.userID = self.userID;
    userModel.username = self.username;
    userModel.lastname = self.lastname;
    userModel.firstname = self.firstname;
    userModel.nickname = self.nickname;
    userModel.firstkana = self.firstkana;
    userModel.lastkana = self.lastkana;
    userModel.email = self.email;
    userModel.mobile = self.mobile;
    userModel.mobile_jp = self.mobile_jp;
    userModel.weixin = self.weixin;
    userModel.avatar = self.avatar;
    userModel.qq = self.qq;
    userModel.jp_school_id = self.jp_school_id;
    userModel.province = self.province;
    userModel.city = self.city;
    userModel.jp_school_time = self.jp_school_time;
    userModel.category = self.category;
    userModel.toeic = self.toeic;
    userModel.toefl = self.toefl;
    userModel.jlpt = self.jlpt;
    userModel.arrive_jp = self.arrive_jp;
    userModel.study_category = self.study_category;
    userModel.discipline_id_1 = self.discipline_id_1;
    userModel.discipline_id_1 = self.discipline_id_1;
    userModel.discipline_id_2 = self.discipline_id_2;
    userModel.discipline_id_3 = self.discipline_id_3;
    
    NSMutableArray *universityList = [NSMutableArray arrayWithCapacity:self.university.count];
    for (UniversityModel *universityModel in self.university) {
        [universityList addObject:[universityModel copy]];
    }
    userModel.university = [universityList copy];
    
    return userModel;
}

// 当 JSON 转为 Model 完成后，该方法会被调用。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    if ([NSString isEmptyWithStr:_username]) {
        _username = @"";
    }
    if ([NSString isEmptyWithStr:_lastname]) {
        _lastname = @"";
    }
    if ([NSString isEmptyWithStr:_firstname]) {
        _firstname = @"";
    }
    if ([NSString isEmptyWithStr:_lastkana]) {
        _lastkana = @"";
    }
    if ([NSString isEmptyWithStr:_firstkana]) {
        _firstkana = @"";
    }
    if ([NSString isEmptyWithStr:_mobile]) {
        _mobile = @"";
    }
    if ([NSString isEmptyWithStr:_mobile_jp]) {
        _mobile_jp = @"";
    }
    if ([NSString isEmptyWithStr:_email]) {
        _email = @"";
    }
    if ([NSString isEmptyWithStr:_weixin]) {
        _weixin = @"";
    }
    if ([NSString isEmptyWithStr:_qq]) {
        _qq = @"";
    }
    if ([NSString isEmptyWithStr:_city]) {
        _city = @"";
    }
    if ([NSString isEmptyWithStr:_jp_school_id]) {
        _username = @"";
    }
    if ([NSString isEmptyWithStr:_jp_school_time]) {
        _jp_school_time = @"";
    }
    if ([NSString isEmptyWithStr:_toeic]) {
        _toeic = @"";
    }
    if ([NSString isEmptyWithStr:_toefl]) {
        _toefl = @"";
    }
    if ([NSString isEmptyWithStr:_jlpt]) {
        _jlpt = @"";
    }
    if ([NSString isEmptyWithStr:_arrive_jp]) {
        _arrive_jp = @"";
    }
    if ([NSString isEmptyWithStr:_discipline_id_1]) {
        _discipline_id_1 = @"";
    }
    if ([NSString isEmptyWithStr:_discipline_id_2]) {
        _discipline_id_2 = @"";
    }
    if ([NSString isEmptyWithStr:_discipline_id_3]) {
        _discipline_id_3 = @"";
    }

    return YES;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    // 将personId映射到key为id的数据字段
    return @{@"userID":@"id",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"university" : [UniversityModel class]
             };
}
@end
