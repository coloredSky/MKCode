//
//  MKTarbarViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/11.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKTarbarViewController.h"
//controllers
#import "HomePageViewController.h"
#import "DiscoverPageViewController.h"
#import "AppointmentViewController.h"
#import "MyCouseViewController.h"
#import "MyCenterViewController.h"
//Nav
#import "MKNavigationController.h"

@interface MKTarbarViewController ()

@end

@implementation MKTarbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.delegate=self;
    self.tabBar.backgroundColor=[UIColor whiteColor];
    self.tabBar.barTintColor=[UIColor whiteColor];
    [self configTabbar];
}
-(void)configTabbar
{
    NSArray *titleArr = @[@"首页",@"发现",@"预约",@"课程",@"我的"];
    NSArray *normalIconArr = @[@"home_normal_Icon",@"discover_normal_Icon",@"appoinment_normal_Icon",@"class_normal_Icon",@"center_normal_Icon"];
    NSArray *selectedIconArr = @[@"home_selected_Icon",@"dicover_selected_Icon",@"appoinment_selected_Icon",@"class_selected_Icon",@"center_selected_Icon"];
    NSArray *subVCs = @[[HomePageViewController new],[DiscoverPageViewController new],[AppointmentViewController new],[MyCouseViewController new],[MyCenterViewController new]];
    NSMutableArray *navs = [NSMutableArray arrayWithCapacity:5];
    for (int i=0; i<titleArr.count; i++) {
        NSString *barTitle = titleArr[i];
        UIImage *barNormalImage = [UIImage imageNamed:normalIconArr[i]];
        UIImage *selectedNormalImage = [UIImage imageNamed:selectedIconArr[i]];
        UITabBarItem * tabBarItem = [[UITabBarItem alloc]initWithTitle:barTitle image:[self tabBarItemImage:barNormalImage] selectedImage:[self tabBarItemImage:selectedNormalImage]];
        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB_0x(0x000000)} forState:UIControlStateNormal];
        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB_0x(0xfe8219)} forState:UIControlStateSelected];
        UIViewController *subViewController = subVCs[i];
        subViewController.tabBarItem = tabBarItem;
        MKNavigationController *navController = [[MKNavigationController alloc]initWithRootViewController:subViewController];
        [navs addObject:navController];
    }
    self.viewControllers = navs;
}

-(UIImage*)tabBarItemImage:(UIImage *)image
{
    UIImage * tabBarImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return tabBarImage;
}


@end
