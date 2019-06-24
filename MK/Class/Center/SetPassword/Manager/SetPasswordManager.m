//
//  SetPasswordManager.m
//  MK
//
//  Created by ginluck on 2019/6/13.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "SetPasswordManager.h"

@implementation SetPasswordManager
+(void)callBackSetPwdWithHudShow:(BOOL)hudShow oldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd CompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock
{
    NSDictionary * param =@{@"passwd":newPwd,@"old_passwd":oldPwd};
    [MKNetworkManager sendPostRequestWithUrl:K_MK_SetPwd_url parameters:param hudIsShow:hudShow success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
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
            completionBlock(NO,nil);
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
