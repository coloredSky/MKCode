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
#import "AppDelegate.h"

@interface MKNetworkManager()

@end

@implementation MKNetworkManager

+ (MKNetworkManager *_Nullable)sharedManager {
    
    static MKNetworkManager *sharedManager = NULL;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[MKNetworkManager alloc] init];
        [WYNetworkConfig sharedConfig].baseUrl = KMKBaseServerRequestUrl;
        [WYNetworkConfig sharedConfig].debugMode = YES;//默认为NO，不开启
        [[WYNetworkConfig sharedConfig] addCustomHeader:@{@"DeviceType":@"1"}];
        if ([[UserManager shareInstance]isLogin]) {
            [[WYNetworkConfig sharedConfig] addCustomHeader:@{@"Authorization":[[UserManager shareInstance] getToken]}];
        }
        [WYNetworkConfig sharedConfig].timeoutSeconds = 20;//默认30s
    });
    return sharedManager;
}

+ (void)sendGetRequestWithUrl:(NSString *)url parameters:(id _Nullable)parameters hudIsShow:(BOOL )hudShow success:(MKSuccessBlock)successBlock failure:(MKFailureBlock)failureBlock;
{
    if (hudShow) {
        [MBHUDManager showLoading];
    }
    [[self sharedManager]sendGetRequest:WYJSONRequestSerializer url:url parameters:parameters success:^(id responseObject, BOOL isCacheObject) {
        if (hudShow) {
            [MBHUDManager hideAlert];
        }
        if (successBlock) {
            MKResponseResult *result = [MKResponseResult new];
            result.responseObject = responseObject;
            if (![NSString isEmptyWithStr:responseObject[responseCode]]) {
                result.responseCode = [responseObject[responseCode] integerValue];
            }else{
                result.responseCode = 1;
            }
            result.dataResponseObject = responseObject[responseData];
            result.message = responseObject[responseMessage];
            successBlock(result,isCacheObject);
            if (result.responseCode == 999) {
                [MBHUDManager showBriefAlert:result.message];
                [[UserManager shareInstance] loginOut];
                [[WYNetworkConfig sharedConfig] addCustomHeader:@{@"Authorization":@""}];
                [[NSNotificationCenter defaultCenter]postNotificationName:kMKLoginOutNotifcationKey object:nil];
                [[AppDelegate instance] pb_presentShowLoginViewController];
            }
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
    [[self sharedManager]sendPostRequest:WYHTTPRequestSerializer url:url parameters:parameters success:^(id responseObject, BOOL isCacheObject) {
        if (hudShow) {
            [MBHUDManager hideAlert];
        }
        if (successBlock) {
            MKResponseResult *result = [MKResponseResult new];
            result.responseObject = responseObject;
            if (![NSString isEmptyWithStr:responseObject[responseCode]]) {
                result.responseCode = [responseObject[responseCode] integerValue];
            }else{
                result.responseCode = 1;
            }
            result.dataResponseObject = responseObject[responseData];
            result.message = responseObject[responseMessage];
            successBlock(result,isCacheObject);
            if (result.responseCode == 999) {
                [MBHUDManager showBriefAlert:result.message];
                [[UserManager shareInstance] loginOut];
                [[WYNetworkConfig sharedConfig] addCustomHeader:@{@"Authorization":@""}];
                [[NSNotificationCenter defaultCenter]postNotificationName:kMKLoginOutNotifcationKey object:nil];
                [[AppDelegate instance] pb_presentShowLoginViewController];
            }
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
