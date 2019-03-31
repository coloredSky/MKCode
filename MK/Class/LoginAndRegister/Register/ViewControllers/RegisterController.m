//
//  RegisterController.m
//  MK
//
//  Created by ginluck on 2019/3/26.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "RegisterController.h"

@interface RegisterController ()
@property(nonatomic,weak)IBOutlet UITextField * phoneTextfield;
@property(nonatomic,weak)IBOutlet UITextField * codeTextfield;
@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)btnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
            //返回
            [self dismissViewControllerAnimated:NO completion:nil];
        }
            break;
        case 1:
        {
            //获取验证码
        }
            break;
        case 2:
        {
            //注册
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
