//
//  PLVDeviceNetworkUtil.m
//  Demo
//
//  Created by Bq Lin on 2017/12/29.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import "PLVDeviceNetworkUtil.h"
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <netdb.h>
#import <sys/socket.h>

#import <resolv.h>
#import <dns.h>

#import <sys/sysctl.h>
#import <netinet/in.h>
#import <sys/time.h>

#import "Route.h"

#define ROUNDUP(a) ((a) > 0 ? (1 + (((a)-1) | (sizeof(long) - 1))) : sizeof(long))


/// 获取当前时间
NSInteger PLVCurrentMicroseconds() {
	NSInteger ms = [NSDate date].timeIntervalSince1970 * 1000 * 1000;
	return ms;
//	struct timeval time;
//	gettimeofday(&time, NULL);
//	return time.tv_usec;
}

/// 计算时间间隔
NSInteger PLVTimeIntervalSinceMicroseconds(NSInteger microseconds) {
	NSInteger now = PLVCurrentMicroseconds();
	return now - microseconds;
}

@implementation PLVDeviceNetworkUtil

/// 运营商信息
+ (NSDictionary *)carrierInfo {
	//运营商信息
	CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
	CTCarrier *carrier = [netInfo subscriberCellularProvider];
	// 运营商
	NSString *carrierName = carrier.carrierName;
	// ISO 3166-1 country code
	NSString *isoCountryCode = carrier.isoCountryCode;
	// mobile country code (MCC)
	NSString *mobileCountryCode = carrier.mobileCountryCode;
	// mobile network code (MNC)
	NSString *mobileNetworkCode = carrier.mobileNetworkCode;
	
	NSMutableDictionary *carrierInfo = [NSMutableDictionary dictionary];
	carrierInfo[@"carrierName"] = carrierName;
	carrierInfo[@"isoCountryCode"] = isoCountryCode;
	carrierInfo[@"mobileCountryCode"] = mobileCountryCode;
	carrierInfo[@"mobileNetworkCode"] = mobileNetworkCode;
	return carrierInfo;
}

/// 设备 IP
+ (NSString *)deviceIp {
	NSString *deviceIp = @"";
	struct ifaddrs *interfaces = NULL;
	struct ifaddrs *temp_addr = NULL;
	int success = 0;
	
	success = getifaddrs(&interfaces);
	
	if (success == 0) {  // 0 表示获取成功
		temp_addr = interfaces;
		while (temp_addr != NULL) {
			//NSLog(@"ifa_name===%@", [NSString stringWithUTF8String:temp_addr->ifa_name]);
			// Check if interface is en0 which is the wifi connection on the iPhone
			if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"] || [[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"pdp_ip0"]) {
				//如果是IPV4地址，直接转化
				if (temp_addr->ifa_addr->sa_family == AF_INET) {
					deviceIp = [self formatIpv4WithAddress:((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr];
				}
				
				//如果是IPV6地址
				else if (temp_addr->ifa_addr->sa_family == AF_INET6) {
					deviceIp = [self formatIpv6WithAddress:((struct sockaddr_in6 *)temp_addr->ifa_addr)->sin6_addr];
					if (deviceIp && ![deviceIp isEqualToString:@""] && ![deviceIp.uppercaseString hasPrefix:@"FE80"]) break;
				}
			}
			
			temp_addr = temp_addr->ifa_next;
		}
	}
	
	freeifaddrs(interfaces);
	
	//以FE80开始的地址是单播地址
	if (deviceIp && ![deviceIp isEqualToString:@""] && ![deviceIp.uppercaseString hasPrefix:@"FE80"]) {
		return deviceIp;
	} else {
		return @"127.0.0.1";
	}
}

/// 网关 IP
+ (NSString *)gatewayIp {
	NSString *gatewayIp = nil;
	NSString *ipv4Gateway = [self ipv4Gateway];
	NSString *ipv6Gateway = [self ipv6Gateway];
	if (ipv6Gateway.length) {
		gatewayIp = ipv6Gateway;
	} else {
		gatewayIp = ipv4Gateway;
	}
	return gatewayIp;
}

+ (NSString *)ipv4Gateway {
	NSString *address = nil;
	
	/* net.route.0.inet.flags.gateway */
	int mib[] = {CTL_NET, PF_ROUTE, 0, AF_INET, NET_RT_FLAGS, RTF_GATEWAY};
	
	size_t l;
	char *buf, *p;
	struct rt_msghdr *rt;
	struct sockaddr *sa;
	struct sockaddr *sa_tab[RTAX_MAX];
	int i;
	
	if (sysctl(mib, sizeof(mib) / sizeof(int), 0, &l, 0, 0) < 0) {
		address = @"192.168.0.1";
	}
	
	if (l > 0) {
		buf = malloc(l);
		if (sysctl(mib, sizeof(mib) / sizeof(int), buf, &l, 0, 0) < 0) {
			address = @"192.168.0.1";
		}
		
		for (p = buf; p < buf + l; p += rt->rtm_msglen) {
			rt = (struct rt_msghdr *)p;
			sa = (struct sockaddr *)(rt + 1);
			for (i = 0; i < RTAX_MAX; i++) {
				if (rt->rtm_addrs & (1 << i)) {
					sa_tab[i] = sa;
					sa = (struct sockaddr *)((char *)sa + ROUNDUP(sa->sa_len));
				} else {
					sa_tab[i] = NULL;
				}
			}
			
			if (((rt->rtm_addrs & (RTA_DST | RTA_GATEWAY)) == (RTA_DST | RTA_GATEWAY)) &&
				sa_tab[RTAX_DST]->sa_family == AF_INET &&
				sa_tab[RTAX_GATEWAY]->sa_family == AF_INET) {
				unsigned char octet[4] = {0, 0, 0, 0};
				int i;
				for (i = 0; i < 4; i++) {
					octet[i] = (((struct sockaddr_in *)(sa_tab[RTAX_GATEWAY]))->sin_addr.s_addr >> (i * 8)) & 0xFF;
				}
				if (((struct sockaddr_in *)sa_tab[RTAX_DST])->sin_addr.s_addr == 0) {
					in_addr_t addr =
					((struct sockaddr_in *)(sa_tab[RTAX_GATEWAY]))->sin_addr.s_addr;
					address = [self formatIpv4WithAddress:*((struct in_addr *)&addr)];
					//NSLog(@"IPV4address%@", address);
					break;
				}
			}
		}
		free(buf);
	}
	
	return address;
}

+ (NSString *)ipv6Gateway {
	NSString *address = nil;
	
	/* net.route.0.inet.flags.gateway */
	int mib[] = {CTL_NET, PF_ROUTE, 0, AF_INET6, NET_RT_FLAGS, RTF_GATEWAY};
	
	size_t l;
	char *buf, *p;
	struct rt_msghdr *rt;
	struct sockaddr_in6 *sa;
	struct sockaddr_in6 *sa_tab[RTAX_MAX];
	int i;
	
	if (sysctl(mib, sizeof(mib) / sizeof(int), 0, &l, 0, 0) < 0) {
		address = @"192.168.0.1";
	}
	
	if (l > 0) {
		buf = malloc(l);
		if (sysctl(mib, sizeof(mib) / sizeof(int), buf, &l, 0, 0) < 0) {
			address = @"192.168.0.1";
		}
		
		for (p = buf; p < buf + l; p += rt->rtm_msglen) {
			rt = (struct rt_msghdr *)p;
			sa = (struct sockaddr_in6 *)(rt + 1);
			for (i = 0; i < RTAX_MAX; i++) {
				if (rt->rtm_addrs & (1 << i)) {
					sa_tab[i] = sa;
					sa = (struct sockaddr_in6 *)((char *)sa + sa->sin6_len);
				} else {
					sa_tab[i] = NULL;
				}
			}
			
			if( ((rt->rtm_addrs & (RTA_DST|RTA_GATEWAY)) == (RTA_DST|RTA_GATEWAY))
			   && sa_tab[RTAX_DST]->sin6_family == AF_INET6
			   && sa_tab[RTAX_GATEWAY]->sin6_family == AF_INET6) {
				address = [self formatIpv6WithAddress:((struct sockaddr_in6 *)(sa_tab[RTAX_GATEWAY]))->sin6_addr];
				//NSLog(@"IPV6address%@", address);
				break;
			}
		}
		free(buf);
	}
	
	return address;
}

#pragma mark - DNS

+ (void)requestDNSsWithDomain:(NSString *)domain completion:(void (^)(NSTimeInterval interval, NSArray *DNSs))completion {
	NSInteger startTime = PLVCurrentMicroseconds();
	[[[NSOperationQueue alloc] init] addOperationWithBlock:^{
		NSArray *DNSs = [PLVDeviceNetworkUtil DNSsWithDomain:domain];
		NSTimeInterval interval = PLVTimeIntervalSinceMicroseconds(startTime) / 1000.0;
		if (completion) completion(interval, DNSs);
	}];
}

+ (NSArray *)DNSsWithDomain:(NSString *)domain {
	NSArray *result = nil;
	NSArray *ipv4DNSs = [self ipv4DNSsWithDomain:domain];
	if (ipv4DNSs && ipv4DNSs.count) {
		result = ipv4DNSs;
	}
	
	//由于在IPV6环境下不能用IPV4的地址进行连接监测，所以只返回IPV6的服务器DNS地址
	NSArray *ipv6DNSs = [self ipv6DNSsWithDomain:domain];
	if (ipv6DNSs && ipv6DNSs.count) {
		result = ipv6DNSs;
	}
	
	return result;
}

+ (NSArray *)ipv4DNSsWithDomain:(NSString *)domain {
	const char *host_name = [domain UTF8String];
	struct hostent *phot;
	
	@try {
		phot = gethostbyname(host_name);
	} @catch (NSException *exception) {
		return nil;
	}
	
	NSMutableArray *result = [NSMutableArray array];
	
	for (int i = 0; phot && phot->h_addr_list && phot->h_addr_list[i]; i++) {
		struct in_addr ip_addr;
		memcpy(&ip_addr, phot->h_addr_list[i], 4);
		char ip[20] = {0};
		inet_ntop(AF_INET, &ip_addr, ip, sizeof(ip));

		NSString *strIPAddress = [NSString stringWithUTF8String:ip];
		[result addObject:strIPAddress];
	}
	
	return result;
}


+ (NSArray *)ipv6DNSsWithDomain:(NSString *)domain {
	const char *host_name = [domain UTF8String];
	struct hostent *phot;
	
	// 只有在IPV6的网络下才会有返回值
	@try {
		phot = gethostbyname2(host_name, AF_INET6);
	} @catch (NSException *exception) {
		return nil;
	}
	
	NSMutableArray *result = [NSMutableArray array];
	for (int i = 0; phot && phot->h_addr_list && phot->h_addr_list[i]; i++) {
		struct in6_addr ip6_addr;
		memcpy(&ip6_addr, phot->h_addr_list[i], sizeof(struct in6_addr));
		NSString *strIPAddress = [self formatIpv6WithAddress:ip6_addr];
		[result addObject:strIPAddress];
	}
	
	return result;
}

#pragma mark - 当前网络DNS服务器地址

+ (NSArray *)outputDNSServers {
	res_state res = malloc(sizeof(struct __res_state));
	int result = res_ninit(res);
	
	NSMutableArray *servers = [NSMutableArray array];
	if (result == 0) {
		union res_9_sockaddr_union *addr_union = malloc(res->nscount * sizeof(union res_9_sockaddr_union));
		res_getservers(res, addr_union, res->nscount);
		
		for (int i = 0; i < res->nscount; i++) {
			if (addr_union[i].sin.sin_family == AF_INET) {
				char ip[INET_ADDRSTRLEN];
				inet_ntop(AF_INET, &(addr_union[i].sin.sin_addr), ip, INET_ADDRSTRLEN);
				NSString *dnsIP = [NSString stringWithUTF8String:ip];
				[servers addObject:dnsIP];
				//NSLog(@"IPv4 DNS IP: %@", dnsIP);
			} else if (addr_union[i].sin6.sin6_family == AF_INET6) {
				char ip[INET6_ADDRSTRLEN];
				inet_ntop(AF_INET6, &(addr_union[i].sin6.sin6_addr), ip, INET6_ADDRSTRLEN);
				NSString *dnsIP = [NSString stringWithUTF8String:ip];
				[servers addObject:dnsIP];
				//NSLog(@"IPv6 DNS IP: %@", dnsIP);
			} else {
				//NSLog(@"Undefined family.");
			}
		}
	}
	res_nclose(res);
	free(res);
	
	return servers;
}

#pragma mark - 获取当前网络类型

+ (PLVNetworkStatus)networkStatusFromStatusBar {
	NSArray *subviews = [[[[UIApplication sharedApplication] valueForKey:@"statusBar"]
						  valueForKey:@"foregroundView"] subviews];
	NSNumber *dataNetworkItemView = nil;
	for (id subview in subviews) {
		if ([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
			dataNetworkItemView = subview;
			break;
		}
	}
	PLVNetworkStatus networkType = PLVNetworkStatusNone;
	NSNumber *networkTypeNumber = [dataNetworkItemView valueForKey:@"dataNetworkType"];
	networkType = networkTypeNumber.intValue;
	return networkType;
}
+ (void)requestNetworkTypeFromStatusBarWithCompletion:(void (^)(PLVNetworkStatus networkStatus))completion {
	dispatch_async(dispatch_get_main_queue(), ^{
		PLVNetworkStatus status = [PLVDeviceNetworkUtil networkStatusFromStatusBar];
		if (completion) completion(status);
	});
}

#pragma mark - tool

+ (NSString *)formatIpv4WithAddress:(struct in_addr)ipv4_addr {
	NSString *address = nil;
	
	char dst_str[INET_ADDRSTRLEN];
	char src_str[INET_ADDRSTRLEN];
	memcpy(src_str, &ipv4_addr, sizeof(struct in_addr));
	if(inet_ntop(AF_INET, src_str, dst_str, INET_ADDRSTRLEN) != NULL){
		address = [NSString stringWithUTF8String:dst_str];
	}
	
	return address;
}

+ (NSString *)formatIpv6WithAddress:(struct in6_addr)ipv6_addr{
	NSString *address = nil;
	
	char dst_str[INET6_ADDRSTRLEN];
	char src_str[INET6_ADDRSTRLEN];
	memcpy(src_str, &ipv6_addr, sizeof(struct in6_addr));
	if(inet_ntop(AF_INET6, src_str, dst_str, INET6_ADDRSTRLEN) != NULL){
		address = [NSString stringWithUTF8String:dst_str];
	}
	
	return address;
}

@end
