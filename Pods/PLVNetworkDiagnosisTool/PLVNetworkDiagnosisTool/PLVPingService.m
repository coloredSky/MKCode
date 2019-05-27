//
//  PLVPingService.m
//  Demo
//
//  Created by Bq Lin on 2018/1/12.
//  Copyright © 2018年 POLYV. All rights reserved.
//

#import "PLVPingService.h"
#import "PLVDeviceNetworkUtil.h"
#import "PLVSimplePing.h"
#import <sys/socket.h>
#import <netdb.h>

#define MAXCOUNT_PING 4

@interface PLVPingService ()<PLVSimplePingDelegate>

@property (nonatomic, strong) PLVSimplePing *pinger;

@property (nonatomic, copy) NSString *hostName;
@property (nonatomic, copy) NSString *hostIp;
@property (nonatomic, assign) NSInteger startTime;
@property (nonatomic, assign) NSInteger pingCount;
@property (nonatomic, copy) NSMutableString *result;

@property (nonatomic, strong) NSMutableArray<NSNumber *> *intervals;
@property (nonatomic, assign) NSTimeInterval averageInterval;

@property (nonatomic, copy) PLVPingResultBlock pingCompletion;

@end

@implementation PLVPingService

#pragma mark - property

- (NSMutableArray *)intervals {
	if (!_intervals) {
		_intervals = [NSMutableArray array];
	}
	return _intervals;
}

- (NSMutableString *)result {
	if (!_result) {
		_result = [NSMutableString string];
	}
	return _result;
}

#pragma mark - init

- (instancetype)init {
	if (self = [super init]) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	_maxPingCount = 4;
}

- (void)pingWithHost:(NSString *)host completion:(PLVPingResultBlock)completion {
	self.pingCompletion = completion;
	self.pingCount = 0;
	self.hostName = host;
	BOOL forceIPv4 = YES;
	BOOL forceIPv6 = NO;
	
	PLVSimplePing *pinger = [[PLVSimplePing alloc] initWithHostName:self.hostName];
	self.pinger = pinger;
	
	// By default we use the first IP address we get back from host resolution (.Any)
	// but these flags let the user override that.
	
	if (forceIPv4 && !forceIPv6) {
		pinger.addressStyle = PLVSimplePingAddressStyleICMPv4;
	} else if (forceIPv6 && !forceIPv4) {
		pinger.addressStyle = PLVSimplePingAddressStyleICMPv6;
	}
	
	pinger.delegate = self;
	[pinger start];
}

/// 发送ping指令
- (void)sendPing {
	//NSLog(@"ping count: %zd", self.pingCount);
	if (self.pingCount >= self.maxPingCount) {
		[self stop];
		return;
	}
	self.startTime = PLVCurrentMicroseconds();
	[self.pinger sendPingWithData:nil];
	[self performSelector:@selector(timeout) withObject:nil afterDelay:3.0];
}

- (void)stop {
	self.averageInterval = [[self.intervals valueForKeyPath:@"@avg.doubleValue"] doubleValue];
	[self.result appendFormat:@"average interval=%.3f ms", self.averageInterval];
	
	[self clean];
}

- (void)clean {
	if (self.pingCompletion) self.pingCompletion(self, self.result);
	
	[self.pinger stop];
	self.pinger = nil;
	
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(timeout) object:nil];
	
	self.hostName = nil;
	self.startTime = -1;
	self.pingCompletion = nil;
	self.intervals = nil;
	self.averageInterval = 0;
	self.result = nil;
}

- (void)timeout {
	[self.result appendFormat:@"ping timeout"];
	[self clean];
}

- (void)fail {
	[self clean];
}


#pragma mark - PLVSimplePingDelegate

- (void)simplePing:(PLVSimplePing *)pinger didStartWithAddress:(NSData *)address {
	self.hostIp = [self.class displayAddressForAddress:address];
	//NSLog(@"start ping %@ (%@)", self.hostName, self.hostIp);
	[self.result appendFormat:@"ping %@ (%@): ", self.hostName, self.hostIp];
	[self sendPing];
}

- (void)simplePing:(PLVSimplePing *)pinger didFailWithError:(NSError *)error {
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(timeout) object:nil];
	//NSLog(@"%@, ping error: %@", self.hostIp, error);
	[self.result appendFormat:@"ping error: %@, ", error.localizedDescription];
	[self fail];
}

- (void)simplePing:(PLVSimplePing *)pinger didSendPacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber {
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(timeout) object:nil];
	//NSLog(@"%@, #%hu send packet success", self.hostIp sequenceNumber);
}

- (void)simplePing:(PLVSimplePing *)pinger didFailToSendPacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber error:(NSError *)error {
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(timeout) object:nil];
	//NSLog(@"%@, #%hu send failed: %@", self.hostIp, sequenceNumber, [self.class shortErrorFromError:error]);
	[self.result appendFormat:@"%d's send failed: %@, ", sequenceNumber+1, [self.class shortErrorFromError:error]];
	[self clean];
}

- (void)simplePing:(PLVSimplePing *)pinger didReceivePingResponsePacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber {
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(timeout) object:nil];
	NSTimeInterval interval = PLVTimeIntervalSinceMicroseconds(self.startTime) / 1000.0;
	[self.intervals addObject:@(interval)];
	//NSLog(@"%lu bytes from %@: icmp_seq=%hu time=%.3f ms", packet.length, self.hostIp, sequenceNumber, interval);
	[self.result appendFormat:@"%d's interval=%.3f ms, ", sequenceNumber+1, interval];
	self.pingCount ++;
	[self sendPing];
}

- (void)simplePing:(PLVSimplePing *)pinger didReceiveUnexpectedPacket:(NSData *)packet {
	//NSLog(@"%s - %@", __FUNCTION__, [NSThread currentThread]);
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(timeout) object:nil];
	[self.result appendString:@"receive unexpected packet"];
	[self clean];
	self.pingCount ++;
}

#pragma mark - Utils

+ (NSString *)icmpEchoTypeNameWithType:(NSInteger)type {
	switch (type) {
		case ICMPv4TypeEchoRequest:{
			return @"ICMPv4TypeEchoRequest";
		}break;
		case ICMPv4TypeEchoReply:{
			return @"ICMPv4TypeEchoReply";
		}break;
		case ICMPv6TypeEchoRequest:{
			return @"ICMPv6TypeEchoRequest";
		}break;
		case ICMPv6TypeEchoReply:{
			return @"ICMPv6TypeEchoReply";
		}break;
		default:{
			return nil;
		}break;
	}
}

/*! Returns the string representation of the supplied address.
 *  \param address Contains a (struct sockaddr) with the address to render.
 *  \returns A string representation of that address.
 */

+ (NSString *)displayAddressForAddress:(NSData *)address {
	int err;
	NSString *result;
	char hostStr[NI_MAXHOST];
	result = nil;
	
	if (address != nil) {
		err = getnameinfo(address.bytes, (socklen_t) address.length, hostStr, sizeof(hostStr), NULL, 0, NI_NUMERICHOST);
		if (err == 0) {
			result = @(hostStr);
		}
	}
	if (result == nil) {
		result = @"?";
	}
	return result;
}

/*! Returns a short error string for the supplied error.
 *  \param error The error to render.
 *  \returns A short string representing that error.
 */

+ (NSString *)shortErrorFromError:(NSError *)error {
	NSString *result;
	NSNumber *failureNum;
	int failure;
	const char* failureStr;
	assert(error != nil);
	result = nil;
	
	// Handle DNS errors as a special case.
	if ( [error.domain isEqual:(NSString *)kCFErrorDomainCFNetwork] && (error.code == kCFHostErrorUnknown) ) {
		failureNum = error.userInfo[(id) kCFGetAddrInfoFailureKey];
		if ( [failureNum isKindOfClass:[NSNumber class]] ) {
			failure = failureNum.intValue;
			if (failure != 0) {
				failureStr = gai_strerror(failure);
				if (failureStr != NULL) {
					result = @(failureStr);
				}
			}
		}
	}
	
	// Otherwise try various properties of the error object.
	if (result == nil) {
		result = error.localizedFailureReason;
	}
	if (result == nil) {
		result = error.localizedDescription;
	}
	assert(result != nil);
	return result;
}

@end
