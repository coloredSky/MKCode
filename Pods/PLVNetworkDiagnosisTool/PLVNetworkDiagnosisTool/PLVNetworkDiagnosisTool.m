//
//  PLVNetworkDiagnosisTool.m
//  Demo
//
//  Created by Bq Lin on 2017/12/28.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import "PLVNetworkDiagnosisTool.h"
#import <UIKit/UIKit.h>

typedef void(^PLVDomainInfoBlock)(PLVNetworkDiagnosisTool *diagnosisTool, NSDictionary *domainInfo);

@interface PLVNetworkDiagnosisTool ()

/// tcp 连接测试
@property (nonatomic, strong) PLVTcpConnectionService *connectionService;

/// ping 测试
@property (nonatomic, strong) PLVPingService *pingService;

@property (nonatomic, strong) NSDictionary *domainInfo;

@end

@implementation PLVNetworkDiagnosisTool

#pragma mark - dealloc

static id _sharedTool = nil;

+ (instancetype)sharedTool {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedTool = [[self alloc] init];
	});
	return _sharedTool;
}

- (instancetype)init {
	if (self = [super init]) {
	}
	return self;
}

#pragma mark - property

- (PLVTcpConnectionService *)connectionService {
	if (!_connectionService) {
		_connectionService = [[PLVTcpConnectionService alloc] init];
	}
	return _connectionService;
}

- (PLVPingService *)pingService {
	if (!_pingService) {
		_pingService = [[PLVPingService alloc] init];
	}
	return _pingService;
}

#pragma mark - public method

/// 获取客户端信息
+ (NSDictionary *)clientInfo {
	// 应用信息
	NSDictionary *bundleInfo = [NSBundle mainBundle].infoDictionary;
	NSString *appName = bundleInfo[@"CFBundleDisplayName"];
	if (!appName.length) appName = bundleInfo[@"CFBundleName"];
	NSString *appVersion = bundleInfo[@"CFBundleShortVersionString"];
	appName = [NSString stringWithFormat:@"%@ %@", appName, appVersion];
	
	// 机器信息
	UIDevice *device = [UIDevice currentDevice];
	NSString *systemName = [NSString stringWithFormat:@"%@ %@", device.systemName, device.systemVersion];
	
	// UUID
	NSString *uuid = @"";
	CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
	CFStringRef uuidString = CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
	uuid = [NSString stringWithString:(__bridge NSString *)uuidString];
	CFRelease(uuidString);
	CFRelease(uuidRef);
	
	NSMutableDictionary *clientInfo = [NSMutableDictionary dictionary];
	clientInfo[@"appName"] = appName;
	clientInfo[@"systemName"] = systemName;
	clientInfo[@"uuid"] = uuid;
	return clientInfo;
}

/// 获取设备网络信息
+ (NSDictionary *)deviceNetworkInfo {
	NSString *deviceIp = [PLVDeviceNetworkUtil deviceIp];
	NSString *gatewayIp = [PLVDeviceNetworkUtil gatewayIp];
	NSArray *outputDNSServers = [PLVDeviceNetworkUtil outputDNSServers];
	NSDictionary *carrierInfo = [PLVDeviceNetworkUtil carrierInfo];
	
	NSMutableDictionary *deviceNetworkInfo = [NSMutableDictionary dictionary];
	deviceNetworkInfo[@"deviceIp"] = deviceIp;
	deviceNetworkInfo[@"gatewayIp"] = gatewayIp;
	deviceNetworkInfo[@"outputDNSServers"] = outputDNSServers;
	deviceNetworkInfo[@"carrierInfo"] = carrierInfo;
	return deviceNetworkInfo;
}

/// 请求获取域名信息
- (void)requestDomainInfoWithCompletion:(void (^)(NSDictionary *domainInfo))completion {
	// 维护变量
	NSString *domain = self.domain;
	if (!domain.length) {
		if (completion) completion(nil);
		return;
	}
	self.domainInfo = nil;
	__block NSMutableDictionary *domainInfo = [NSMutableDictionary dictionary];
	__block BOOL dnsChecked = NO;
	__block BOOL pingChecked = NO;
	__block BOOL tcpChecked = NO;
	
	__weak typeof(self) weakSelf = self;
	
	void (^callbackResultIfNeed)(void) = ^(void) {
		if (!(dnsChecked && pingChecked && tcpChecked)) {
			return;
		}
		weakSelf.domainInfo = domainInfo;
		if (completion) completion(domainInfo);
	};
	
	// dns
	[PLVDeviceNetworkUtil requestDNSsWithDomain:domain completion:^(NSTimeInterval interval, NSArray *DNSs) {
		domainInfo[@"DNSs"] = DNSs;
		domainInfo[@"dnsInterval"] = @(interval);
		dnsChecked = YES;
		callbackResultIfNeed();
	}];
	
	// ping
	[self.pingService pingWithHost:domain completion:^(PLVPingService *pingService, NSString *result) {
		domainInfo[@"ping"] = result;
		pingChecked = YES;
		callbackResultIfNeed();
	}];
	
	// 当前网络状态
	[PLVDeviceNetworkUtil requestNetworkTypeFromStatusBarWithCompletion:^(PLVNetworkStatus networkStatus) {
		if (networkStatus == PLVNetworkStatusNone) {
			tcpChecked = YES;
			callbackResultIfNeed();
			return;
		}
		
		// tcp
		[weakSelf.connectionService connectWithHost:domain completion:^(PLVTcpConnectionService *tcpConnect, NSString *result, BOOL success) {
			if (!success) return;
			domainInfo[@"tcp"] = result;
			tcpChecked = YES;
			callbackResultIfNeed();
		}];
	}];
}

/// 请求获取所以信息
- (void)requestAllInfoCompletion:(void (^)(NSDictionary *info))completion {
	__weak typeof(self) weakSelf = self;
	[self requestDomainInfoWithCompletion:^(NSDictionary *domainInfo) {
		NSMutableDictionary *info = [NSMutableDictionary dictionary];
		info[@"clientInfo"] = [weakSelf.class clientInfo];
		info[@"deviceNetworkInfo"] = [weakSelf.class deviceNetworkInfo];
		info[@"domainInfo"] = domainInfo;
		if (completion) completion(info);
	}];
}

@end
