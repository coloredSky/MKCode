//
//  AppointmentManager.m
//  MK
//
//  Created by 周洋 on 2019/4/15.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "AppointmentManager.h"
#import "AppointmentListModel.h"
#import "AppointmentDetailModel.h"
#import "AppoinementReplyModel.h"


@implementation AppointmentManager

+(void)callBackAllApplyListWithParameteApply_type:(NSInteger )applyType completionBlock:(void(^)(BOOL isSuccess,NSArray <AppointmentListModel *>*ongoingApplyList, NSArray <AppointmentListModel *> *completeApplyList,NSString *message))completionBlock
{
    NSInteger type = 0;
    if (applyType == 0) {
        type = 3;
    }else if (applyType == 1){
        type = 2;
    }else if (applyType == 2){
        type = 1;
    }
    NSDictionary *parameter = @{
                                @"apply_type":@(type),
                                };
    [MKNetworkManager sendGetRequestWithUrl:K_MK_GetApplyList_Url parameters:parameter hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                NSArray *un_finishApplyList = [NSArray yy_modelArrayWithClass:[AppointmentListModel class] json:MKResult.dataResponseObject[@"applySetList"][@"un_finish"]];
                NSArray *finishApplyList = [NSArray yy_modelArrayWithClass:[AppointmentListModel class] json:MKResult.dataResponseObject[@"applySetList"][@"finish"]];
                NSArray *rejectApplyList = [NSArray yy_modelArrayWithClass:[AppointmentListModel class] json:MKResult.dataResponseObject[@"applySetList"][@"reject"]];
                
                NSMutableArray *resultArr = [NSMutableArray array];
                for (AppointmentListModel *model in un_finishApplyList) {
                    [resultArr addObject:model];
                }
                for (AppointmentListModel *model in rejectApplyList) {
                    [resultArr addObject:model];
                }
                completionBlock(YES,resultArr.copy,finishApplyList.copy,MKResult.message);
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


+(void)callBackAllApplyAppointmentReplyListWithParameteApply_type:(NSInteger )applyType apply_id:(NSString *)apply_id completionBlock:(void(^)(BOOL isSuccess,NSArray <AppoinementReplyModel *> *applyList, NSString *message))completionBlock
{
    NSInteger type = 0;
    if (applyType == 0) {
        type = 3;
    }else if (applyType == 1){
        type = 2;
    }else if (applyType == 2){
        type = 1;
    }
    if ([NSString isEmptyWithStr:apply_id]) {
        return;
    }
    NSDictionary *parameter = @{
                                @"apply_type":@(type),
                                @"apply_id":apply_id,
                                };
    [MKNetworkManager sendGetRequestWithUrl:K_MK_GetApplyReplayInformation_Url parameters:parameter hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if ([MKResult.dataResponseObject isKindOfClass:[NSArray class]]) {
                NSArray *applyList = [NSArray yy_modelArrayWithClass:[AppoinementReplyModel class] json:MKResult.dataResponseObject];
                if (completionBlock) {
                    completionBlock(YES,applyList,MKResult.message);
                }
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

+(void)callBackAllApplyDetailWithParameteApply_type:(NSInteger )applyType apply_id:(NSString *)apply_id completionBlock:(void(^)(BOOL isSuccess,AppointmentDetailModel *detailmodel, NSString *message))completionBlock
{
    NSInteger type = 0;
    if (applyType == 0) {
        type = 3;
    }else if (applyType == 1){
        type = 2;
    }else if (applyType == 2){
        type = 1;
    }
    if ([NSString isEmptyWithStr:apply_id]) {
        return;
    }
    NSDictionary *parameter = @{
                                @"apply_type":@(type),
                                @"apply_id":apply_id,
                                };
    [MKNetworkManager sendGetRequestWithUrl:K_MK_GetApplyDetail_Url parameters:parameter hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            NSArray *applyInfo = MKResult.dataResponseObject[@"applyInfo"];
            if ([applyInfo isKindOfClass:[NSArray class]]) {
                if (applyInfo.count > 0) {
                  AppointmentDetailModel *detailModel = [AppointmentDetailModel yy_modelWithJSON:applyInfo[0]];
                    if (completionBlock) {
                        completionBlock(YES,detailModel,MKResult.message);
                    }
                }
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
@end
