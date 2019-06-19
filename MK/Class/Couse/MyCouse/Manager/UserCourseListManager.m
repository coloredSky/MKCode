//
//  UserCourseListManager.m
//  MK
//
//  Created by 周洋 on 2019/4/10.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "UserCourseListManager.h"
#import "MKCourseListModel.h"

@implementation UserCourseListManager

+(void)callBackUserCourseListWithCompletionBlock:(void(^)(BOOL isSuccess,NSArray <NSArray *>*userCourseList,NSArray < MKCourseListModel*>*onLineCourseList,NSArray <MKCourseListModel *>*offLineCourseList,NSString *message))completionBlock
{
    [MKNetworkManager sendGetRequestWithUrl:K_MK_UserCourseList_Url parameters:nil hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                NSArray *userOnlineCourseList = [NSArray yy_modelArrayWithClass:[MKCourseListModel class] json:MKResult.dataResponseObject[@"onlineCourseList"]];
                 NSArray *offlineUn_startList = [NSArray yy_modelArrayWithClass:[MKCourseListModel class] json:MKResult.dataResponseObject[@"offlineCourseList"][@"un_start"]];
                NSArray *offlineStudyingList = [NSArray yy_modelArrayWithClass:[MKCourseListModel class] json:MKResult.dataResponseObject[@"offlineCourseList"][@"studying"]];
                 NSArray *offlineEndedList = [NSArray yy_modelArrayWithClass:[MKCourseListModel class] json:MKResult.dataResponseObject[@"offlineCourseList"][@"ended"]];
                NSArray *courselList = @[userOnlineCourseList,offlineUn_startList,offlineStudyingList,offlineEndedList];
                
                NSMutableArray *offlineList = [NSMutableArray array];
                for (MKCourseListModel *model in offlineUn_startList) {
                    [offlineList addObject:model];
                }
                for (MKCourseListModel *model in offlineStudyingList) {
                    [offlineList addObject:model];
                }
                for (MKCourseListModel *model in offlineEndedList) {
                    [offlineList addObject:model];
                }
                
                completionBlock(YES,courselList,userOnlineCourseList,offlineList, MKResult.message);
            }
        }else{
            if (completionBlock) {
                completionBlock(NO, nil,nil,nil,MKResult.message);
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
            completionBlock(NO, nil,nil,nil,[NSString stringWithFormat:@"error code is %ld",statusCode]);
        }
    }];
}

@end
