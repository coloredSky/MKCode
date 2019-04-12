//
//  HomeRecommenCell.m
//  MK
//
//  Created by 周洋 on 2019/3/19.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "HomeRecommenCell.h"
@interface HomeRecommenCell()

@property (weak, nonatomic) IBOutlet UIView *shdowView;
@property (weak, nonatomic) IBOutlet UIImageView *contentIma;
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *discriptionLab;

@end

@implementation HomeRecommenCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.shdowView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.shdowView.layer.shadowColor = K_Text_DeepGrayColor.CGColor;
    self.shdowView.layer.shadowRadius = 3.0f;
    self.shdowView.layer.shadowOffset = CGSizeMake(1, 1);
    self.shdowView.layer.shadowOpacity = .5;
    
    _contentIma.layer.masksToBounds = YES;
    _contentIma.layer.cornerRadius = 10;
    
    _whiteView.hidden = YES;
    _titleLab.hidden = YES;
    _discriptionLab.hidden = YES;
    _whiteView.backgroundColor = UIColorFromRGB_A(255, 255, 255, .2);
    [_titleLab setFont:MKBoldFont(16) textColor:K_Text_BlackColor withBackGroundColor:nil];
    [_discriptionLab setFont:K_Font_Text_Min textColor:K_Text_BlackColor withBackGroundColor:nil];
    _discriptionLab.numberOfLines = 2;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.shdowView.frame = CGRectMake(K_Padding_Home_LeftPadding, 0, self.contentView.width-K_Padding_Home_LeftPadding*2, self.contentView.height-15);
    _contentIma.frame = CGRectMake(0, 0, self.shdowView.width, self.shdowView.height);
    _whiteView.frame = CGRectMake(_contentIma.leftX, _contentIma.bottomY-20-60, _contentIma.width, 60);
    _titleLab.frame = CGRectMake(8, 5, _whiteView.width-16, 15);
    _discriptionLab.frame = CGRectMake(_titleLab.leftX, _titleLab.bottomY, _titleLab.width, 40);
}

-(void)cellRefreshData
{
    self.contentIma.image = KImageNamed(@"home_recommentCell");
//    self.titleLab.text = @"EJU文科综合—历史";
//    self.discriptionLab.text = @"巩固日语基础阶段学习中必须掌握的语法，\n为留考，校内考以及N1N2的学习打下良好的基础。";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
