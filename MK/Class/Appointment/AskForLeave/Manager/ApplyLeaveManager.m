//
//  ApplyLeaveManager.m
//  MK
//
//  Created by 周洋 on 2019/5/29.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "ApplyLeaveManager.h"
#import "ApplyLeaveCourseModel.h"
#import "ApplyListModel.h"

@implementation ApplyLeaveManager

+(void)callBackApplyLeaveCourseListWithParameter:(NSString *)is_studying_lesson completionBlock:(void(^)(BOOL isSuccess,NSArray <ApplyLeaveCourseModel *>*courseList,NSString *message))completionBlock
{
    if ([NSString isEmptyWithStr:is_studying_lesson]) {
        return;
    }
    NSDictionary *parameter = @{
                                @"is_studying_lesson":is_studying_lesson,
                                };
    [MKNetworkManager sendGetRequestWithUrl:K_MK_AskForLeave_CourseList_Url parameters:parameter hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                NSArray *courseList = [NSArray yy_modelArrayWithClass:[ApplyLeaveCourseModel class] json:MKResult.dataResponseObject];
                completionBlock(YES,courseList,MKResult.message);
            }
        }else{
            if (completionBlock) {
                completionBlock(NO,nil,MKResult.message);
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
            completionBlock(NO,nil,error.userInfo[NSLocalizedDescriptionKey]);
        }
    }];
}

+(void)callBackAddApplyLeaveWithParameterClass_id:(NSString *)class_id lesson_id:(NSString *)lesson_id detail:(NSString *)detail completionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock
{
    if ([NSString isEmptyWithStr:class_id]) {
        return;
    }
    if ([NSString isEmptyWithStr:lesson_id]) {
        return;
    }
    if ([NSString isEmptyWithStr:detail]) {
        return;
    }
    NSDictionary *parameter = @{
                                @"class_id":class_id,
                                @"lesson_id":lesson_id,
                                @"detail":detail,
                                };
    [MKNetworkManager sendPostRequestWithUrl:K_MK_AddAskForLeave_Url parameters:parameter hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
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
            completionBlock(NO,error.userInfo[NSLocalizedDescriptionKey]);
        }
    }];
}

+(void)callBackEditApplyLeaveWithParameterApply_id:(NSString *)apply_id class_id:(NSString *)class_id lesson_id:(NSString *)lesson_id detail:(NSString *)detail completionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock
{
    if ([NSString isEmptyWithStr:apply_id]) {
        return;
    }
    if ([NSString isEmptyWithStr:class_id]) {
        return;
    }
    if ([NSString isEmptyWithStr:lesson_id]) {
        return;
    }
    if ([NSString isEmptyWithStr:detail]) {
        return;
    }
    NSDictionary *parameter = @{
                                @"apply_id":apply_id,
                                @"class_id":class_id,
                                @"lesson_id":lesson_id,
                                @"detail":detail,
                                };
    [MKNetworkManager sendPostRequestWithUrl:K_MK_EditAskForLeave_Url parameters:parameter hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
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
            completionBlock(NO,error.userInfo[NSLocalizedDescriptionKey]);
        }
    }];
}

+(void)callBackAllApplyListWithParameteApply_type:(NSInteger )applyType completionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock
{
    NSDictionary *parameter = @{
                                @"apply_type":@(applyType),
                                };
    [MKNetworkManager sendGetRequestWithUrl:K_MK_GetApplyList_Url parameters:parameter hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                NSArray *courseList = [NSArray yy_modelArrayWithClass:[ApplyLeaveCourseModel class] json:MKResult.dataResponseObject];
//                completionBlock(YES,courseList,MKResult.message);
            }
        }else{
            if (completionBlock) {
//                completionBlock(NO,nil,MKResult.message);
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
//            completionBlock(NO,nil,error.userInfo[NSLocalizedDescriptionKey]);
        }
    }];
}
@end
