//
//  SetPasswordManager.h
//  MK
//
//  Created by ginluck on 2019/6/13.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetPasswordManager : NSObject
+(void)callBackSetPwdWithHudShow:(BOOL)hudShow oldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd CompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;
@end

NS_ASSUME_NONNULL_END
