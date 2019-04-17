//
//  RegisterController.m
//  MK
//
//  Created by ginluck on 2019/3/26.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "RegisterController.h"
#import "RegisterManager.h"
@interface RegisterController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgIma;

@property (weak, nonatomic) IBOutlet UILabel *helloLab;
@property (weak, nonatomic) IBOutlet UILabel *signLab;
@property (weak, nonatomic) IBOutlet UILabel * phoneStringLab;
@property (weak, nonatomic) IBOutlet UILabel *codeSignLab;
//@property (weak, nonatomic) IBOutlet UIButton *forgetSignLab;

@property(nonatomic,weak)IBOutlet UITextField * phoneTextfield;
@property(nonatomic,weak)IBOutlet UITextField * codeTextfield;
@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubViewAttributtes];
}
-(void)layoutSubViewAttributtes
{
    [self.codeTextfield setValue:K_Text_grayColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.codeTextfield setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
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
        case 0:
        {
            //返回
            [self dismissViewControllerAnimated:NO completion:nil];
        }
            break;
        case 1:
        {
            //获取验证码
            [RegisterManager callBackPhoneCodeWithHudShow:YES phone:self.phoneTextfield.text CompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message, NSString * _Nonnull code) {
                
                
            }];
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
