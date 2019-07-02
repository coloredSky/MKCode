//
//  LoginManager.m
//  MK
//
//  Created by ginluck on 2019/4/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "LoginManager.h"
#import "UserManager.h"
@implementation LoginManager

+(void)callBackLoginDataWithHudShow:(BOOL)hudShow userName:(NSString *)userName pwd:(NSString *)pwd CompletionBlock:(void(^)(BOOL isSuccess,NSString *message, LoginModel *model))completionBlock;
{
    NSDictionary * param =@{@"username":userName,@"password":pwd};
    [MKNetworkManager sendPostRequestWithUrl:K_MK_Login_url parameters:param hudIsShow:hudShow success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode ==0) {
            LoginModel * model =[LoginModel yy_modelWithJSON:MKResult.dataResponseObject];
            [[UserManager shareInstance]saveUser:model];
            [[UserManager shareInstance]saveToken:model.token];
            [[WYNetworkConfig sharedConfig] addCustomHeader:@{@"Authorization":model.token}];
            if (completionBlock){
                completionBlock(YES,MKResult.message,model);
            }
        }else{
            if (completionBlock){
                completionBlock(NO,MKResult.message,nil);
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock)
        {
            completionBlock(NO,error.userInfo[NSLocalizedDescriptionKey],nil);
        }
    }];
}
@end
