//
//  AppDelegate.h
//  MK
//
//  Created by 周洋 on 2019/3/8.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


/**
 得到 appdelegate

 @return appdelegate
 */
+(AppDelegate*)instance;

/**
 登录界面弹出
 */
-(void)pb_presentShowLoginViewController;

@end

