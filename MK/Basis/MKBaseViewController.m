//
//  MKBaseViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/8.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKBaseViewController.h"
#import <objc/runtime.h>

@interface MKBaseViewController ()

@end

@implementation MKBaseViewController

+(void)initialize
{
    if (self == NSClassFromString(@"HXBaseViewController")){
    }
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (nil != self){
        //nib file...
    }
    return self;
}

#pragma mark --- 析构方法
-(void)dealloc
{
    //获取当前类下的全部子类
    NSArray * childClassArray = [self findCurrenViewControllerAllSubClass:[self class]];
    NSString * subClassName = [NSString stringWithCString:object_getClassName([childClassArray lastObject]) encoding:NSUTF8StringEncoding];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    MKLog(@"subClass --%@ is dealloc...",subClassName);
}

#pragma mark --- life cycle method

- (void)viewDidLoad
{
    [super viewDidLoad];
    //fixed
//    self.automaticallyAdjustsScrollViewInsets = NO;
    //background color...
//    self.view.backgroundColor=UIColorFromRGB_0x(0xf7f7f7);
//    if (UIScreen.mainScreen.bounds.size  CGSizeMake(828, 1792)) {
//
//    }
    
    
    //add navigation item...
//    [self pr_addNavigationBarLeftItemDefaultBackImageItem];
    
}

//Back to previous
- (void)pb_backToPreviousViewController
{
    if (self.navigationController.presentingViewController){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//Dismiss to Pervious
- (void)pb_dismissToPreviousViewController
{
    if (self.navigationController.presentingViewController){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//remove left item
-(void)pb_removeNavigationBarLeftBarButtonItems
{
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
}

-(void)pb_setLeftNavigationBarItemControlWithImage:(UIImage *)imageName
{
    UIImage * leftImageName = imageName ? : [UIImage imageNamed:@"login_back_images"];
    UIBarButtonItem * leftBtnItem = self.navigationItem.leftBarButtonItem;
    if (leftBtnItem)
    {
        if ([leftBtnItem.customView isKindOfClass:[UIButton class]]){
            [(UIButton*)leftBtnItem.customView setImage:leftImageName forState:UIControlStateNormal];
        }
    }else
    {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setFrame:CGRectMake(0, 0, leftImageName.size.width, 40)];
        [backBtn setImage:leftImageName forState:UIControlStateNormal];
        [backBtn setShowsTouchWhenHighlighted:NO];
        [backBtn addTarget:self action:@selector(pb_backToPreviousViewController) forControlEvents:UIControlEventTouchUpInside];
        if (_ios11_0_){
            [backBtn setFrame:CGRectMake(0, 0, 40, 40)];
            backBtn.contentEdgeInsets=UIEdgeInsetsMake(0, -10, 0, 10);
        }
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = item;
    }
}

-(void)pb_setNavigationTitleView:(NSString *)title setRightView:(BOOL)right withRightTitle:(NSString *)rightTitle
{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    titleLabel.text = title;
    titleLabel.font = K_Font_Nav_TitleFont;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = UIColorFromRGB_0x(0x4c4c4c);
    self.navigationItem.titleView = titleLabel;
    
    if (right){
        UIButton *btRight = [UIButton buttonWithType:UIButtonTypeCustom];
        btRight.frame = CGRectMake(0, 0, 65, 44);
        [btRight setTitle:rightTitle forState:UIControlStateNormal];
        [btRight setTitleColor:UIColorFromRGB_0x(0x4c4c4c)
                      forState:UIControlStateNormal];
        btRight.titleLabel.font = K_Font_Nav_RightTextFont;
        [btRight addTarget:self action:@selector(pb_handleRightBarButtonItem:) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btRight];
    }
}

//window current viewController...
- (UIViewController *)pb_getCurrentViewController
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self pr_getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

#pragma mark --- prvite method
//current viewcontroller index...
-(BOOL)pr_isRootViewControllerWithCurrentViewController
{
    return  [self.navigationController.viewControllers indexOfObject:self] > 0;
}

//-(void)pr_addNavigationBarLeftItemDefaultBackImageItem
//{
//    if(isDefaultItemBool && [self pr_isRootViewControllerWithCurrentViewController]){
//        if (self.navigationItem.leftBarButtonItem == nil){
//            //navigation item button...
//            UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            UIImage *image = [UIImage imageNamed:@"backImages"];
//            [backBtn setFrame:CGRectMake(0, 0, image.size.width, 40)];
//            [backBtn setImage:image forState:UIControlStateNormal];
//            [backBtn setShowsTouchWhenHighlighted:NO];
//            [backBtn addTarget:self action:@selector(pb_backToPreviousViewController) forControlEvents:UIControlEventTouchUpInside];
//            if (_ios11_0_){
//                [backBtn setFrame:CGRectMake(0, 0, 40, 40)];
//                backBtn.contentEdgeInsets=UIEdgeInsetsMake(0, -10, 0, 10);
//            }
//            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//            self.navigationItem.leftBarButtonItem = item;
//        }
//    }
//}

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

- (UIViewController *)pr_getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]){
        //视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]){
        //根视图为UITabBarController
        currentVC = [self pr_getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        //根视图为UINavigationController
        currentVC = [self pr_getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else{
        //根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

#pragma mark --- 遵循全屏手势处理事件的手势协议

-(BOOL)isAllowPopGestureShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}


@end
