//
//  ValSchoolManager.m
//  MK
//
//  Created by ginluck on 2019/6/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "ValSchoolManager.h"
#import "MKUniversityModel.h"

@implementation ValSchoolManager

+(void)callBackUpdateValSchoolStudy_category1:(NSString *)study_category1 University_id_1:(NSString *)university_id_1 faculty_id_1:(NSString *)faculty_id_1 discipline_id_1:(NSString *)discipline_id_1 study_category2:(NSString *)study_category2 university_id_2:(NSString *)university_id_2 faculty_id_2:(NSString *)faculty_id_2 discipline_id_2:(NSString *)discipline_id_2 study_category3:(NSString *)study_category3 university_id_3:(NSString *)university_id_3 faculty_id_3:(NSString *)faculty_id_3 discipline_id_3:(NSString *)discipline_id_3 mobile:(NSString *)mobile completionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock
{
    NSDictionary * param =@{
                            @"study_category" : study_category1,
                            @"university_id_1" : university_id_1,
                            @"faculty_id_1" : faculty_id_1,
                            @"discipline_id_1" : discipline_id_1,
                            @"study_category2" : study_category2,
                            @"university_id_2" : university_id_2,
                            @"faculty_id_2" : faculty_id_2,
                            @"discipline_id_2" : discipline_id_2,
                            @"study_category3" : study_category3,
                            @"university_id_3" : university_id_3,
                            @"faculty_id_3" : faculty_id_3,
                            @"discipline_id_3" : discipline_id_3,
                            @"mobile" : mobile,
                            };
    [MKNetworkManager sendPostRequestWithUrl:K_MK_UpdateUserInfo_url parameters:param hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode ==0) {
            if (completionBlock){
                completionBlock(YES,MKResult.message);
            }
        }else{
            completionBlock(NO,MKResult.message);
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock){
            completionBlock(NO,error.userInfo[NSLocalizedDescriptionKey]);
        }
    }];
}

+(void)callBackValSchoolListWithStudy_category:(NSString *)study_category completionBlock:(void(^)(BOOL isSuccess, NSArray <MKUniversityModel *> *university,NSString *message))completionBlock
{
    NSDictionary * param =@{
                            @"study_category" : study_category,
                            };
    [MKNetworkManager sendGetRequestWithUrl:K_MK_GetUniversityList_url parameters:param hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode ==0) {
            if (completionBlock){
                NSDictionary *universityDic = MKResult.dataResponseObject;
                NSArray *universityIDS = universityDic.allKeys;
                NSMutableArray *universityList = [NSMutableArray arrayWithCapacity:universityIDS.count];
                for (NSString *universityID in universityIDS) {
                    MKUniversityModel *model = [MKUniversityModel new];
                    model.universityID = universityID;
                    model.name = universityDic[universityID];
                    [universityList addObject:model];
                }
                completionBlock(YES,universityList,MKResult.message);
            }
        }else{
            completionBlock(NO,nil,MKResult.message);
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock){
            completionBlock(NO,nil,error.userInfo[NSLocalizedDescriptionKey]);
        }
    }];
}

+(void)callBackValFacultyListtWithStudy_category:(NSString *)study_category university_id:(NSString *)university_id completionBlock:(void(^)(BOOL isSuccess,NSArray <MKUniversityFacultyListModel *> *university,NSString *message))completionBlock
{
    NSDictionary * param =@{
                            @"study_category" : study_category,
                            @"university_id" : university_id,
                            };
    [MKNetworkManager sendGetRequestWithUrl:K_MK_GetFacultyList_url parameters:param hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode ==0) {
            if (completionBlock){
                NSDictionary *facultyDic = MKResult.dataResponseObject;
                NSArray *facultyIDS = facultyDic.allKeys;
                NSMutableArray *FacultyList = [NSMutableArray arrayWithCapacity:facultyIDS.count];
                for (NSString *FacultyID in facultyIDS) {
                    MKUniversityFacultyListModel *model = [MKUniversityFacultyListModel new];
                    model.faculty_id = FacultyID;
                    model.name = facultyDic[FacultyID];
                    [FacultyList addObject:model];
                }
                completionBlock(YES,FacultyList.copy, MKResult.message);
            }
        }else{
            completionBlock(NO,nil,MKResult.message);
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock){
            completionBlock(NO,nil,error.userInfo[NSLocalizedDescriptionKey]);
        }
    }];
}

+(void)callBackValDisciplineListWithStudy_category:(NSString *)study_category faculty_id:(NSString *)faculty_id completionBlock:(void(^)(BOOL isSuccess,NSArray <MKUniversityDisciplineListModel *> *university,NSString *message))completionBlock
{
    NSDictionary * param =@{
                            @"study_category" : study_category,
                            @"faculty_id" : faculty_id,
                            };
    [MKNetworkManager sendGetRequestWithUrl:K_MK_GetDisciplineList_url parameters:param hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode ==0) {
            if (completionBlock){
                NSDictionary *DisciplineDic = MKResult.dataResponseObject;
                NSArray *DisciplineIDS = DisciplineDic.allKeys;
                NSMutableArray *DisciplineList = [NSMutableArray arrayWithCapacity:DisciplineIDS.count];
                for (NSString *DisciplineID in DisciplineIDS) {
                    MKUniversityDisciplineListModel *model = [MKUniversityDisciplineListModel new];
                    model.discipline_id = DisciplineID;
                    model.name = DisciplineDic[DisciplineID];
                    [DisciplineList addObject:model];
                    completionBlock(YES,DisciplineList,MKResult.message);
                }
            }
        }else{
            completionBlock(NO,nil,MKResult.message);
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock){
            completionBlock(NO,nil,error.userInfo[NSLocalizedDescriptionKey]);
        }
    }];
}
@end
