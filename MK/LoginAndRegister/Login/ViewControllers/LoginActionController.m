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
#import "FindPwdController.h"
#import "LoginManager.h"

@interface LoginActionController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgIma;

@property (weak, nonatomic) IBOutlet UILabel *helloLab;
@property (weak, nonatomic) IBOutlet UILabel *signLab;
@property (weak, nonatomic) IBOutlet UILabel *idStringLab;
@property (weak, nonatomic) IBOutlet UILabel *passwordSignLab;
@property (weak, nonatomic) IBOutlet UIButton *forgetSignLab;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneStringTopHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginBtnTopHeightConstraint;

@end

@implementation LoginActionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubViewAttributtes];
}

-(void)layoutSubViewAttributtes
{
    self.phoneStringTopHeightConstraint.constant =  KScaleHeight(self.phoneStringTopHeightConstraint.constant);
    self.loginBtnTopHeightConstraint.constant = K_IS_IPHONE_5 ? 100 : KScaleHeight(self.loginBtnTopHeightConstraint.constant);
    self.bgIma.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
    [self.passwordTF setValue:K_Text_grayColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTF setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    [self.phoneTF setValue:K_Text_grayColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.phoneTF setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    self.helloLab.attributedText = [self getAttributedStringWithString:@"Hello！" textFont:MKFont(30)];
    self.signLab.attributedText = [self getAttributedStringWithString:@"Sign in to continue" textFont:MKFont(30)];
    self.idStringLab.attributedText = [self getAttributedStringWithString:@"ID(email or mobile NO.)" textFont:MKFont(15)];
    self.passwordSignLab.attributedText = [self getAttributedStringWithString:@"Password" textFont:MKFont(15)];
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

-(IBAction)btnClick:(UIButton *)sender
{
    if (sender.tag ==1) {
//          [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if(sender.tag==2){
        if ([NSString isEmptyWithStr:self.phoneTF.text]){
            [MBHUDManager showBriefAlert:@"请输入用户名"];
            return;
        }
        if ([NSString isEmptyWithStr:self.passwordTF.text]){
            [MBHUDManager showBriefAlert:@"请输入密码"];
            return;
        }
        if (self.passwordTF.text.length < 6 || self.passwordTF.text.length > 16){
            [MBHUDManager showBriefAlert:@"请输入6到16位的密码"];
            return;
        }
        //登录
        [MBHUDManager showLoading];
        [LoginManager callBackLoginDataWithHudShow:YES userName:self.phoneTF.text pwd:self.passwordTF.text CompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message, LoginModel * _Nonnull model) {
            [MBHUDManager hideAlert];
            if (isSuccess) {
                [self backToPreviousViewController];
                [[NSNotificationCenter defaultCenter]postNotificationName:kMKLoginInNotifcationKey object:nil];
            }else{
                if (![NSString isEmptyWithStr:message]) {
                    [MBHUDManager showBriefAlert:message];
                }
            }
        }];
    }else if (sender.tag == 3){
        //忘记密码
        FindPwdController *findPwdVC = [FindPwdController new];
        [self.navigationController pushViewController:findPwdVC animated:YES];
    }
}

- (IBAction)registerTarget:(id)sender
{
    RegisterController *registerVC = [RegisterController new];
    [self.navigationController pushViewController:registerVC animated:YES];
}


@end
