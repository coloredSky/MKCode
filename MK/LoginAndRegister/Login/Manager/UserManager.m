//
//  UserManager.m
//  MK
//
//  Created by ginluck on 2019/4/19.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager
static id instance = nil;

+ (instancetype)shareInstance{
    
    if (!instance) {
        instance =  [[UserManager alloc]init];
    }
    return instance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    if (!instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [super allocWithZone:zone];
        });
    }
    return instance;
}

#pragma mark - user
- (void)saveUser:(LoginModel *)user{
    
    MKLog(@"%@",kUserPath);
    LoginModel *user1 = [self getUser];
    if ([user1.id isEqualToString:user.id]) {
        user.username = user1.username;
    }
    if (user) {
        [NSKeyedArchiver archiveRootObject:user toFile:kUserPath];
        [self saveUserId:user.id];
    }else{
        [self removeUser];
    }
}

-(BOOL )isLogin
{
    NSString *userId =   [[UserManager shareInstance]getUserId];
    if ([NSString isEmptyWithStr:userId]) {
        return NO;
    }
    return YES;
}

- (LoginModel *)getUser{
    LoginModel *user = [NSKeyedUnarchiver unarchiveObjectWithFile:kUserPath];
    return user;
}

- (void)removeUser{
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:kUserPath error:&error];
    if (error) {
        MKLog(@"%@",error.description);
    }
}

- (NSString *)getUserId{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kUserIdKey];
}

-(void)removeToken
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserIdKey];
}

- (void)saveUserId:(NSString *)userId{
    if (userId != nil) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:userId forKey:kUserIdKey];
        [defaults synchronize];
    }else{
        [self removeUserId];
    }
}

- (void)removeUserId{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kUserIdKey];
    [defaults synchronize];
}

///token
- (void)saveToken:(NSString *)token{
    if (token != nil) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:token forKey:@"kTOKEN"];
        [defaults synchronize];
    }else{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"kTOKEN"];
        [defaults synchronize];
    }
    
}
- (NSString *)getToken{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"kTOKEN"];
}

-(void)loginOut
{
    [self removeUser];
    [self removeToken];
    [self removeUserId];
}
@end
