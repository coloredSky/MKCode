//
//  MyBillManager.m
//  MK
//
//  Created by ginluck on 2019/4/26.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MyBillManager.h"

@implementation MyBillManager
+(void)callBackMyBillDataWithHudShow:(BOOL)hudShow  CompletionBlock:(void(^)(BOOL isSuccess,NSString *message, LoginModel *model))completionBlock
{
    [MKNetworkManager sendGetRequestWithUrl:K_MK_MyBillList_Url parameters:@{} hudIsShow:hudShow success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode ==1)
        {
            
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        
    }];
    
}
@end
