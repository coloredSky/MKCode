//
//  JapanDateManager.m
//  MK
//
//  Created by ginluck on 2019/6/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "JapanDateManager.h"

@implementation JapanDateManager
+(void)callBackUpdateJapanDateWithHudShow:(BOOL)hudShow arrive_jp:(NSString *)arrive_jp CompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock
{
    
    NSDictionary * param =@{@"arrive_jp":arrive_jp};
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
