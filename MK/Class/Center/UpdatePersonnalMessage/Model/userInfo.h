//
//  userInfo.h
//  MK
//
//  Created by ginluck on 2019/6/13.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "university.h"
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
@property(nonatomic,strong)NSString * jlpt ;//根据提供的日本语能力级别列表选择N1-N5
@property(nonatomic,strong)NSString * arrive_jp ;//赴日日期
@property(nonatomic,strong)NSString * study_category ;
@property(nonatomic,strong)NSString * discipline_id_1 ;//第一志愿学校
@property(nonatomic,strong)NSString * discipline_id_2 ;//第二志愿学校
@property(nonatomic,strong)NSString * discipline_id_3 ;//第三志愿学校

@property(nonatomic,strong)NSArray <university *>* university ;



@end

NS_ASSUME_NONNULL_END
