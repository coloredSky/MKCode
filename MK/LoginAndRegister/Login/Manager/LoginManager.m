//
//  LoginManager.m
//  MK
//
//  Created by ginluck on 2019/4/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "LoginManager.h"

@implementation LoginManager
+(void)callBackLoginDataWith:(NSString *)userName pwd:(NSString *)pwd CompletionBlock:(void(^)(BOOL isSuccess,NSString *message, LoginModel *model))completionBlock
{
    if ([NSString isEmptyWithStr:userName] ==YES){
        
    }
    if ([NSString isEmptyWithStr:pwd]==YES){
        
    }
//    MKNetworkManager sendPostRequestWithUrl:K_MK_Home_Login_url parameters:<#(nonnull id)#> hudIsShow:<#(BOOL)#> success:<#^(MKResponseResult *MKResult, BOOL isCacheObject)successBlock#> failure:<#^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)failureBlock#>
//    [MKNetworkManager sendGetRequestWithUrl:K_MK_Home_AllCategoryList_Url hudIsShow:YES success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
//        if (MKResult.responseCode == 1) {
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