//
//  VersionUpdateManager.m
//  MK
//
//  Created by 周洋 on 2019/6/22.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "VersionUpdateManager.h"

@implementation VersionUpdateModel
@end

@implementation VersionUpdateManager

+(void)callBackAppVersionUpdateWithCompletionBlock:(void(^)(BOOL isSuccess,VersionUpdateModel *versionModel,NSString *message))completionBlock
{
    [MKNetworkManager sendGetRequestWithUrl:K_MK_APPVersionUpdate_url parameters:nil hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                VersionUpdateModel *versionModel = [VersionUpdateModel yy_modelWithJSON:MKResult.dataResponseObject];
                completionBlock(YES, versionModel, MKResult.message);
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
