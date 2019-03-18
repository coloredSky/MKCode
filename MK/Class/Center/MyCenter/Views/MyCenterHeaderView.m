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
     [_nameLabel setFont:MKBoldFont(18) textColor:K_Text_BlackColor withBackGroundColor:nil];
     [_emailLabel setFont:MKBoldFont(10) textColor:K_Text_BlackColor withBackGroundColor:nil];
    [_updateBtn setNormalTitle:@"编辑个人资料" font:MKBoldFont(10) titleColor:K_Text_BlackColor];
}
@end
