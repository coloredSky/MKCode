//
//  FeedBackManager.m
//  MK
//
//  Created by ginluck on 2019/6/13.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "FeedBackManager.h"
#import "FeedBackTypeModel.h"

@implementation FeedBackManager

+(void)callBackGetFeedBackTypeWithCompletionBlock:(void(^)(BOOL isSuccess, NSArray <FeedBackTypeModel *> *typeList,NSString *message))completionBlock
{
    [MKNetworkManager sendGetRequestWithUrl:K_MK_GetFeedBackType_url parameters:nil hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                NSArray *typeList = [NSArray yy_modelArrayWithClass:[FeedBackTypeModel class] json:MKResult.dataResponseObject];
                completionBlock(YES,typeList,MKResult.message);
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


+(void)callBackFeedBackWithHudShow:(BOOL)hudShow feedType:(NSInteger )type feedDetail:(NSString *)detail CompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock
{
    NSDictionary * param =@{@"type":@(type),@"detail":detail};
    [MKNetworkManager sendPostRequestWithUrl:K_MK_FeedBack_url parameters:param hudIsShow:hudShow success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode ==0) {
            if (completionBlock)
            {
                completionBlock(YES,MKResult.message);
            }
        }
        else
        {
            completionBlock(NO,MKResult.message);
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock)
        {
            completionBlock(NO,error.userInfo[NSLocalizedDescriptionKey]);
        }
    }];
}
@end
