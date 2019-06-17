//
//  CourseDetailManager.m
//  MK
//
//  Created by 周洋 on 2019/4/10.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "CourseDetailManager.h"
#import "MKCourseDetailModel.h"

@implementation CourseDetailManager

+(void)callBackCourseDetailRequestWithHudShow:(BOOL )hudShow courseID:(NSString *)course_id andCompletionBlock:(void(^)(BOOL isSuccess, NSString *message, MKCourseDetailModel *courseDetailModel))completionBlock
{
    if ([NSString isEmptyWithStr:course_id]) {
        return;
    }
    NSDictionary *parameters = @{@"course_id" : course_id,
                                 };
    [MKNetworkManager sendGetRequestWithUrl:K_MK_Course_CourseDetail_Url parameters:parameters hudIsShow:YES success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                MKCourseDetailModel *detailModel = [MKCourseDetailModel yy_modelWithJSON:MKResult.dataResponseObject];
                completionBlock(YES,MKResult.message,detailModel);
            }
        }else{
            if (completionBlock) {
                completionBlock(NO,MKResult.message,nil);
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
            completionBlock(NO,@"error",nil);
        }
    }];
}

+(void)callBackCourseCollectionRequestWithCourseID:(NSString *)course_id type:(NSInteger )type andCompletionBlock:(void(^)(BOOL isSuccess, NSString *message))completionBlock
{
    if ([NSString isEmptyWithStr:course_id]) {
        return;
    }
    NSDictionary *parameters = @{
                                 @"course_id" : course_id,
                                 @"type" : @(type),
                                 };
    [MKNetworkManager sendPostRequestWithUrl:K_MK_Course_Collection_Url parameters:parameters hudIsShow:YES success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                completionBlock(YES,MKResult.message);
            }
        }else{
            if (completionBlock) {
                completionBlock(NO,MKResult.message);
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
            completionBlock(NO,@"error");
        }
    }];
}

+(void)callBackCourseCancleCollectionRequestWithCourseID:(NSString *)course_id type:(NSInteger )type andCompletionBlock:(void(^)(BOOL isSuccess, NSString *message))completionBlock
{
    if ([NSString isEmptyWithStr:course_id]) {
        return;
    }
    NSDictionary *parameters = @{
                                 @"course_id" : course_id,
                                 @"type" : @(type),
                                 };
    [MKNetworkManager sendPostRequestWithUrl:K_MK_Course_CancleCollection_Url parameters:parameters hudIsShow:YES success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                completionBlock(YES,MKResult.message);
            }
        }else{
            if (completionBlock) {
                completionBlock(NO,MKResult.message);
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
            completionBlock(NO,@"error");
        }
    }];
}
@end
