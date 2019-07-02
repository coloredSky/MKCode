//
//  RegisterManager.m
//  MK
//
//  Created by ginluck on 2019/4/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "RegisterManager.h"

@implementation RegisterManager

+(void)callBackPhoneCodeWithHudShow:(BOOL)hudShow phone:(NSString *)phone  CompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock
{
    if ([NSString isEmptyWithStr:phone]==YES)
    {
        [MBHUDManager showBriefAlert:@"请输入手机号"];
        return;
    }
    NSDictionary * param =@{@"mobile":phone};
    [MKNetworkManager sendPostRequestWithUrl:K_MK_GetPhoneCode_url parameters:param hudIsShow:hudShow success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                completionBlock(YES,MKResult.message);
            }
        }else{
            if (completionBlock) {
                completionBlock(NO, MKResult.message);
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
            completionBlock(NO,error.userInfo[NSLocalizedDescriptionKey]);
        }
    }];
}

+(void)callBackRegisterWithHudShow:(BOOL)hudShow phone:(NSString *)phone code:(NSString *)code pwd:(NSString * )pwd CompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock
{
    NSDictionary * param_dic =@{@"mobile":phone,@"code":code,@"passwd":pwd};
    [MKNetworkManager sendPostRequestWithUrl:K_MK_Register_Url parameters:param_dic hudIsShow:hudShow success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode ==0) {
            completionBlock(YES,MKResult.message);
        }else{
            completionBlock(NO,MKResult.message);
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
            completionBlock(NO,error.userInfo[NSLocalizedDescriptionKey]);
        }
    }];
}

+(void)callBackFindPasswordRequestWithMobile:(NSString * )mobile code:(NSString * )code passwd:(NSString * )passwd repasswd:(NSString * )repasswd andCompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock
{
    NSDictionary *parameter = @{
                                @"mobile":mobile,
                                @"code":code,
                                @"passwd":passwd,
                                @"repasswd":repasswd,
                                };
    [MKNetworkManager sendPostRequestWithUrl:K_MK_UserFindPassword_Url parameters:parameter hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode ==0) {
            completionBlock(YES,MKResult.message);
        }else{
            completionBlock(NO,MKResult.message);
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
            completionBlock(NO,error.userInfo[NSLocalizedDescriptionKey]);
        }
    }];
}
@end
