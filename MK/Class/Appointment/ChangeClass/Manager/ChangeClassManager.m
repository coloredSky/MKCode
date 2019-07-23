//
//  ChangeClassManager.m
//  MK
//
//  Created by 周洋 on 2019/5/30.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "ChangeClassManager.h"
#import "ChangeClassCouseModel.h"

@implementation ChangeClassManager

+(void)callBackChangeClassCourseListRequestWithCompletionBlock:(void(^)(BOOL isSuccess,NSArray <ChangeClassCouseModel *>*courseList,NSArray <NSString *>*courseStringList,NSString *message))completionBlock
{
    [MKNetworkManager sendGetRequestWithUrl:K_MK_ChangeClass_CourseList_Url parameters:nil hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                NSArray *courseList = [NSArray yy_modelArrayWithClass:[ChangeClassCouseModel class] json:MKResult.dataResponseObject];
                NSMutableArray *courseStringList = [NSMutableArray array];
                for (ChangeClassCouseModel *model in courseList) {
                    [courseStringList addObject:model.class_name];
                }
                completionBlock(YES,courseList, courseStringList.copy, MKResult.message);
            }
        }else{
            if (completionBlock) {
                completionBlock(NO,nil,nil,MKResult.message);
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
            completionBlock(NO,nil,nil,error.userInfo[NSLocalizedDescriptionKey]);
        }
    }];
}

+(void)callBackChangeClassRequestWithParameterClass_id:(NSString *)class_id new_class_id:(NSString *)new_class_id reason:(NSString *)reason  CompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;
{
    if ([NSString isEmptyWithStr:class_id]) {
        return;
    }
    if ([NSString isEmptyWithStr:new_class_id]) {
        return;
    }
    if ([NSString isEmptyWithStr:reason]) {
        return;
    }
    NSDictionary *parameter = @{
                                @"class_id":class_id,
                                @"new_class_id":new_class_id,
                                @"reason":reason,
                                };
    [MKNetworkManager sendPostRequestWithUrl:K_MK_AddChangeClass_Url parameters:parameter hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                completionBlock(YES, MKResult.message);
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

+(void)callBackDeleteChangeClassRequestWithParameteApply_id:(NSString *)apply_id  completionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock
{
    if ([NSString isEmptyWithStr:apply_id]) {
        return;
    }
    NSDictionary *parameter = @{
                                @"apply_id":apply_id,
                                };
    [MKNetworkManager sendPostRequestWithUrl:K_MK_DeleteChangeClass_Url parameters:parameter hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                completionBlock(YES, MKResult.message);
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
@end
