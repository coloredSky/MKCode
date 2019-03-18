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
    
}

@end
