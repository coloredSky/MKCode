//
//  RegisterController.m
//  MK
//
//  Created by ginluck on 2019/3/26.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "RegisterController.h"
#import "RegisterManager.h"
#import "JKCountDownButton.h"
@interface RegisterController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgIma;

@property (weak, nonatomic) IBOutlet UILabel *helloLab;
@property (weak, nonatomic) IBOutlet UILabel *signLab;
@property (weak, nonatomic) IBOutlet UILabel * phoneStringLab;
@property (weak, nonatomic) IBOutlet UILabel *codeSignLab;
//@property (weak, nonatomic) IBOutlet UIButton *forgetSignLab;

@property (weak, nonatomic) IBOutlet JKCountDownButton *codeBtn;

@property(nonatomic,weak)IBOutlet UITextField * phoneTextfield;
@property(nonatomic,weak)IBOutlet UITextField * codeTextfield;
@property(nonatomic,weak)IBOutlet UITextField * pwdTextfield;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneStringLabTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *registerBtnTopHeightConstraint;

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubViewAttributtes];
}

-(void)layoutSubViewAttributtes
{
    self.phoneStringLabTopConstraint.constant = KScaleHeight(self.phoneStringLabTopConstraint.constant);
    self.registerBtnTopHeightConstraint.constant = KScaleHeight(self.registerBtnTopHeightConstraint.constant);
    
    [self.codeTextfield setValue:K_Text_grayColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.codeTextfield setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    [self.phoneTextfield setValue:K_Text_grayColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.phoneTextfield setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    [self.pwdTextfield setValue:K_Text_grayColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.pwdTextfield setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    self.bgIma.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
    self.helloLab.attributedText = [self getAttributedStringWithString:@"Hello！" textFont:MKFont(30)];
    self.signLab.attributedText = [self getAttributedStringWithString:@"Sign in to continue" textFont:MKFont(30)];
    self.phoneStringLab.attributedText = [self getAttributedStringWithString:@"可接收验证码的手机号" textFont:MKFont(15)];
    self.codeSignLab.attributedText = [self getAttributedStringWithString:@"验证码" textFont:MKFont(15)];
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
    switch (sender.tag) {
        case 1:
        {
            //获取验证码
            if ([NSString isEmptyWithStr:self.phoneTextfield.text]) {
                [MBHUDManager showBriefAlert:@"请输入手机号"];
                return;
            }
            if (self.phoneTextfield.text.length != 11) {
                [MBHUDManager showBriefAlert:@"请输入正确的手机号"];
                return;
            }
            [_codeBtn didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                countDownButton.enabled = YES;
                return @"重新获取";
            }];
            [RegisterManager callBackPhoneCodeWithHudShow:YES phone:self.phoneTextfield.text CompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message) {
                if (isSuccess) {
                    [MBHUDManager showBriefAlert:@"获取验证码成功"];
                    [self.codeBtn startWithSecond:60];
                    [self.codeBtn didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
                        NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
                        return title;
                    }];
                }else{
                     [MBHUDManager showBriefAlert:message];
                }
            }];
        }
            break;
        case 2:
        {
            //注册
            if ([NSString isEmptyWithStr:self.phoneTextfield.text]) {
                [MBHUDManager showBriefAlert:@"请输入手机号"];
                return;
            }
            if ([NSString isEmptyWithStr:self.codeTextfield.text])
            {
                [MBHUDManager showBriefAlert:@"请填写验证码"];
                return;
            }
            if ([NSString isEmptyWithStr:self.pwdTextfield.text])
            {
                [MBHUDManager showBriefAlert:@"请填写密码"];
                return;
            }
            if (self.phoneTextfield.text.length != 11) {
                [MBHUDManager showBriefAlert:@"请输入正确的手机号"];
                return;
            }
            if (self.pwdTextfield.text.length < 6 || self.pwdTextfield.text.length > 16) {
                [MBHUDManager showBriefAlert:@"请输入6到16位的密码"];
                return;
            }
            [RegisterManager callBackRegisterWithHudShow:YES phone:self.phoneTextfield.text code:self.codeTextfield.text pwd:self.pwdTextfield.text CompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message) {
                if (isSuccess) {
                    [MBHUDManager showBriefAlert:@"注册成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [MBHUDManager showBriefAlert:message];
                }
            }];
        }
            break;
            
        default:
            break;
    }
}


@end
