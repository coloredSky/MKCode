//
//  JapanDateManager.h
//  MK
//
//  Created by ginluck on 2019/6/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JapanDateManager : NSObject

+(void)callBackUpdateJapanDateWithArrive_jp:(NSString *)arrive_jp mobile:(NSString *)mobile mobile_jp:(NSString *)mobile_jp completionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;

@end

NS_ASSUME_NONNULL_END
