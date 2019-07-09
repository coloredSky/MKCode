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


#pragma mark --- 析构方法
-(void)dealloc
{
    //获取当前类下的全部子类
    NSArray * childClassArray = [self findCurrenViewControllerAllSubClass:[self class]];
    NSString * subClassName = [NSString stringWithCString:object_getClassName([childClassArray lastObject]) encoding:NSUTF8StringEncoding];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    MKLog(@"subClass --%@ is dealloc...",subClassName);
}

-(nonnull NSArray<UIViewController*>*)findCurrenViewControllerAllSubClass:(Class)defaultsClass
{
    int count = objc_getClassList(NULL, 0);
    if (count <= 0){
        return [NSArray arrayWithObject:defaultsClass];
    }
    NSMutableArray * mutabArray = [NSMutableArray arrayWithObject:defaultsClass];
    Class * classes = (Class*)malloc(sizeof(Class) * count);
    objc_getClassList(classes, count);
    //获取子类对象
    for (int i =0; i< count; ++i){
        if (defaultsClass == class_getSuperclass(classes[i])){
            [mutabArray addObject:classes[i]];
        }
    }
    free(classes);
    return [NSArray arrayWithArray:mutabArray];
}

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


#pragma mark - 控制屏幕旋转方法
- (BOOL)shouldAutorotate{
    return [[self.viewControllers lastObject]shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [[self.viewControllers lastObject]supportedInterfaceOrientations];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}


@end
