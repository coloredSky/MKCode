//
//  PLVDeviceNetworkUtil.h
//  Demo
//
//  Created by Bq Lin on 2017/12/29.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PLVNetworkStatus) {
	PLVNetworkStatusNone = 0,
	PLVNetworkStatus2G,
	PLVNetworkStatus3G,
	PLVNetworkStatus4G,
	PLVNetworkStatus5G,
	PLVNetworkStatusWiFi
};
NS_INLINE NSString *NSStringFromPLVNetworkStatus(PLVNetworkStatus status) {
	switch (status) {
		case PLVNetworkStatusNone:{
			return @"未连接";
		}break;
		case PLVNetworkStatus2G:{
			return @"2G";
		}break;
		case PLVNetworkStatus3G:{
			return @"3G";
		}break;
		case PLVNetworkStatus4G:{
			return @"4G";
		}break;
		case PLVNetworkStatus5G:{
			return @"5G";
		}break;
		case PLVNetworkStatusWiFi:{
			return @"WiFi";
		}break;
	}
}

/// 获取当前时间
NSInteger PLVCurrentMicroseconds(void);
/// 计算时间间隔
NSInteger PLVTimeIntervalSinceMicroseconds(NSInteger microseconds);

// 优先返回 ipv6 地址
@interface PLVDeviceNetworkUtil : NSObject

/// 运营商信息
+ (NSDictionary *)carrierInfo;

/// 设备 IP
+ (NSString *)deviceIp;

/// 网关 IP
+ (NSString *)gatewayIp;
+ (NSString *)ipv4Gateway;
+ (NSString *)ipv6Gateway;

// 需在子线程执行
+ (NSArray *)DNSsWithDomain:(NSString *)domain;
+ (NSArray *)ipv4DNSsWithDomain:(NSString *)domain;
+ (NSArray *)ipv6DNSsWithDomain:(NSString *)domain;
+ (void)requestDNSsWithDomain:(NSString *)domain completion:(void (^)(NSTimeInterval interval, NSArray *DNSs))completion;

+ (NSArray *)outputDNSServers;

// 需在主线程执行
+ (PLVNetworkStatus)networkStatusFromStatusBar;
+ (void)requestNetworkTypeFromStatusBarWithCompletion:(void (^)(PLVNetworkStatus networkStatus))completion;

@end
