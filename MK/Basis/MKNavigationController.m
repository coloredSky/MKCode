//
//  MKNavigationController.m
//  MK
//
//  Created by 周洋 on 2019/3/8.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKNavigationController.h"

@interface MKNavigationController ()

@end

@implementation MKNavigationController

+(void)initialize
{
    //设置默认的导航栏
    UINavigationBar * navigationBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[MKNavigationController class]]];
    //设置背景颜色
    navigationBar.tintColor = [UIColor clearColor];
    navigationBar.translucent = YES;
    //导航栏的设置
//    NSDictionary * dict = [NSDictionary
//                           dictionaryWithObjectsAndKeys:[UIColor whiteColor],
//                           NSForegroundColorAttributeName,
//                           [UIFont fontWithName:MainFontName size:16.0],
//                           NSFontAttributeName, nil];
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //Test Code...
    [navigationBar setShadowImage:[UIImage new]];
    //Set up NavigationControllers attributes
//    [navigationBar setTitleTextAttributes:dict];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark --  nav-delegate
#pragma mark--- Push Viewcontrollers Animated
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count != 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
