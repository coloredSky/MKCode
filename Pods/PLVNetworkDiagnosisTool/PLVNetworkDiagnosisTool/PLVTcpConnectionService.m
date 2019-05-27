//
//  PLVTcpConnectionService.m
//  Demo
//
//  Created by Bq Lin on 2017/12/29.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import "PLVTcpConnectionService.h"
#import "PLVDeviceNetworkUtil.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>

@interface PLVTcpConnectionService ()

@property (nonatomic, assign) NSInteger startTime;

@property (nonatomic, copy) NSString *host;
@property (nonatomic, assign) NSInteger port;
@property (nonatomic, assign) BOOL isIpv6;

@property (nonatomic, assign) CFSocketRef socket;

@property (nonatomic, copy) NSMutableString *result;

//监测是否有connect成功
@property (nonatomic, assign) BOOL isExistSuccess;

//当前执行次数
@property (nonatomic, assign) int connectCount;

@property (nonatomic, assign) NSInteger sumTime;

@property (nonatomic, copy) PLVTcpConnectResultBlock connectCompletion;

@end

@implementation PLVTcpConnectionService

- (NSMutableString *)result {
	if (!_result) {
		_result = [NSMutableString string];
	}
	return _result;
}

- (instancetype)init {
	if (self = [super init]) {
		_maxConnectCount = 3;
	}
	return self;
}

- (void)connectWithHost:(NSString *)host completion:(PLVTcpConnectResultBlock)completion {
	[self connectWithHost:host port:80 completion:completion];
}
- (void)connectWithHost:(NSString *)host port:(NSInteger)port completion:(PLVTcpConnectResultBlock)completion {
	// 维护变量
	self.connectCompletion = completion;
	self.host = host;
	self.port = port;
	BOOL isIpv6 = [host rangeOfString:@":"].location != NSNotFound;
	self.isIpv6 = isIpv6;
	self.startTime = PLVCurrentMicroseconds();
	self.isExistSuccess = NO;
	self.connectCount = 0;
	self.sumTime = 0;
	self.result = nil;
	
	// 开始连接
	[self connect];
	
	do {
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	} while (self.connectCount < self.maxConnectCount);
}

- (void)connect {
	NSData *addrData = nil;
	
	//设置地址
	if (self.isIpv6) {
		struct sockaddr_in6 nativeAddr6;
		memset(&nativeAddr6, 0, sizeof(nativeAddr6));
		nativeAddr6.sin6_len = sizeof(nativeAddr6);
		nativeAddr6.sin6_family = AF_INET6;
		nativeAddr6.sin6_port = htons(self.port);
		inet_pton(AF_INET6, self.host.UTF8String, &nativeAddr6.sin6_addr);
		addrData = [NSData dataWithBytes:&nativeAddr6 length:sizeof(nativeAddr6)];
	} else {
		struct sockaddr_in nativeAddr4;
		memset(&nativeAddr4, 0, sizeof(nativeAddr4));
		nativeAddr4.sin_len = sizeof(nativeAddr4);
		nativeAddr4.sin_family = AF_INET;
		nativeAddr4.sin_port = htons(self.port);
		inet_pton(AF_INET, self.host.UTF8String, &nativeAddr4.sin_addr.s_addr);
		addrData = [NSData dataWithBytes:&nativeAddr4 length:sizeof(nativeAddr4)];
	}
	
	if (addrData != nil) {
		[self connectWithAddress:addrData];
	}
}

- (void)connectWithAddress:(NSData *)addr {
	struct sockaddr *pSockAddr = (struct sockaddr *)[addr bytes];
	int addressFamily = pSockAddr->sa_family;
	
	//创建套接字
	CFSocketContext CTX = {0, (__bridge_retained void *)(self), NULL, NULL, NULL};
	self.socket = CFSocketCreate(kCFAllocatorDefault, addressFamily, SOCK_STREAM, IPPROTO_TCP,
							 kCFSocketConnectCallBack, TCPServerConnectCallBack, &CTX);
	
	// 执行连接
	CFSocketConnectToAddress(self.socket, (__bridge CFDataRef)addr, 3);
	// 获取当前运行循环
	CFRunLoopRef currentRunLoop = CFRunLoopGetCurrent();
	// 定义循环对象
	CFRunLoopSourceRef source = CFSocketCreateRunLoopSource(kCFAllocatorDefault, self.socket, self.connectCount);
	// 将循环对象加入当前循环中
	CFRunLoopAddSource(currentRunLoop, source, kCFRunLoopDefaultMode);
	CFRelease(source);
}


/// 连接回调函数
static void TCPServerConnectCallBack(CFSocketRef socket, CFSocketCallBackType type, CFDataRef address, const void *data, void *info) {
	if (data != NULL) {
		printf("connect");
		PLVTcpConnectionService *manager = (__bridge_transfer PLVTcpConnectionService *)info;
		[manager readStream:NO];
	} else {
		PLVTcpConnectionService *manager = (__bridge_transfer PLVTcpConnectionService *)info;
		[manager readStream:YES];
	}
}

- (void)readStream:(BOOL)success {
	if (success) {
		self.isExistSuccess = YES;
		NSInteger interval = PLVTimeIntervalSinceMicroseconds(self.startTime);
		self.sumTime += interval;
		//NSLog(@"connect success %ld", interval);
		NSTimeInterval msInterval = interval / 1000.0;
		[self.result appendFormat:@"%d's time=%.3fms, ", self.connectCount + 1, msInterval];
	} else {
		self.sumTime = 99999;
		[self.result appendFormat:@"%d's time=TimeOut, ", self.connectCount + 1];
	}
	if (self.connectCount == self.maxConnectCount - 1) {
		if (self.sumTime >= 99999) {
			self.result = [self.result substringToIndex:[self.result length] - 1].mutableCopy;
		} else {
			NSTimeInterval averageInterval = self.sumTime / self.maxConnectCount / 1000.0;
			[self.result appendFormat:@"average=%.3fms", averageInterval];
		}
	}
	
	CFRelease(self.socket);
	self.connectCount++;
	if (self.connectCount < self.maxConnectCount) {
		self.startTime = PLVCurrentMicroseconds();
		[self connect];
	} else {
		if (self.connectCompletion) self.connectCompletion(self, self.result, self.isExistSuccess);
	}
}

@end
