//
//  userInfo.m
//  MK
//
//  Created by ginluck on 2019/6/13.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "userInfo.h"
#import "UniversityModel.h"

@interface userInfo()<NSCopying>

@end

@implementation userInfo

-(instancetype)init
{
    if (self = [super init]) {
        
        _BUniversityList = [NSMutableArray arrayWithCapacity:3];
        for (int i=0; i<3; i++) {
            UniversityModel *model = [UniversityModel new];
            [_BUniversityList addObject:model];
        }
        _MUniversityList = [NSMutableArray arrayWithCapacity:3];
        for (int i=0; i<3; i++) {
            UniversityModel *model = [UniversityModel new];
            model.study_category = @"M";
            [_MUniversityList addObject:model];
        }
    }
    return self;
}

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
    userModel.jlptString = self.jlptString;
    userModel.jlptID = self.jlptID;
    userModel.arrive_jp = self.arrive_jp;
    
    NSMutableArray *universityList = [NSMutableArray arrayWithCapacity:self.university.count];
    for (UniversityModel *universityModel in self.university) {
        [universityList addObject:[universityModel copy]];
    }
    userModel.university = universityList;
    
    NSMutableArray *BUniversityList = [NSMutableArray arrayWithCapacity:self.BUniversityList.count];
    for (UniversityModel *universityModel in self.BUniversityList) {
        [BUniversityList addObject:[universityModel copy]];
    }
    userModel.BUniversityList = BUniversityList;
    
    NSMutableArray *MUniversityList = [NSMutableArray arrayWithCapacity:self.MUniversityList.count];
    for (UniversityModel *universityModel in self.MUniversityList) {
        [MUniversityList addObject:[universityModel copy]];
    }
    userModel.MUniversityList = MUniversityList;
    
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
    if ([NSString isEmptyWithStr:_jlptID]) {
        _jlptID = @"";
    }
    if ([NSString isEmptyWithStr:_jlptString]) {
        _jlptString = @"";
    }
    if ([NSString isEmptyWithStr:_arrive_jp]) {
        _arrive_jp = @"";
    }
    
    _university = [NSMutableArray arrayWithCapacity:3];
    for (int i=0; i<3; i++) {
        UniversityModel *model = [UniversityModel new];
        [_university addObject:model];
    }
    
    if (dic[@"university"]) {
        NSDictionary *universityListDic = dic[@"university"];
        NSArray *keyS = [universityListDic allKeys];
        if (keyS.count > 0) {
            //数据解析。返回的数据结构，很垃圾。将就着用。
            for (NSString *key in keyS) {
                if ([universityListDic[key] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *universityDic= universityListDic[key];
                    UniversityModel *model = [UniversityModel yy_modelWithJSON:universityDic];
                    if ([key isEqualToString:@"volunteer_school_1"]) {
                        _university[0] =  model;
                        if ([model.study_category isEqualToString:@"M"]) {
                            self.MUniversityList[0] = model;
                        }else{
                            self.BUniversityList[0] = model;
                        }
                    }else if ([key isEqualToString:@"volunteer_school_2"]){
                        _university[1] =  model;
                        if ([model.study_category isEqualToString:@"M"]) {
                            self.MUniversityList[1] = model;
                        }else{
                            self.BUniversityList[1] = model;
                        }
                    }else if ([key isEqualToString:@"volunteer_school_3"]){
                        _university[2] =  model;
                        if ([model.study_category isEqualToString:@"M"]) {
                            self.MUniversityList[2] = model;
                        }else{
                            self.BUniversityList[2] = model;
                        }
                    }
                }
            }
        }
    }
    
    return YES;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    // 将personId映射到key为id的数据字段
    return @{@"userID":@"id",
             @"jlptID" : @"jlpt",
             };
}

//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"university" : [UniversityModel class]
//             };
//}
@end
