//
//  MessageManager.m
//  MK
//
//  Created by 周洋 on 2019/6/19.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "MessageManager.h"
#import "MKMessageModel.h"

@implementation MessageManager

+(void)callBackMessageListDataWithCompletionBlock:(void(^)(BOOL isSuccess,NSArray <MKMessageModel *>*messageList,NSString *message))completionBlock
{
    [MKNetworkManager sendGetRequestWithUrl:K_MK_GetMessageList_Url parameters:nil hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                
//                MKCourseDetailModel *detailModel = [MKCourseDetailModel yy_modelWithJSON:MKResult.dataResponseObject];
//                completionBlock(YES,MKResult.message,detailModel);
            }
        }else{
            if (completionBlock) {
//                completionBlock(NO,MKResult.message,nil);
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
//            completionBlock(NO,@"error",nil);
        }
    }];
}

@end
