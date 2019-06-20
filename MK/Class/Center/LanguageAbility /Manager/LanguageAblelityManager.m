//
//  LanguageAblelityManager.m
//  MK
//
//  Created by ginluck on 2019/6/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "LanguageAblelityManager.h"

@implementation LanguageAblelityManager
+(void)callBackUpdateLanguageAblelityWithHudShow:(BOOL)hudShow toeic:(NSString *)toeic toefl:(NSString *)toefl jlpt:(NSString *)jlpt  CompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;
{
    if ([NSString isEmptyWithStr:toeic] ==YES){
        [MBHUDManager showBriefAlert:@"请输入toeic分数"];
        return;
    }
    if ([NSString isEmptyWithStr:toefl]==YES){
        [MBHUDManager showBriefAlert:@"请输入toefl分数"];
        return;
    }
    if ([NSString isEmptyWithStr:jlpt]) {
        [MBHUDManager showBriefAlert:@"请输入日语等级"];
    }
    
    NSDictionary * param =@{@"toeic":toeic,@"toefl":toefl,@"jlpt":jlpt};
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
