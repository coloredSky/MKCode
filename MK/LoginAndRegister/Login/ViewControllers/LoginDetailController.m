//
//  LoginDetailController.m
//  MK
//
//  Created by ginluck on 2019/3/26.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "LoginDetailController.h"
#import "RegisterController.h"
#import "LoginActionController.h"
@interface LoginDetailController ()

@end

@implementation LoginDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)btnClick:(UIButton * )sender
{
    switch (sender.tag) {
        case 0:
        {
            //注册
            RegisterController * rvc =[RegisterController new];
            [self presentViewController:rvc animated:NO completion:nil];
        }
            break;
        case 1:
        {
            //skip
        }
            break;
        case 2:
        {
           //登录
            LoginActionController * lvc =[LoginActionController new];
            [self presentViewController:lvc animated:NO completion:nil];
        }
            break;
            
        default:
            break;
    }
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
