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
    self.backgroundColor =K_BG_deepGrayColor;
    _headerImage.image = KImageNamed(@"message_logo");
    _headerImage.backgroundColor = [UIColor whiteColor];
     [_nameLabel setFont:MKBoldFont(18) textColor:K_Text_BlackColor withBackGroundColor:nil];
     [_emailLabel setFont:MKBoldFont(10) textColor:K_Text_BlackColor withBackGroundColor:nil];
    [_updateBtn setNormalTitle:@"编辑个人资料" font:MKBoldFont(10) titleColor:K_Text_BlackColor];
    self.bgView.layer.shadowColor = K_Text_DeepGrayColor.CGColor;
    self.bgView.backgroundColor =[UIColor clearColor];
    self.bgView.layer.shadowRadius = 3.0f;
    self.bgView.layer.shadowOffset = CGSizeMake(1, 1);
    self.bgView.layer.shadowOpacity = .5;
    self.topView.layer.cornerRadius=6.f;
    self.topView.layer.masksToBounds=YES;
}
-(IBAction)updateBtnClick:(id)sender
{
    if (self.delegate  && [self.delegate respondsToSelector:@selector(headerViewBtnClick)])
    {
        [self.delegate headerViewBtnClick];
    }
}
@end
