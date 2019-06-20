//
//  RegisterManager.h
//  MK
//
//  Created by ginluck on 2019/4/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterManager : NSObject

//获取验证码
+(void)callBackPhoneCodeWithHudShow:(BOOL)hudShow phone:(NSString *)phone  CompletionBlock:(void(^)(BOOL isSuccess,NSString *message, NSString *code))completionBlock;


//注册
+(void)callBackRegisterWithHudShow:(BOOL)hudShow phone:(NSString *)phone code:(NSString *)code pwd:(NSString * )pwd CompletionBlock:(void(^)(BOOL isSuccess,NSString *message, NSString *status))completionBlock;


/**
 密码找回

 @param mobile 手机号
 @param code 验证码
 @param passwd 密码
 @param repasswd 重复密码
 @param completionBlock 回调
 */
+(void)callBackFindPasswordRequestWithMobile:(NSString * )mobile code:(NSString * )code passwd:(NSString * )passwd repasswd:(NSString * )repasswd andCompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;

@end

NS_ASSUME_NONNULL_END
