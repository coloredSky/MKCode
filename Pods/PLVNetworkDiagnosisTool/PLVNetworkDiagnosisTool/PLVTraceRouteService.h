//
//  PLVTraceRouteService.h
//  Demo
//
//  Created by Bq Lin on 2018/1/12.
//  Copyright © 2018年 POLYV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLVTraceRouteService : NSObject

/// UDP 执行端口
@property (nonatomic, assign) NSInteger udpPort;

/// 执行转数
@property (nonatomic, assign) NSInteger maxTTL;

/// 每次发送时间的timeout
@property (nonatomic, assign) NSInteger readTimeout;

/// 每转的发送次数
@property (nonatomic, assign) NSInteger maxAttempts;

/// 是否正在运行
@property (nonatomic, assign) BOOL running;

@property (nonatomic, strong, readonly) NSMutableArray<NSString *> *results;

@property (nonatomic, copy) void (^traceRouteCompletion)(PLVTraceRouteService *tranceRouteService, BOOL success);

/// 开始 tranceroute，会阻塞线程
- (void)traceRoute:(NSString *)host;

@end
