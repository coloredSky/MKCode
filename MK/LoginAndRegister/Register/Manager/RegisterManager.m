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
    phone = @"15871808259";
    if ([NSString isEmptyWithStr:phone]==YES)
    {
        [MBHUDManager showBriefAlert:@"请输入手机号"];
        return;
    }
    NSDictionary * param =@{@"mobile":phone};
    [MKNetworkManager sendPostRequestWithUrl:K_MK_GetPhoneCode_url parameters:param hudIsShow:hudShow success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 1) {
            if (completionBlock) {

            }
        }else{
            if (completionBlock) {
//                completionBlock(NO, MKResult.message,[NSArray array]);
            }
        }

    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        
    }];
    
}
@end
