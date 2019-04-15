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
@property (weak, nonatomic) IBOutlet UIImageView *bgIma;

@property (weak, nonatomic) IBOutlet UILabel *helloLab;
@property (weak, nonatomic) IBOutlet UILabel *signLab;
@property (weak, nonatomic) IBOutlet UILabel *idStringLab;
@property (weak, nonatomic) IBOutlet UILabel *passwordSignLab;
@property (weak, nonatomic) IBOutlet UIButton *forgetSignLab;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation LoginActionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubViewAttributtes];
}
-(void)layoutSubViewAttributtes
{
    self.bgIma.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
    [self.passwordTF setValue:K_Text_grayColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTF setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
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
          [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        //登录
//        MKTarbarViewController *tarbarVC = [MKTarbarViewController new];
//        [[UIApplication sharedApplication]keyWindow]. rootViewController = tarbarVC;
        [self.navigationController popViewControllerAnimated:YES];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:YES forKey:KMKLoginKey];
        [userDefaults synchronize];
//        [self dismissViewControllerAnimated:YES completion:nil];
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
