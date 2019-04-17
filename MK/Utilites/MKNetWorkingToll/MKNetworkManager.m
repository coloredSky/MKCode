//
//  MKNetworkManager.m
//  MK
//
//  Created by 周洋 on 2019/4/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

static NSString *const responseCode = @"status";
static NSString *const responseData = @"data";
static NSString *const responseMessage = @"msg";

#import "MKNetworkManager.h"


@implementation MKNetworkManager

+ (MKNetworkManager *_Nullable)sharedManager {
    
    static MKNetworkManager *sharedManager = NULL;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[MKNetworkManager alloc] init];
        [WYNetworkConfig sharedConfig].baseUrl = KMKBaseServerRequestUrl;
        [WYNetworkConfig sharedConfig].debugMode = YES;//默认为NO，不开启
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        [WYNetworkConfig sharedConfig].defailtParameters = @{@"version":appVersion, @"platform":@"iOS"};
        [WYNetworkConfig sharedConfig].timeoutSeconds = 20;//默认30s
    });
    return sharedManager;
}

+ (void)sendGetRequestWithUrl:(NSString *)url hudIsShow:(BOOL )hudShow success:(MKSuccessBlock)successBlock failure:(MKFailureBlock)failureBlock
{
    if (hudShow) {
        [MBHUDManager showLoading];
    }
    [[self sharedManager]sendGetRequest:WYJSONRequestSerializer url:url success:^(id responseObject, BOOL isCacheObject) {
        if (hudShow) {
            [MBHUDManager hideAlert];
        }
        if (successBlock) {
            MKResponseResult *result = [MKResponseResult new];
            result.responseObject = responseObject;
            result.responseCode = [responseObject[responseCode] integerValue];
            result.dataResponseObject = responseObject[responseData];
            result.message = responseObject[responseMessage];
            successBlock(result,isCacheObject);
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (hudShow) {
            [MBHUDManager hideAlert];
        }
        if (failureBlock) {
            failureBlock(task, error, statusCode);
        }
    }];
}

+(void)sendPostRequestWithUrl:(NSString *)url parameters:(id)parameters hudIsShow:(BOOL )hudShow success:(MKSuccessBlock)successBlock failure:(MKFailureBlock)failureBlock
{
    if (hudShow) {
        [MBHUDManager showLoading];
    }
    [[self sharedManager]sendPostRequest:WYJSONRequestSerializer url:url parameters:parameters success:^(id responseObject, BOOL isCacheObject) {
        if (hudShow) {
            [MBHUDManager hideAlert];
        }
        if (successBlock) {
            MKResponseResult *result = [MKResponseResult new];
            result.responseObject = responseObject;
            result.responseCode = [responseObject[responseCode] integerValue];
            result.dataResponseObject = responseObject[responseData];
            result.message = responseObject[responseMessage];
            successBlock(result,isCacheObject);
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (hudShow) {
            [MBHUDManager hideAlert];
        }
        if (failureBlock) {
            failureBlock(task, error, statusCode);
        }
    }];
}
@end

@implementation MKResponseResult

@end
