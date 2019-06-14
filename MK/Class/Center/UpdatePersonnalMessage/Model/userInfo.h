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
@property(nonatomic,strong)NSString * id ;
@property(nonatomic,strong)NSString * username ;
@property(nonatomic,strong)NSString * lastname ;
@property(nonatomic,strong)NSString * firstname ;
@property(nonatomic,strong)NSString * nickname ;
@property(nonatomic,strong)NSString * firstkana ;
@property(nonatomic,strong)NSString * lastkana ;
@property(nonatomic,strong)NSString * email ;
@property(nonatomic,strong)NSString * mobile ;
@property(nonatomic,strong)NSString * mobile_jp ;
@property(nonatomic,strong)NSString * weixin ;
@property(nonatomic,strong)NSString * avatar ;
@property(nonatomic,strong)NSString * qq ;
@property(nonatomic,strong)NSString * jp_school_id ;
@property(nonatomic,strong)NSString * province ;
@property(nonatomic,strong)NSString * city ;
@property(nonatomic,strong)NSString * jp_school_time ;
@property(nonatomic,strong)NSString * category ;
@property(nonatomic,strong)NSString * toeic ;
@property(nonatomic,strong)NSString * toefl ;
@property(nonatomic,strong)NSString * jlpt ;
@property(nonatomic,strong)NSString * arrive_jp ;
@property(nonatomic,strong)NSString * study_category ;
@property(nonatomic,strong)NSString * discipline_id_1 ;
@property(nonatomic,strong)NSString * discipline_id_2 ;
@property(nonatomic,strong)NSString * discipline_id_3 ;
@property(nonatomic,strong)NSArray <university *>* university ;



@end

NS_ASSUME_NONNULL_END
