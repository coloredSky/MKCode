//
//  userInfo.h
//  MK
//
//  Created by ginluck on 2019/6/13.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UniversityModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface userInfo : NSObject

@property(nonatomic,strong)NSString * userID ;
@property(nonatomic,strong)NSString * username ;
@property(nonatomic,strong)NSString * lastname ;
@property(nonatomic,strong)NSString * firstname ;
@property(nonatomic,strong)NSString * nickname ;
@property(nonatomic,strong)NSString * firstkana ;//姓 拼音
@property(nonatomic,strong)NSString * lastkana ;//名 拼音
@property(nonatomic,strong)NSString * email ;
@property(nonatomic,strong)NSString * mobile ;//手机
@property(nonatomic,strong)NSString * mobile_jp ;//日本手机
@property(nonatomic,strong)NSString * weixin ;
@property(nonatomic,strong)NSString * avatar ;
@property(nonatomic,strong)NSString * qq ;
@property(nonatomic,strong)NSString * jp_school_id ;//志愿学校ID
@property(nonatomic,strong)NSString * province ;
@property(nonatomic,strong)NSString * city ;//城市
@property(nonatomic,strong)NSString * jp_school_time ;//上午 下午 晚上 学校上课时间
@property(nonatomic,strong)NSString * category ;
@property(nonatomic,strong)NSString * toeic ;//TOEIC分数
@property(nonatomic,strong)NSString * toefl ;//TOEFL分数
@property(nonatomic,strong)NSString * jlptID;//日语能力ID
@property(nonatomic,strong)NSString * jlptString ;//根据提供的日本语能力级别列表选择N1-N5
@property(nonatomic,strong)NSString * arrive_jp ;//赴日日期


@property(nonatomic,strong)NSMutableArray <UniversityModel *>* university;
//志愿学校-学部
@property(nonatomic,strong)NSMutableArray <UniversityModel *>* BUniversityList;
//志愿学校-大学院
@property(nonatomic,strong)NSMutableArray <UniversityModel *>* MUniversityList ;


@end

NS_ASSUME_NONNULL_END
