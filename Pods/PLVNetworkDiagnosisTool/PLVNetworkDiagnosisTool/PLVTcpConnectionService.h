//
//  PLVTcpConnectionService.h
//  Demo
//
//  Created by Bq Lin on 2017/12/29.
//  Copyright © 2017年 POLYV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLVTcpConnectionService : NSObject

typedef void(^PLVTcpConnectResultBlock)(PLVTcpConnectionService *tcpConnect, NSString *result, BOOL success);

@property (nonatomic, assign) int maxConnectCount;

- (void)connectWithHost:(NSString *)host completion:(PLVTcpConnectResultBlock)completion;
- (void)connectWithHost:(NSString *)host port:(NSInteger)port completion:(PLVTcpConnectResultBlock)completion;

@end
