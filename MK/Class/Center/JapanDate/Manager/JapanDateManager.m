//
//  JapanDateManager.m
//  MK
//
//  Created by ginluck on 2019/6/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "JapanDateManager.h"

@implementation JapanDateManager

+(void)callBackUpdateJapanDateWithArrive_jp:(NSString *)arrive_jp mobile:(NSString *)mobile mobile_jp:(NSString *)mobile_jp completionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock
{
    
    NSDictionary * param =@{
                            @"arrive_jp":arrive_jp,
                            @"mobile": mobile,
                            @"mobile_jp": mobile_jp,
                            };
    [MKNetworkManager sendPostRequestWithUrl:K_MK_UpdateUserInfo_url parameters:param hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
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
