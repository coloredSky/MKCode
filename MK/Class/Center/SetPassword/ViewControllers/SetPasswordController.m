//
//  SetPasswordController.m
//  MK
//
//  Created by ginluck on 2019/3/19.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "SetPasswordController.h"
#import "SetPasswordManager.h"
@interface SetPasswordController ()
@property(weak,nonatomic)IBOutlet UITextField * oldPwdTf;
@property(weak,nonatomic)IBOutlet UITextField * pwdTf;//密码
@property(weak,nonatomic)IBOutlet UITextField * cPwdTf;//确认密码
@end

@implementation SetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark-event
-(IBAction)saveClick:(UIButton* )sender
{
    if (![self.pwdTf.text  isEqualToString:self.cPwdTf.text])
    {
        [MBHUDManager showBriefAlert:@"密码与确认密码不一致！"];
    }
    [SetPasswordManager callBackSetPwdWithHudShow:YES oldPwd:self.oldPwdTf.text newPwd:self.pwdTf.text CompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message) {
        if (isSuccess==YES)
        {
            [MBHUDManager showBriefAlert:message];
        }
        else
        {
            [MBHUDManager showBriefAlert:message];
        }
    }];
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
