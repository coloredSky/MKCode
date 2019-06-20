//
//  LanAndSchManager.m
//  MK
//
//  Created by ginluck on 2019/6/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "LanAndSchManager.h"

@implementation LanAndSchManager
+(void)callBackUpdateLanguageAndSchoolWithHudShow:(BOOL)hudShow jp_school_id:(NSString *)jp_school_id jp_school_time:(NSString *)jp_school_time CompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock
{
    
    NSDictionary * param =@{@"jp_school_id":jp_school_id,@"jp_school_id":jp_school_id};
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
