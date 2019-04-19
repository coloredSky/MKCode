//
//  ViewControllerManager.m
//  XinJiangTaxiProject
//
//  Created by he on 2017/7/11.
//  Copyright © 2017年 HeXiulian. All rights reserved.
//

#import "ViewControllerManager.h"
#import "AppDelegate.h"
#import "LoginActionController.h"
//#import "BCXNewFeatureController.h"
#import "MKTarbarViewController.h"
//#import "LoginController.h"
@implementation ViewControllerManager
//
//static id instance = nil;
//
//+ (instancetype)shareInstance{
//    
//    if (!instance) {
//        instance =  [[ViewControllerManager alloc]init];
//    }
//    
//    return instance;
//}
//
//+(instancetype)allocWithZone:(struct _NSZone *)zone{
//    if (!instance) {
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            instance = [super allocWithZone:zone];
//        });
//    }
//    return instance;
//}

+ (void)showLoginViewController
{
    AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
    
    if (app.window.rootViewController)
    {
        LoginActionController *lVC = [LoginActionController new];

        UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:lVC];

        [app.window.rootViewController presentViewController: navC animated:NO completion:nil];
    }
}

+ (void)showMainViewController
{
    AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
    
    if (app.window.rootViewController)
    {
        MKTarbarViewController *tabVC = [MKTarbarViewController new];

        app.window.rootViewController = tabVC ;
    }
}

+ (void)showIndexViewController
{    
//    AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
//    
//    if (app.window.rootViewController)
//    {
//        BCXNewFeatureController *indexVC = [[BCXNewFeatureController alloc] init];
//
//        app.window.rootViewController = indexVC ;
//    }
}

@end
