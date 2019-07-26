//
//  DiscoverManager.m
//  MK
//
//  Created by 周洋 on 2019/5/24.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "DiscoverManager.h"
#import "DiscoverNewsModel.h"
#import "MKCourseListModel.h"

@implementation DiscoverManager

+(void)callBackDiscoverNewsListDataWithHUDShow:(BOOL)hudShow  page:(NSInteger )page page_size:(NSInteger )page_size andCompletionBlock:(void(^)(BOOL isSuccess,NSString *message,NSArray <DiscoverNewsModel *>*newsList, NSInteger totalpage,NSArray <MKCourseListModel *>*liveList))completionBlock
{
    NSDictionary *parameter = @{
                                @"page":@(page),
                                @"page_size":@(page_size),
                                    };
    [MKNetworkManager sendGetRequestWithUrl:K_MK_Discover_NewsList_Url parameters:parameter hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            NSArray *liveList;
            if ([MKResult.dataResponseObject[@"article_course"] isKindOfClass:[NSArray class]]) {
                liveList = [NSArray yy_modelArrayWithClass:[MKCourseListModel class] json:MKResult.dataResponseObject[@"article_course"]];
            }
            NSDictionary *posts_list = MKResult.dataResponseObject[@"posts_list"];
            NSArray *newsList = [NSArray yy_modelArrayWithClass:[DiscoverNewsModel class] json:posts_list[@"data"]];
            NSInteger totalpage =[posts_list[@"last_page"] integerValue];
            if (completionBlock) {
                completionBlock(YES,MKResult.message,newsList,totalpage,liveList);
            }
        }else{
            if (completionBlock) {
                completionBlock(NO,MKResult.message,nil,0,nil);
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
            completionBlock(NO,error.userInfo[NSLocalizedDescriptionKey],nil,0,nil);
        }
    }];
}

+(void)callBackDiscoverNewsDetailDataWithHUDShow:(BOOL)hudShow  newsID:(NSString *)newsID andCompletionBlock:(void(^)(BOOL isSuccess,NSString *message,DiscoverNewsModel *newsDetailModel))completionBlock
{
    if ([NSString isEmptyWithStr:newsID]) {
        return;
    }
    NSDictionary *parameter = @{
                                @"id":newsID,
                                };
    [MKNetworkManager sendGetRequestWithUrl:K_MK_Discover_NewsDetail_Url parameters:parameter hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                DiscoverNewsModel *newsDetailModel = [DiscoverNewsModel yy_modelWithJSON:MKResult.dataResponseObject];
                completionBlock(YES,MKResult.message,newsDetailModel);
            }
        }else{
            if (completionBlock) {
                completionBlock(NO,MKResult.message,nil);
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
            completionBlock(NO,error.userInfo[NSLocalizedDescriptionKey],nil);
        }
    }];
}

@end
