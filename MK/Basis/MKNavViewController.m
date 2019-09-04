//
//  MKNavViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/18.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKNavViewController.h"

@interface MKNavViewController ()

@end

@implementation MKNavViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutNavView];
}

-(void)layoutNavView
{
    if([self pr_isRootViewControllerWithCurrentViewController]){
        if (self.navigationItem.rightBarButtonItem == nil){
            //navigation item button...
            UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *image = [UIImage imageNamed:@"navBack_black_image"];
            [backBtn setFrame:CGRectMake(0, 0, image.size.width, 40)];
            [backBtn setImage:image forState:UIControlStateNormal];
            [backBtn setShowsTouchWhenHighlighted:NO];
            [backBtn addTarget:self action:@selector(backToPreviousViewController) forControlEvents:UIControlEventTouchUpInside];
            if (K_ios11_0_){
                [backBtn setFrame:CGRectMake(0, 0, 40, 40)];
                backBtn.contentEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 0);
            }
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
            self.navigationItem.rightBarButtonItem = item;
        }
    }
}

//current viewcontroller index...
-(BOOL)pr_isRootViewControllerWithCurrentViewController
{
    if ([NSStringFromClass(self.class) isEqualToString:@"LoginActionController"]) {
        return YES;
    }
    return  [self.navigationController.viewControllers indexOfObject:self] > 0;
}

#pragma mark --  EVENT
-(void)backToPreviousViewController
{
    if (self.navigationController.presentingViewController){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
