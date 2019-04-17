//
//  LoginManager.m
//  MK
//
//  Created by ginluck on 2019/4/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "LoginManager.h"

@implementation LoginManager
+(void)callBackLoginDataWithHudShow:(BOOL)hudShow userName:(NSString *)userName pwd:(NSString *)pwd CompletionBlock:(void(^)(BOOL isSuccess,NSString *message, LoginModel *model))completionBlock;
{
    if ([NSString isEmptyWithStr:userName] ==YES){
        [MBHUDManager showBriefAlert:@"请输入用户名"];
        return;
    }
    if ([NSString isEmptyWithStr:pwd]==YES){
        [MBHUDManager showBriefAlert:@"请输入密码"];
        return;
    }
    NSDictionary * param =@{@"username":userName,@"password":pwd};
    [MKNetworkManager sendPostRequestWithUrl:K_MK_Login_url parameters:param hudIsShow:hudShow success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode ==1) {
            if (completionBlock)
            {
                
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        
    }];
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
