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

@end

@implementation LoginActionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubViewAttributtes];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
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
    else if(sender.tag==2)
    {
        //登录
        [LoginManager callBackLoginDataWithHudShow:YES userName:self.phoneTF.text pwd:self.passwordTF.text CompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message, LoginModel * _Nonnull model) {
            if (isSuccess ==YES) {
                [ViewControllerManager showMainViewController];
            }
        }];
    }
  
}

- (IBAction)registerTarget:(id)sender
{
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
