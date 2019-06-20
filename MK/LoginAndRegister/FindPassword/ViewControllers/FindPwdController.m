//
//  FindPwdController.m
//  MK
//
//  Created by ginluck on 2019/4/19.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "FindPwdController.h"
#import "UIButton+Countdown.h"
#import "RegisterManager.h"

@interface FindPwdController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgIma;
@property (weak, nonatomic) IBOutlet UILabel *titleSignLab;

@property (weak, nonatomic) IBOutlet UIButton *sendCodeBtn;
@property (weak, nonatomic) IBOutlet UILabel *codeSignLab;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@property (weak, nonatomic) IBOutlet UILabel *phoneSignLab;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (weak, nonatomic) IBOutlet UILabel *passwordSignLab;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation FindPwdController

-(void)dealloc
{
    [self.sendCodeBtn cancleDispatchSourceTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
}

-(void)configSubViews
{
    self.bgIma.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
    self.titleSignLab.attributedText = [self getAttributedStringWithString:@"Find Password" textFont:MKFont(30)];
    self.phoneSignLab.attributedText = [self getAttributedStringWithString:@"可接收验证码的手机号" textFont:MKBoldFont(15)];
    self.codeSignLab.attributedText = [self getAttributedStringWithString:@"验证码" textFont:MKBoldFont(15)];
    self.passwordSignLab.attributedText = [self getAttributedStringWithString:@"密码" textFont:MKBoldFont(15)];
}

-(NSAttributedString *)getAttributedStringWithString:(NSString *)signString textFont:(UIFont *)textFont
{
    NSShadow *signShadow = [[NSShadow alloc]init];
    signShadow.shadowColor =  [UIColor colorWithWhite:1 alpha:.8];
    signShadow.shadowBlurRadius = 3;
    signShadow.shadowOffset = CGSizeMake(1, 1);
    NSAttributedString *attributedString = [[NSAttributedString alloc]initWithString:signString attributes:@{NSShadowAttributeName : signShadow,NSFontAttributeName : textFont}];
    return attributedString;
}

#pragma mark --  验证码发送
- (IBAction)sendCodeHandleTarget:(UIButton *)sender {
    NSString *phoneString = [self.phoneTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([NSString isEmptyWithStr:phoneString]) {
        [MBHUDManager showBriefAlert:@"请输入手机号！"];
        return;
    }
    if (phoneString.length != 11) {
        [MBHUDManager showBriefAlert:@"请输入正确的手机号！"];
        return;
    }
    [MBHUDManager showLoading];
    [RegisterManager callBackPhoneCodeWithHudShow:NO phone:phoneString CompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message, NSString * _Nonnull code) {
        [MBHUDManager hideAlert];
        if (isSuccess) {
            [MBHUDManager showBriefAlert:@"验证码发送成功！"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender beginResumeCountdownFunction];
            });
        }else{
            if (![NSString isEmptyWithStr:message]) {
                [MBHUDManager showBriefAlert:message];
            }
        }
    }];
    
}

#pragma mark --  密码修改提交
- (IBAction)submitHandleTarget:(UIButton *)sender {
    //手机号
    NSString *phoneString = [self.phoneTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([NSString isEmptyWithStr:phoneString]) {
        [MBHUDManager showBriefAlert:@"请输入手机号！"];
        return;
    }
    if (phoneString.length != 11) {
        [MBHUDManager showBriefAlert:@"请输入正确的手机号！"];
        return;
    }
    //验证码
    NSString *codeString = [self.codeTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([NSString isEmptyWithStr:codeString]) {
        [MBHUDManager showBriefAlert:@"请输入验证码！"];
        return;
    }
    if (codeString.length < 4) {
        [MBHUDManager showBriefAlert:@"请输入正确的验证码！"];
        return;
    }
    //密码
    if ([NSString isEmptyWithStr:self.passwordTF.text]) {
        [MBHUDManager showBriefAlert:@"请输入密码！"];
        return;
    }
    if (self.passwordTF.text.length < 6 || self.passwordTF.text.length > 16) {
        [MBHUDManager showBriefAlert:@"密码为6到16位的数字或字母！"];
        return;
    }
    [RegisterManager callBackFindPasswordRequestWithMobile:phoneString code:codeString passwd:self.passwordTF.text repasswd:self.passwordTF.text andCompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message) {
        if (isSuccess) {
            [MBHUDManager showBriefAlert:@"修改密码成功！"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            if (![NSString isEmptyWithStr:message]) {
                [MBHUDManager showBriefAlert:message];
            }
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
