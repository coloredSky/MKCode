//
//  MyBillManager.m
//  MK
//
//  Created by ginluck on 2019/4/26.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MyBillManager.h"
#import "UserBillListModel.h"

@implementation MyBillManager

+(void)callBackMyBillDataWithCompletionBlock:(void(^)(BOOL isSuccess,NSArray <UserBillListModel *> *billList,NSString *message))completionBlock
{
    [MKNetworkManager sendGetRequestWithUrl:K_MK_MyBillList_Url parameters:nil hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                NSArray *billList = [NSArray yy_modelArrayWithClass:[UserBillListModel class] json:MKResult.dataResponseObject];
                completionBlock(YES,billList,MKResult.message);
            }
        }else{
            if (completionBlock) {
                completionBlock(NO,nil,MKResult.message);
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
            completionBlock(NO,nil,error.userInfo[NSLocalizedDescriptionKey]);
        }
    }];
    
}
@end
