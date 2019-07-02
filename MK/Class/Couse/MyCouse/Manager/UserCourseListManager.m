//
//  UserCourseListManager.m
//  MK
//
//  Created by 周洋 on 2019/4/10.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "UserCourseListManager.h"
#import "MKCourseListModel.h"
#import "UserCourseModel.h"

@implementation UserCourseListManager

//+(void)callBackUserCourseListWithCompletionBlock:(void(^)(BOOL isSuccess,NSArray <NSArray *>*userCourseList,NSArray < MKCourseListModel*>*onLineCourseList,NSArray <MKCourseListModel *>*offLineCourseList,NSString *message))completionBlock
//{
//    [MKNetworkManager sendGetRequestWithUrl:K_MK_UserCourseList_Url parameters:nil hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
//        if (MKResult.responseCode == 0) {
//            if (completionBlock) {
//                NSArray *userOnlineCourseList = [NSArray yy_modelArrayWithClass:[MKCourseListModel class] json:MKResult.dataResponseObject[@"onlineCourseList"]];
//                NSArray *offlineUn_startList = [NSArray array];
//                NSArray *offlineStudyingList= [NSArray array];;
//                NSArray *offlineEndedList= [NSArray array];;
//                if ([MKResult.dataResponseObject[@"offlineCourseList"] isKindOfClass:[NSDictionary class]]) {
//                    offlineUn_startList = [NSArray yy_modelArrayWithClass:[MKCourseListModel class] json:MKResult.dataResponseObject[@"offlineCourseList"][@"un_start"]];
//                    offlineStudyingList = [NSArray yy_modelArrayWithClass:[MKCourseListModel class] json:MKResult.dataResponseObject[@"offlineCourseList"][@"studying"]];
//                    offlineEndedList = [NSArray yy_modelArrayWithClass:[MKCourseListModel class] json:MKResult.dataResponseObject[@"offlineCourseList"][@"ended"]];
//                }
//                NSArray *courselList = @[userOnlineCourseList,offlineUn_startList,offlineStudyingList,offlineEndedList];
//
//                NSMutableArray *offlineList = [NSMutableArray array];
//                for (MKCourseListModel *model in offlineUn_startList) {
//                    [offlineList addObject:model];
//                }
//                for (MKCourseListModel *model in offlineStudyingList) {
//                    [offlineList addObject:model];
//                }
//                for (MKCourseListModel *model in offlineEndedList) {
//                    [offlineList addObject:model];
//                }
//
//                completionBlock(YES,courselList,userOnlineCourseList,offlineList, MKResult.message);
//            }
//        }else{
//            if (completionBlock) {
//                completionBlock(NO, nil,nil,nil,MKResult.message);
//            }
//        }
//    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
//        if (completionBlock) {
//            completionBlock(NO, nil,nil,nil,[NSString stringWithFormat:@"error code is %ld",statusCode]);
//        }
//    }];
//}

+(void)callBackUserCourseListWithCompletionBlock:(void(^)(BOOL isSuccess,MKCourseListModel *lastCourseListModel,NSArray <UserCourseModel *>*userCourseList,NSArray <MKCourseListModel *>*offLineCourseList,NSString *message))completionBlock
{
    [MKNetworkManager sendGetRequestWithUrl:K_MK_UserCourseList_Url parameters:nil hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            NSMutableArray *userCourseArr = [NSMutableArray array];
            if (completionBlock) {
                MKCourseListModel *lastCourseListModel = [MKCourseListModel yy_modelWithJSON:MKResult.dataResponseObject[@"last_video_log"]];
                NSArray *userOnlineCourseList = [NSArray yy_modelArrayWithClass:[MKCourseListModel class] json:MKResult.dataResponseObject[@"onlineCourseList"]];
                if (userOnlineCourseList.count > 0) {
                    UserCourseModel *userOnlineModel = [UserCourseModel new];
                    userOnlineModel.isOnline = YES;
                    userOnlineModel.title = @"线上课程";
                    userOnlineModel.courseList = userOnlineCourseList;
                    [userCourseArr addObject:userOnlineModel];
                }
                
                NSArray *offlineStudyingList= [NSArray array];
                NSArray *offlineUn_startList = [NSArray array];
                NSArray *offlineEndedList= [NSArray array];

                if ([MKResult.dataResponseObject[@"offlineCourseList"] isKindOfClass:[NSDictionary class]]) {
                    
                    offlineStudyingList = [NSArray yy_modelArrayWithClass:[MKCourseListModel class] json:MKResult.dataResponseObject[@"offlineCourseList"][@"studying"]];
                    if (offlineStudyingList.count > 0) {
                        UserCourseModel *userOfflineModel = [UserCourseModel new];
                        userOfflineModel.isOnline = NO;
                        userOfflineModel.isOfflineFirst = YES;
                        userOfflineModel.title = @"线下课程";
                        userOfflineModel.message = @"正在进行的课程";
                        userOfflineModel.courseList = offlineStudyingList;
                        [userCourseArr addObject:userOfflineModel];
                    }
                    
                     offlineUn_startList = [NSArray yy_modelArrayWithClass:[MKCourseListModel class] json:MKResult.dataResponseObject[@"offlineCourseList"][@"un_start"]];
                    if (offlineUn_startList.count > 0) {
                        UserCourseModel *userOfflineModel = [UserCourseModel new];
                        userOfflineModel.isOnline = NO;
                        if (offlineStudyingList.count == 0) {
                            userOfflineModel.isOfflineFirst = YES;
                        }
                        userOfflineModel.title = @"线下课程";
                        userOfflineModel.message = @"还未开始的课程";
                        userOfflineModel.courseList = offlineUn_startList;
                        [userCourseArr addObject:userOfflineModel];
                    }
                    
                    offlineEndedList = [NSArray yy_modelArrayWithClass:[MKCourseListModel class] json:MKResult.dataResponseObject[@"offlineCourseList"][@"ended"]];
                    if (offlineEndedList.count > 0) {
                        UserCourseModel *userOfflineModel = [UserCourseModel new];
                        userOfflineModel.isOnline = NO;
                        if (offlineStudyingList.count == 0 && offlineUn_startList.count == 0) {
                            userOfflineModel.isOfflineFirst = YES;
                        }
                        userOfflineModel.title = @"线下课程";
                        userOfflineModel.message = @"已经结束的课程";
                        userOfflineModel.courseList = offlineEndedList;
                        [userCourseArr addObject:userOfflineModel];
                    }
                }
                
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
                
                completionBlock(YES,lastCourseListModel,userCourseArr.copy,offlineList, MKResult.message);
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
