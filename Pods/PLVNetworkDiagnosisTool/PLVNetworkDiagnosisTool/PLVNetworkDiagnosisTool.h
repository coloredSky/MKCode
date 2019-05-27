//
//  PLVNetworkDiagnosisTool.h
//  Demo
//
//  Created by Bq Lin on 2017/12/28.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLVDeviceNetworkUtil.h"
#import "PLVTcpConnectionService.h"
#import "PLVPingService.h"
#import "PLVTraceRouteService.h"

@interface PLVNetworkDiagnosisTool : NSObject

@property (nonatomic, copy) NSString *domain;
@property (nonatomic, strong, readonly) NSDictionary *domainInfo;

+ (instancetype)sharedTool;

/// 获取客户端信息
+ (NSDictionary *)clientInfo;

/// 获取设备网络信息
+ (NSDictionary *)deviceNetworkInfo;

/// 请求获取域名信息
- (void)requestDomainInfoWithCompletion:(void (^)(NSDictionary *domainInfo))completion;

/// 请求获取所以信息
- (void)requestAllInfoCompletion:(void (^)(NSDictionary *info))completion;

@end
