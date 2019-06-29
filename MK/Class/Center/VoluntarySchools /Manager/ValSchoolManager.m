//
//  ValSchoolManager.m
//  MK
//
//  Created by ginluck on 2019/6/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "ValSchoolManager.h"

@implementation ValSchoolManager

+(void)callBackUpdateValSchoolUniversity_id_1:(NSString *)university_id_1 faculty_id_1:(NSString *)faculty_id_1 discipline_id_1:(NSString *)discipline_id_1 university_id_2:(NSString *)university_id_2 faculty_id_2:(NSString *)faculty_id_2 discipline_id_2:(NSString *)discipline_id_2 university_id_3:(NSString *)university_id_3 faculty_id_3:(NSString *)faculty_id_3 discipline_id_3:(NSString *)discipline_id_3 mobile:(NSString *)mobile completionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock
{
    NSDictionary * param =@{
                            @"university_id_1" : university_id_1,
                            @"faculty_id_1" : faculty_id_1,
                            @"discipline_id_1" : discipline_id_1,
                            @"university_id_2" : university_id_2,
                            @"faculty_id_2" : faculty_id_2,
                            @"discipline_id_2" : discipline_id_2,
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
@end
