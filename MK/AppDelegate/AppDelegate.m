//
//  AppDelegate.m
//  MK
//
//  Created by 周洋 on 2019/3/8.
//  Copyright © 2019年 周洋. All rights reserved.
//
#import "AppDelegate.h"
#import "MKTarbarViewController.h"
#import "LoginActionController.h"
#import "MKNavigationController.h"
//键盘
#import "IQKeyboardManager.h"
#import <PLVVodSDK/PLVVodSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self MKAppConfig];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MKTarbarViewController *mkTarbarVC = [MKTarbarViewController new];
    self.window.rootViewController = mkTarbarVC;
    [self.window makeKeyAndVisible];

    [self MKAppConfig];
   // [ViewControllerManager showMainViewController];

    return YES;
}

-(void)MKAppConfig
{
    [self configKeyboard];//键盘
    [self polyvVideoPlayConfig];//第三方播放视频
}

-(void)polyvVideoPlayConfig
{
    NSError *error = nil;
    NSString *vodKey = @"n0U70JWs5/Y8JfJ19sDvmG77hSjMcndG2lopb/5Bw4a6ZS118jiETAcQXWka5u0dSGHCPYrtjKcKNTnrMN32/Zazjxb70wG6sqDKlDCjiz270R53o6i22OPDaHthdSmNiAzjg+thN+YhOyj/etPN7Q==";
    NSString *decodeKey = @"CBm2slFGXpCLXsgq";
    NSString *decodeIv = @"vXsHPN3fodcWqQ6u";
    [PLVVodSettings settingsWithConfigString:vodKey key:decodeKey iv:decodeIv error:&error];
}

- (void)configKeyboard{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarByPosition; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:14]; // 设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



+(AppDelegate*)instance
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

-(void)pb_presentShowLoginViewController
{
    @synchronized (self){
        if (![self pb_isHasShowLoginViewController]){
            LoginActionController * loginVC = [[LoginActionController alloc]init];
            MKNavigationController * navigationVC = [[MKNavigationController alloc]initWithRootViewController:loginVC];
            if (self.window.rootViewController.presentedViewController != nil){
                [self.window.rootViewController.presentedViewController presentViewController:navigationVC animated:YES completion:nil];
            }else{
                [self.window.rootViewController presentViewController:navigationVC animated:YES completion:nil];
            }
        }
    }
}

-(void)pb_pushLoginViewController
{
    @synchronized (self){
        if (![self pb_isHasShowLoginViewController]){
            LoginActionController * loginVC = [[LoginActionController alloc]init];
            UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
            UINavigationController *currentNav = tabBarController.selectedViewController;
            [currentNav pushViewController:loginVC animated:YES];
        }
    }
}

-(BOOL)pb_isHasShowLoginViewController
{
    UINavigationController * navigationVC = nil;
    if (self.window.rootViewController.presentedViewController != nil){
        navigationVC = (UINavigationController*)self.window.rootViewController.presentedViewController;
    }else{
        navigationVC = (UINavigationController *)self.window.rootViewController;
    }
    if ([navigationVC isKindOfClass:[UINavigationController class]]){
        return [[navigationVC.viewControllers firstObject] isKindOfClass:[UIViewController class]];
    }
    else{
        return NO;
    }
}
    



@end
