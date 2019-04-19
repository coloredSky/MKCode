//
//  MKNetworkManager.h
//  MK
//
//  Created by 周洋 on 2019/4/17.
//  Copyright © 2019年 周洋. All rights reserved.
//


@class MKResponseResult;
typedef void(^MKSuccessBlock)(MKResponseResult *MKResult, BOOL isCacheObject);
typedef void(^MKFailureBlock)(NSURLSessionTask *task, NSError *error, NSInteger statusCode);

#import "WYNetwork.h"

NS_ASSUME_NONNULL_BEGIN

/**
 返回数据解析
 */
@interface MKResponseResult : NSObject
@property (nonatomic, assign) NSInteger responseCode;//状态码
@property (nonatomic, strong) id responseObject;//全部数据
@property (nonatomic, strong) id dataResponseObject;//data中数据
@property (nonatomic, copy) NSString *message;//

@end


@interface MKNetworkManager : WYNetworkManager

/**
 get请求

 @param url URL
 @param hudShow 是否显示正在加载框
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
+ (void)sendGetRequestWithUrl:(NSString *)url parameters:(id _Nullable)parameters hudIsShow:(BOOL )hudShow success:(MKSuccessBlock)successBlock failure:(MKFailureBlock)failureBlock;


/**
 post 请求

 @param url URL
 @param parameters 请求参数
 @param hudShow 是否显示正在加载框
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
+(void)sendPostRequestWithUrl:(NSString *)url parameters:(id)parameters hudIsShow:(BOOL )hudShow success:(MKSuccessBlock)successBlock failure:(MKFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
