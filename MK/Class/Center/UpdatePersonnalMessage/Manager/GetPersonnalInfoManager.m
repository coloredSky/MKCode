//
//  GetPersonnalInfoManager.m
//  MK
//
//  Created by ginluck on 2019/6/13.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "GetPersonnalInfoManager.h"

@implementation GetPersonnalInfoManager
+(void)callBackGetPerMessageWithHudShow:(BOOL)hudShow  CompletionBlock:(void(^)(BOOL isSuccess,NSString *message,PersonModel * model))completionBlock
{

    [MKNetworkManager sendPostRequestWithUrl:K_MK_GetUserInfo_url parameters:@{} hudIsShow:hudShow success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode ==0) {
            if (completionBlock)
            {
                PersonModel * model =[PersonModel yy_modelWithJSON:MKResult.dataResponseObject];

               completionBlock(YES,MKResult.message,model);
            }
        }
        else
        {
            completionBlock(NO,MKResult.message,nil);
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock)
        {
            completionBlock(NO,nil,nil);
        }
    }];
    //    [MKNetworkManager sendGetRequestWithUrl:K_MK_Home_AllCategoryList_Url hudIsShow:YES success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
    //        if (MKResult.responseCode == 0) {
    //            if (completionBlock) {
    //                NSArray *courseCayegoryList = [NSArray yy_modelArrayWithClass:[HomeCourseCategoryModel class] json:MKResult.dataResponseObject];
    //                completionBlock(YES, MKResult.message,courseCayegoryList);
    //            }
    //        }else{
    //            if (completionBlock) {
    //                completionBlock(NO, MKResult.message,[NSArray array]);
    //            }
    //        }
    //    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
    //        if (completionBlock) {
    //            completionBlock(NO, [NSString stringWithFormat:@"error code is %ld",statusCode],[NSArray array]);
    //        }
    //    }];
}
@end
