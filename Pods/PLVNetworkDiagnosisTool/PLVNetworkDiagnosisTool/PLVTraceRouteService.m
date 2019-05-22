//
//  PLVTraceRouteService.m
//  Demo
//
//  Created by Bq Lin on 2018/1/12.
//  Copyright © 2018年 POLYV. All rights reserved.
//

#import "PLVTraceRouteService.h"
#import "PLVDeviceNetworkUtil.h"

#import <arpa/inet.h>
#import <sys/time.h>

static const int TRACEROUTE_PORT = 30001;
static const int TRACEROUTE_MAX_TTL = 30;
static const int TRACEROUTE_ATTEMPTS = 3;
static const int TRACEROUTE_TIMEOUT = 5000000;

@interface PLVTraceRouteService ()

@property (nonatomic, strong) NSMutableArray<NSString *> *results;

@end

@implementation PLVTraceRouteService

#pragma mark - dealloc & init

- (instancetype)init {
	if (self = [super init]) {
		_maxTTL = TRACEROUTE_MAX_TTL;
		_readTimeout = TRACEROUTE_TIMEOUT;
		_maxAttempts = TRACEROUTE_ATTEMPTS;
		_udpPort = TRACEROUTE_PORT;
	}
	return self;
}

#pragma mark - property

- (NSMutableArray<NSString *> *)results {
	if (!_results) {
		_results = [NSMutableArray array];
	}
	return _results;
}

/// 开始 tranceroute
- (void)traceRoute:(NSString *)host {
	// 维护变量
	self.results = nil;
	
	//从name server获取server主机的地址
	NSArray *serverDNSs = [PLVDeviceNetworkUtil DNSsWithDomain:host];
	if (!serverDNSs || serverDNSs.count <= 0) {
		// 无法获取 host 地址
		[self.results addObject:[NSString stringWithFormat:@"Could not get host address, %@", host]];
		if (self.traceRouteCompletion) self.traceRouteCompletion(self, NO);
		return;
	}
	
	NSString *ipAddr0 = serverDNSs.firstObject;
	//设置server主机的套接口地址
	NSData *addrData = nil;
	BOOL isIPV6 = NO;
	if ([ipAddr0 rangeOfString:@":"].location == NSNotFound) {
		isIPV6 = NO;
		struct sockaddr_in nativeAddr4;
		memset(&nativeAddr4, 0, sizeof(nativeAddr4));
		nativeAddr4.sin_len = sizeof(nativeAddr4);
		nativeAddr4.sin_family = AF_INET;
		nativeAddr4.sin_port = htons(self.udpPort);
		inet_pton(AF_INET, ipAddr0.UTF8String, &nativeAddr4.sin_addr.s_addr);
		addrData = [NSData dataWithBytes:&nativeAddr4 length:sizeof(nativeAddr4)];
	} else {
		isIPV6 = YES;
		struct sockaddr_in6 nativeAddr6;
		memset(&nativeAddr6, 0, sizeof(nativeAddr6));
		nativeAddr6.sin6_len = sizeof(nativeAddr6);
		nativeAddr6.sin6_family = AF_INET6;
		nativeAddr6.sin6_port = htons(self.udpPort);
		inet_pton(AF_INET6, ipAddr0.UTF8String, &nativeAddr6.sin6_addr);
		addrData = [NSData dataWithBytes:&nativeAddr6 length:sizeof(nativeAddr6)];
	}
	
	struct sockaddr *destination;
	destination = (struct sockaddr *)[addrData bytes];
	
	//初始化套接口
	struct sockaddr fromAddr;
	int recv_sock;
	int send_sock;
	Boolean error = false;
	
	self.running = YES;
	//创建一个支持ICMP协议的UDP网络套接口（用于接收）
	if ((recv_sock = socket(destination->sa_family, SOCK_DGRAM, isIPV6?IPPROTO_ICMPV6:IPPROTO_ICMP)) < 0) {
		// Could not create recv socket
		[self.results addObject:[NSString stringWithFormat:@"Could not create receive socket"]];
		if (self.traceRouteCompletion) self.traceRouteCompletion(self, NO);
		return;
	}
	
	//创建一个UDP套接口（用于发送）
	if ((send_sock = socket(destination->sa_family, SOCK_DGRAM, 0)) < 0) {
		// !!!: Could not create xmit socket
		[self.results addObject:[NSString stringWithFormat:@"Could not create submit socket"]];
		if (self.traceRouteCompletion) self.traceRouteCompletion(self, NO);
		return;
	}
	
	char *cmsg = "GET / HTTP/1.1\r\n\r\n";
	socklen_t n = sizeof(fromAddr);
	char buf[100];
	
	NSInteger ttl = 1;  // index sur le TTL en cours de traitement.
	int timeoutTTL = 0;
	bool icmp = false;  // Positionné à true lorsqu'on reçoit la trame ICMP en retour.
	long startTime;     // Timestamp lors de l'émission du GET HTTP
	long delta;         // Durée de l'aller-retour jusqu'au hop.
	
	// On progresse jusqu'à un nombre de TTLs max.
	while (ttl <= self.maxTTL) {
		memset(&fromAddr, 0, sizeof(fromAddr));
		//设置sender 套接字的ttl
		if ((isIPV6? setsockopt(send_sock,IPPROTO_IPV6, IPV6_UNICAST_HOPS, &ttl, sizeof(ttl)):setsockopt(send_sock, IPPROTO_IP, IP_TTL, &ttl, sizeof(ttl))) < 0) {
			error = true;
			// setsockopt failled
			[self.results addObject:[NSString stringWithFormat:@"set sockopt failed"]];
		}
		
		//每一步连续发送maxAttenpts报文
		icmp = false;
		NSMutableString *traceTTLLog = [NSMutableString string];
		NSString *hostAddress = @"***";
		for (int try = 0; try < self.maxAttempts; try ++) {
			startTime = PLVCurrentMicroseconds();
			//发送成功返回值等于发送消息的长度
			ssize_t sentLen = sendto(send_sock, cmsg, sizeof(cmsg), 0, (struct sockaddr *)destination, isIPV6?sizeof(struct sockaddr_in6):sizeof(struct sockaddr_in));
			if (sentLen != sizeof(cmsg)) {
				NSLog(@"Error sending to server: %d, %d", errno, (int)sentLen);
				error = true;
				[traceTTLLog appendFormat:@"* "];
			}
			
			long res = 0;
			//从（已连接）套接口上接收数据，并捕获数据发送源的地址。
			if (-1 == fcntl(recv_sock, F_SETFL, O_NONBLOCK)) {
				[self.results addObject:[NSString stringWithFormat:@"fcntl socket error!"]];
				if (self.traceRouteCompletion) self.traceRouteCompletion(self, NO);
				return;
			}
			/* set recvfrom from server timeout */
			struct timeval tv;
			fd_set readfds;
			tv.tv_sec = 1;
			tv.tv_usec = 0;  //设置了1s的延迟
			FD_ZERO(&readfds);
			FD_SET(recv_sock, &readfds);
			select(recv_sock + 1, &readfds, NULL, NULL, &tv);
			if (FD_ISSET(recv_sock, &readfds) > 0) {
				timeoutTTL = 0;
				if ((res = recvfrom(recv_sock, buf, 100, 0, (struct sockaddr *)&fromAddr, &n)) <
					0) {
					error = true;
					[traceTTLLog appendFormat:@"%s ", strerror(errno)];
				} else {
					icmp = true;
					delta = PLVTimeIntervalSinceMicroseconds(startTime);
					
					//将“二进制整数” －> “点分十进制，获取hostAddress和hostName
					if (fromAddr.sa_family == AF_INET) {
						char display[INET_ADDRSTRLEN] = {0};
						inet_ntop(AF_INET, &((struct sockaddr_in *)&fromAddr)->sin_addr.s_addr, display, sizeof(display));
						hostAddress = [NSString stringWithFormat:@"%s", display];
					}
					
					else if (fromAddr.sa_family == AF_INET6) {
						char ip[INET6_ADDRSTRLEN];
						inet_ntop(AF_INET6, &((struct sockaddr_in6 *)&fromAddr)->sin6_addr, ip, INET6_ADDRSTRLEN);
						hostAddress = [NSString stringWithUTF8String:ip];
					}
					
					if (try == 0) {
						// ip 字段
						[traceTTLLog appendFormat:@"%@ ", hostAddress];
					}
					[traceTTLLog appendFormat:@"%0.2fms ", (float)delta / 1000];
				}
			} else {
				timeoutTTL++;
				break;
			}
			
			if (!self.running) {
				ttl = self.maxTTL;
				// On force le statut d'icmp pour ne pas générer un Hop en sortie de boucle;
				icmp = true;
				break;
			}
		}
		
		//输出报文,如果三次都无法监控接收到报文，跳转结束
		if (icmp) {
			// 拼接字符串
			[self.results addObject:traceTTLLog.copy];
			//[self.delegate appendRouteLog:traceTTLLog];
		} else {
			//如果连续三次接收不到icmp回显报文
			if (timeoutTTL >= 4) {
				break;
			} else {
				// 拼接字符串
				[self.results addObject:[NSString stringWithFormat:@"********"]];
			}
		}
		
		if ([hostAddress isEqualToString:ipAddr0]) {
			break;
		}
		ttl++;
	}
	
	self.running = NO;
	// On averti le delegate que le traceroute est terminé.
	// 结束
	if (self.traceRouteCompletion) self.traceRouteCompletion(self, error);
}

/// 停止traceroute
- (void)stopTroute{
	self.running = NO;
}

@end
