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
    if ([NSString isEmptyWithStr:self.oldPwdTf.text]){
        [MBHUDManager showBriefAlert:@"请输入旧密码！"];
        return;
    }
    if (self.oldPwdTf.text.length < 6 || self.oldPwdTf.text.length >16){
        [MBHUDManager showBriefAlert:@"密码为6到16位的字母或数字！"];
        return;
    }
    if ([NSString isEmptyWithStr:self.pwdTf.text]){
        [MBHUDManager showBriefAlert:@"请输入新密码！"];
        return;
    }
    if (self.pwdTf.text.length < 6 || self.pwdTf.text.length >16){
        [MBHUDManager showBriefAlert:@"请输入6到16位的新密码！"];
        return;
    }
    if ([NSString isEmptyWithStr:self.cPwdTf.text]){
        [MBHUDManager showBriefAlert:@"请再次输入新密码！"];
        return;
    }
    if (![self.pwdTf.text  isEqualToString:self.cPwdTf.text])
    {
        [MBHUDManager showBriefAlert:@"密码与确认密码不一致！"];
    }
    [SetPasswordManager callBackSetPwdWithHudShow:YES oldPwd:self.oldPwdTf.text newPwd:self.pwdTf.text CompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message) {
        if (isSuccess==YES)
        {
            [MBHUDManager showBriefAlert:@"密码修改成功，请重新登录！"];
            [[UserManager shareInstance] loginOut];
            [[WYNetworkConfig sharedConfig] addCustomHeader:@{@"Authorization":@""}];
            [[NSNotificationCenter defaultCenter]postNotificationName:kMKLoginOutNotifcationKey object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            [MBHUDManager showBriefAlert:message];
        }
    }];
}


@end
