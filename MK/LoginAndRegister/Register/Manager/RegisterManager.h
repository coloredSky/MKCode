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
@end

NS_ASSUME_NONNULL_END
