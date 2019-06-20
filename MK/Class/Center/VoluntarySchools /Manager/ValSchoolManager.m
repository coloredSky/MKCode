//
//  ValSchoolManager.m
//  MK
//
//  Created by ginluck on 2019/6/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "ValSchoolManager.h"

@implementation ValSchoolManager
+(void)callBackUpdateValSchoolWithHudShow:(BOOL)hudShow discipline_id_1:(NSString *)discipline_id_1 discipline_id_2:(NSString *)discipline_id_2 discipline_id_3:(NSString *)discipline_id_3  CompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock
{
    
    NSDictionary * param =@{@"discipline_id_1":discipline_id_1,@"discipline_id_2":discipline_id_2,@"discipline_id_3":discipline_id_3};
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
