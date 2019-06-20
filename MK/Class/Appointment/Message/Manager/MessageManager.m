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

+(void)callBackMessageListDataWithLimit:(NSInteger )limit offset:(NSInteger )offset completionBlock:(void(^)(BOOL isSuccess,NSArray <MKMessageModel *>*messageList,NSString *message))completionBlock
{
    NSDictionary *parameter = @{
                                @"limit":@(limit),
                                @"offset":@(offset),
                                };
    [MKNetworkManager sendPostRequestWithUrl:K_MK_GetMessageList_Url parameters:parameter hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                NSArray *messageList = [NSArray yy_modelArrayWithClass:[MKMessageModel class] json:MKResult.dataResponseObject];
                completionBlock(YES,messageList,MKResult.message);
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
