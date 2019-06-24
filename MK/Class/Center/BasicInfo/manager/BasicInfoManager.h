//
//  BasicInfoManager.h
//  MK
//
//  Created by ginluck on 2019/6/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasicInfoManager : NSObject

+(void)callBackUpdateBasicInfoWithHudShow:(BOOL)hudShow lastname:(NSString *)lastname firstname:(NSString *)firstname lastkana:(NSString *)lastkana firstkana:(NSString * )firstkana mobile:(NSString *)mobile mobile_jp:(NSString *)model_jp email:(NSString *)email weixin:(NSString *)weixin qq:(NSString *)qq province:(NSString *)province city:(NSString *)city  CompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;

@end

NS_ASSUME_NONNULL_END
