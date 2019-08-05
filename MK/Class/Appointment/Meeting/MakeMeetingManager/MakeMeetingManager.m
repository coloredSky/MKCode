//
//  MakeMeetingManager.m
//  MK
//
//  Created by 周洋 on 2019/5/30.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "MakeMeetingManager.h"

@implementation MakeMeetingManager

+(void)callBackMeetingTimeListWithCompletionBlock:(void(^)(BOOL isSuccess,NSArray <NSString *>*time1List,NSArray <NSString *>*time2List,NSArray <NSString *>*time3List,NSString *message))completionBlock
{
    [MKNetworkManager sendGetRequestWithUrl:K_MK_MeetingTime_Url parameters:nil hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                NSDictionary *reservationTimeList = MKResult.dataResponseObject[@"reservationTimeList"];
                NSArray *time1List = reservationTimeList[@"time1"];
                NSArray *time2List = reservationTimeList[@"time2"];
                NSArray *time3List = reservationTimeList[@"time3"];
                completionBlock(YES,time1List,time2List,time3List,MKResult.message);
            }
        }else{
            if (completionBlock) {
                completionBlock(NO,nil,nil,nil,MKResult.message);
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
            completionBlock(NO,nil,nil,nil,error.userInfo[NSLocalizedDescriptionKey]);
        }
    }];
}

+(void)callBackMeetingPurposeListWithCompletionBlock:(void(^)(BOOL isSuccess,NSArray <NSDictionary *>*purposeList,NSArray <NSString *>*purposeStringList,NSString *message))completionBlock
{
    [MKNetworkManager sendGetRequestWithUrl:K_MK_MeetingReservation_Url parameters:nil hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                NSArray *purposeList = MKResult.dataResponseObject;
                NSMutableArray *purposeStringArr = [NSMutableArray array];
                if ([purposeList isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *dic in purposeList) {
                        [purposeStringArr addObject:dic[@"name"]];
                    }
                }
                completionBlock(YES,purposeList,purposeStringArr.copy, MKResult.message);
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

+(void)callBackMeetingSettingWithCompletionBlock:(void(^)(BOOL isSuccess,NSArray <NSDictionary *>*purposeList,NSArray <NSString *>*purposeStringList, NSArray <NSString *>*timeList,NSString *message))completionBlock
{
    [MKNetworkManager sendGetRequestWithUrl:K_MK_MeetingConfig_Url parameters:nil hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                NSArray *timeList = MKResult.dataResponseObject[@"reservationTimeList"];
                NSArray *purposeList = MKResult.dataResponseObject[@"reservationTypeList"];
                NSMutableArray *purposeStringArr = [NSMutableArray array];
                if ([purposeList isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *dic in purposeList) {
                        [purposeStringArr addObject:dic[@"name"]];
                    }
                }
                completionBlock(YES,purposeList,purposeStringArr.copy,timeList, MKResult.message);
            }
        }else{
            if (completionBlock) {
                completionBlock(NO,nil,nil,nil,MKResult.message);
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
            completionBlock(NO,nil,nil,nil,error.userInfo[NSLocalizedDescriptionKey]);
        }
    }];
}

+(void)callBackAddMeetingRequestWithParameterType:(NSInteger )type teacherName:(NSString *)staff_name select_time_one:(NSString *)select_time_one select_time_two:(NSString *)select_time_two select_time_three:(NSString *)select_time_three withCompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock
{
    NSDictionary *parameter = @{
                                    @"type":@(type),
                                    @"staff_name":staff_name,
                                    @"select_time_one":select_time_one,
                                    @"select_time_two":select_time_two,
                                    @"select_time_three":select_time_three,
                                };
    [MKNetworkManager sendPostRequestWithUrl:K_MK_AddMeeting_Url parameters:parameter hudIsShow:YES success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
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

+(void)callBackUpdateMeetingRequestWithParameterType:(NSInteger )type teacherName:(NSString *)staff_name select_time_one:(NSString *)select_time_one select_time_two:(NSString *)select_time_two select_time_three:(NSString *)select_time_three apply_id:(NSString *)apply_id withCompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock
{
    NSDictionary *parameter = @{
                                @"type":@(type),
                                @"staff_name":staff_name,
                                @"select_time_one":select_time_one,
                                @"select_time_two":select_time_two,
                                @"select_time_three":select_time_three,
                                @"apply_id" : apply_id,
                                };
    [MKNetworkManager sendPostRequestWithUrl:K_MK_UpdateMeeting_Url parameters:parameter hudIsShow:YES success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
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

+(void)callBackDeleteMeetingRequestWithParameteApply_id:(NSString *)apply_id withCompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock
{
    if ([NSString isEmptyWithStr:apply_id]) {
        return;
    }
    NSDictionary *parameter = @{
                                @"apply_id":apply_id,
                                };
    [MKNetworkManager sendGetRequestWithUrl:K_MK_DeleteMeeting_Url parameters:parameter hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
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
