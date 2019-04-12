//
//  LoginActionController.m
//  MK
//
//  Created by ginluck on 2019/3/26.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "LoginActionController.h"
#import "RegisterController.h"
#import "MKTarbarViewController.h"
@interface LoginActionController ()

@end

@implementation LoginActionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)btnClick:(UIButton *)sender
{
    if (sender.tag ==1) {
          [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        //登录
        MKTarbarViewController *tarbarVC = [MKTarbarViewController new];
        [[UIApplication sharedApplication]keyWindow]. rootViewController = tarbarVC;
    }
  
}

- (IBAction)registerTarget:(id)sender {
    RegisterController *registerVC = [RegisterController new];
    [self.navigationController pushViewController:registerVC animated:YES];
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
