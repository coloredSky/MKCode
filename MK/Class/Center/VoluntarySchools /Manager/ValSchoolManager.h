//
//  ValSchoolManager.h
//  MK
//
//  Created by ginluck on 2019/6/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MKUniversityModel;
@class MKUniversityFacultyListModel;
@class MKUniversityDisciplineListModel;

NS_ASSUME_NONNULL_BEGIN

@interface ValSchoolManager : NSObject


/**
 填报志愿
 
 @param study_category1 第一志愿类型
 @param university_id_1 学校ID
 @param faculty_id_1 学部ID
 @param discipline_id_1 专业ID
 @param study_category2 第二志愿类型
 @param university_id_2 学校ID
 @param faculty_id_2 学部ID
 @param discipline_id_2 专业ID
 @param study_category3 第三志愿类型
 @param university_id_3 学校ID
 @param faculty_id_3 学部ID
 @param discipline_id_3 专业ID
 @param mobile 手机
 @param completionBlock 回调
 */
+(void)callBackUpdateValSchoolStudy_category1:(NSString *)study_category1 University_id_1:(NSString *)university_id_1 faculty_id_1:(NSString *)faculty_id_1 discipline_id_1:(NSString *)discipline_id_1 study_category2:(NSString *)study_category2 university_id_2:(NSString *)university_id_2 faculty_id_2:(NSString *)faculty_id_2 discipline_id_2:(NSString *)discipline_id_2 study_category3:(NSString *)study_category3 university_id_3:(NSString *)university_id_3 faculty_id_3:(NSString *)faculty_id_3 discipline_id_3:(NSString *)discipline_id_3 mobile:(NSString *)mobile completionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;

+(void)callBackValSchoolListWithStudy_category:(NSString *)study_category completionBlock:(void(^)(BOOL isSuccess, NSArray <MKUniversityModel *> *university,NSString *message))completionBlock;

+(void)callBackValFacultyListtWithStudy_category:(NSString *)study_category university_id:(NSString *)university_id completionBlock:(void(^)(BOOL isSuccess,NSArray <MKUniversityFacultyListModel *> *university,NSString *message))completionBlock;

+(void)callBackValDisciplineListWithStudy_category:(NSString *)study_category faculty_id:(NSString *)faculty_id completionBlock:(void(^)(BOOL isSuccess,NSArray <MKUniversityDisciplineListModel *> *university,NSString *message))completionBlock;



@end

NS_ASSUME_NONNULL_END
