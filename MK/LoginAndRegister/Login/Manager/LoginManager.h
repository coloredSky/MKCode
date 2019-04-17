//
//  LoginManager.h
//  MK
//
//  Created by ginluck on 2019/4/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoginManager : NSObject
+(void)callBackLoginDataWith:(NSString *)userName pwd:(NSString *)pwd CompletionBlock:(void(^)(BOOL isSuccess,NSString *message, LoginModel *model))completionBlock;
@end

NS_ASSUME_NONNULL_END
