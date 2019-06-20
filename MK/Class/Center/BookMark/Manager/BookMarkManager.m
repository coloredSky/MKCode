//
//  BookMarkManager.m
//  MK
//
//  Created by 周洋 on 2019/6/17.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "BookMarkManager.h"
#import "BookMarkModel.h"

@implementation BookMarkManager

+(void)callBackUserBookMarkListRequesWithCompletionBlock:(void(^)(BOOL isSuccess, NSArray <BookMarkModel *>*bookMarkList,NSString *message))completionBlock
{
    [MKNetworkManager sendGetRequestWithUrl:K_MK_UserBookMarkList_Url parameters:nil hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                NSMutableArray *modelArr = [NSMutableArray arrayWithCapacity:2];
                NSArray *onlineList = [NSArray yy_modelArrayWithClass:[BookMarkListModel class] json:MKResult.dataResponseObject[@"online"]];
                if (onlineList.count > 0) {
                    BookMarkModel *markModel = [BookMarkModel new];
                    markModel.titleString = @"线上课程";
                    markModel.isOnline = YES;
                    markModel.bookMarkList = onlineList;
                    [modelArr addObject:markModel];
                }
                
                NSArray *offlineList = [NSArray yy_modelArrayWithClass:[BookMarkListModel class] json:MKResult.dataResponseObject[@"offline"]];
                if (offlineList.count > 0) {
                    BookMarkModel *markModel = [BookMarkModel new];
                    markModel.titleString = @"线下课程";
                    markModel.isOnline = NO;
                    markModel.bookMarkList = offlineList;
                    [modelArr addObject:markModel];
                }
                completionBlock(YES,modelArr.copy,MKResult.message);
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
