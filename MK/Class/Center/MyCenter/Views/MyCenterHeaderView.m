//
//  MyCenterHeaderView.m
//  MK
//
//  Created by ginluck on 2019/3/18.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MyCenterHeaderView.h"
@interface MyCenterHeaderView()
@property(nonatomic,weak)IBOutlet UIImageView * headerImage;
@property(nonatomic,weak)IBOutlet UILabel * nameLabel;
@property(nonatomic,weak)IBOutlet UILabel * emailLabel;
@property(nonatomic,weak)IBOutlet UIButton * updateBtn;
@property(nonatomic,weak)IBOutlet UIView * topView;
@property(nonatomic,weak)IBOutlet UIView * bgView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end
@implementation MyCenterHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = K_BG_deepGrayColor;
    _headerImage.contentMode = UIViewContentModeScaleAspectFill;
    _headerImage.clipsToBounds = YES;
    _headerImage.image = K_MKPlaceholderImage1_1;
//    _headerImage.backgroundColor = [UIColor whiteColor];
     [_nameLabel setFont:MKBoldFont(15) textColor:K_Text_BlackColor withBackGroundColor:nil];
     [_emailLabel setFont:MKBoldFont(10) textColor:K_Text_BlackColor withBackGroundColor:nil];
    [_updateBtn setNormalTitle:@"编辑个人资料" font:MKBoldFont(10) titleColor:K_Text_BlackColor];
    
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = 4;
    _loginBtn.hidden = YES;
    [_loginBtn setNormalTitle:@"登录" font:MKFont(13) titleColor:K_Text_BlackColor];
    
    self.bgView.layer.shadowColor = K_Text_DeepGrayColor.CGColor;
    self.bgView.backgroundColor =[UIColor clearColor];
    self.bgView.layer.shadowRadius = 3.0f;
    self.bgView.layer.shadowOffset = CGSizeMake(0, 0);
    self.bgView.layer.shadowOpacity = .5;
    
    self.topView.layer.cornerRadius=6.f;
    self.topView.layer.masksToBounds=YES;
}

-(void)refreshData
{
    BOOL isLogin = [[UserManager shareInstance]isLogin];
    self.loginBtn.hidden = isLogin;
    self.headerImage.hidden = !isLogin;
    self.nameLabel.hidden = !isLogin;
    self.emailLabel.hidden = !isLogin;
    self.updateBtn.hidden = !isLogin;
    
    LoginModel * model =[[UserManager shareInstance]getUser];
    NSString *nameString = [model.lastname stringByAppendingString:model.firstname];
    self.nameLabel.text =[NSString isEmptyWithStr:nameString]==YES?@"您尚未设置用户名":nameString;
    self.emailLabel.text =[NSString isEmptyWithStr:model.email]==YES?@"您尚未设置邮箱":model.email;
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:K_MKPlaceholderImage1_1];
}

-(IBAction)updateBtnClick:(UIButton *)sender
{
    if (self.delegate  && [self.delegate respondsToSelector:@selector(headerViewBtnClickWithOperationType:)])
    {
        [self.delegate headerViewBtnClickWithOperationType:sender.tag];
    }
}
@end
