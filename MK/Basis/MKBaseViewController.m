//
//  MKBaseViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/8.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKBaseViewController.h"
#import <objc/runtime.h>
#import "LoginActionController.h"

@interface MKBaseViewController ()

@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation MKBaseViewController

+(void)initialize
{
    if (self == NSClassFromString(@"MKBaseViewController")){
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //fixed
    self.automaticallyAdjustsScrollViewInsets = NO;
    //background color...
    self.view.backgroundColor = K_BG_deepGrayColor;
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

-(void)loginAlterViewShow
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还未登录？请登录" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        LoginActionController *loginVC = [LoginActionController new];
        [strongSelf.navigationController pushViewController:loginVC animated:YES];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancleAction];
    [alert addAction:sureAction];
}

-(void)loginOutAlterViewShow
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要退出登录？" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
//    __weak typeof(self) weakSelf = self;
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:NO forKey:KMKLoginKey];
        [userDefaults synchronize];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancleAction];
    [alert addAction:sureAction];
}
@end
