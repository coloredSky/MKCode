//
//  DiscoverManager.m
//  MK
//
//  Created by 周洋 on 2019/5/24.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "DiscoverManager.h"
#import "DiscoverNewsModel.h"

@implementation DiscoverManager

+(void)callBackDiscoverNewsListDataWithHUDShow:(BOOL)hudShow type:(NSString *)type pageOffset:(NSInteger )pageOffset pageLimit:(NSInteger )pageLimit andCompletionBlock:(void(^)(BOOL isSuccess,NSString *message,NSArray <DiscoverNewsModel *>*newsList))completionBlock
{
    if ([NSString isEmptyWithStr:type]) {
        return;
    }
    NSDictionary *parameter = @{
                                @"type":type,
                                @"offset":@(pageOffset),
                                @"length":@(pageLimit),
                                    };
    [MKNetworkManager sendGetRequestWithUrl:K_MK_Discover_NewsList_Url parameters:parameter hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                NSArray *newsList = [NSArray yy_modelArrayWithClass:[DiscoverNewsModel class] json:MKResult.dataResponseObject];
                completionBlock(YES,MKResult.message,newsList);
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
