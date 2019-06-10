//
//  AppointmentManager.m
//  MK
//
//  Created by 周洋 on 2019/4/15.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "AppointmentManager.h"
#import "AppointmentListModel.h"

@implementation AppointmentManager

+(void)callBackAllApplyListWithParameteApply_type:(NSInteger )applyType completionBlock:(void(^)(BOOL isSuccess,NSArray <AppointmentListModel *>*ongoingApplyList, NSArray <AppointmentListModel *> *completeApplyList,NSString *message))completionBlock
{
    NSDictionary *parameter = @{
                                @"apply_type":@(applyType),
                                };
    [MKNetworkManager sendGetRequestWithUrl:K_MK_GetApplyList_Url parameters:parameter hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                NSArray *applyList = [NSArray yy_modelArrayWithClass:[AppointmentListModel class] json:MKResult.dataResponseObject[@"applySetList"][@"un_finish"]];
                NSMutableArray *ongoingArr = [NSMutableArray array];
                NSMutableArray *completeArr = [NSMutableArray array];
                for (AppointmentListModel *model in applyList) {
                    if ([model.status integerValue]==1) {
                        [completeArr addObject:model];
                    }else{
                        [ongoingArr addObject:model];
                    }
                }
                completionBlock(YES,ongoingArr.copy,completeArr.copy,MKResult.message);
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

@end
