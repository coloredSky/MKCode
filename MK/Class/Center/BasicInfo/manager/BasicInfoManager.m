//
//  BasicInfoManager.m
//  MK
//
//  Created by ginluck on 2019/6/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "BasicInfoManager.h"

@implementation BasicInfoManager
+(void)callBackUpdateBasicInfoWithHudShow:(BOOL)hudShow lastname:(NSString *)lastname firstname:(NSString *)firstname lastkana:(NSString *)lastkana firstkana:(NSString * )firstkana mobile:(NSString *)mobile mobile_jp:(NSString *)model_jp email:(NSString *)email weixin:(NSString *)weixin qq:(NSString *)qq province:(NSString *)province city:(NSString *)city  CompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock
{
    NSDictionary * param =@{@"firstname":firstname,@"lastname":lastname,@"firstkana":firstkana,@"lastkana":lastkana,@"mobile":mobile,@"mobile_jp":model_jp,@"email":email,@"weixin":weixin,@"qq":qq,@"province":province,@"city":city};
    [MKNetworkManager sendPostRequestWithUrl:K_MK_UpdateUserInfo_url parameters:param hudIsShow:hudShow success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
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
}
@end
