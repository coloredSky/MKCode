//
//  UserManager.h
//  MK
//
//  Created by ginluck on 2019/4/19.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"
NS_ASSUME_NONNULL_BEGIN
//Documents目录路径
#define kSandBoxDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//用户对象归档路径
#define kUserPath [kSandBoxDocumentPath stringByAppendingPathComponent:@"user"]
#define kUserIdKey @"userIdKey"
@interface UserManager : NSObject
+ (instancetype)shareInstance;

////用户
- (void)saveUser:(LoginModel *)user;
- (LoginModel *)getUser;
- (NSString *)getUserId;

- (void)saveToken:(NSString *)token;
- (NSString *)getToken;
@end

NS_ASSUME_NONNULL_END
