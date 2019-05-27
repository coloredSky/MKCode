//
//  RegisterManager.m
//  MK
//
//  Created by ginluck on 2019/4/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "RegisterManager.h"

@implementation RegisterManager
+(void)callBackPhoneCodeWithHudShow:(BOOL)hudShow phone:(NSString *)phone  CompletionBlock:(void(^)(BOOL isSuccess,NSString *message, NSString *code))completionBlock
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
                completionBlock(YES,MKResult.message,@"发送成功");
            }
        }else{
            if (completionBlock) {
                completionBlock(NO, MKResult.message,@"获取验证码失败");
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        
    }];
}
+(void)callBackRegisterWithHudShow:(BOOL)hudShow phone:(NSString *)phone code:(NSString *)code pwd:(NSString * )pwd CompletionBlock:(void(^)(BOOL isSuccess,NSString *message, NSString *status))completionBlock
{
    if ([NSString isEmptyWithStr:phone])
    {
        [MBHUDManager showBriefAlert:@"请填写手机号"];
        return;
    }
    if ([NSString isEmptyWithStr:code])
    {
        [MBHUDManager showBriefAlert:@"请填写验证码"];
        return;
    }
    if ([NSString isEmptyWithStr:pwd])
    {
        [MBHUDManager showBriefAlert:@"请填写密码"];
        return;
    }
    
    NSDictionary * param_dic =@{@"mobile":phone,@"code":code,@"passwd":pwd};
    [MKNetworkManager sendPostRequestWithUrl:K_MK_Register_Url parameters:param_dic hudIsShow:hudShow success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode ==0) {
            completionBlock(YES,MKResult.message,@"注册成功");
        }
        else
        {
            completionBlock(NO,MKResult.message,@"注册失败");
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        
    }];
}
@end
