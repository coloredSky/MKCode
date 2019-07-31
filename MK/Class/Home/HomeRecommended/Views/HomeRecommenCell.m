//
//  HomeRecommenCell.m
//  MK
//
//  Created by 周洋 on 2019/3/19.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "HomeRecommenCell.h"
#import "MKCourseListModel.h"

@interface HomeRecommenCell()

@property (weak, nonatomic) IBOutlet UIView *shdowView;
@property (weak, nonatomic) IBOutlet UIImageView *contentIma;

@property (weak, nonatomic) IBOutlet UIView *whiteShadowView;
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
    
    self.shdowView.layer.shadowColor = [UIColor colorWithWhite:.8 alpha:1].CGColor;
    self.shdowView.layer.shadowRadius = 12.0f;
    self.shdowView.layer.shadowOffset = CGSizeMake(0, 0);
    self.shdowView.layer.shadowOpacity = .7;
    
    _contentIma.layer.masksToBounds = YES;
    _contentIma.layer.cornerRadius = 14;
    
//    _whiteView.hidden = YES;
//    _titleLab.hidden = YES;
//    _discriptionLab.hidden = YES;
//    _whiteView.backgroundColor = UIColorFromRGB_A(255, 255, 255, .2);
    _whiteShadowView.backgroundColor = [UIColor clearColor];
    _whiteShadowView.layer.shadowColor = K_Text_DeepGrayColor.CGColor;
    _whiteShadowView.layer.shadowRadius = 3.0f;
    _whiteShadowView.layer.shadowOffset = CGSizeMake(1, 1);
    _whiteShadowView.layer.shadowOpacity = .5;
    _whiteView.backgroundColor = [UIColor colorWithWhite:1 alpha:.4];
    [_titleLab setFont:MKBoldFont(16) textColor:K_Text_BlackColor withBackGroundColor:nil];
    [_discriptionLab setFont:K_Font_Text_Min textColor:K_Text_BlackColor withBackGroundColor:nil];
    _discriptionLab.numberOfLines = 2;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.shdowView.frame = CGRectMake(K_Padding_Home_LeftPadding, 0, self.contentView.width-K_Padding_Home_LeftPadding*2, self.contentView.height-15);
    _contentIma.frame = CGRectMake(0, 0, self.shdowView.width, self.shdowView.height);
    _whiteShadowView.frame = CGRectMake(_contentIma.leftX, _contentIma.bottomY-20-60, _contentIma.width, 60);
    _whiteView.frame = CGRectMake(0, 0, _whiteShadowView.width, _whiteShadowView.height);
    _titleLab.frame = CGRectMake(8, 5, _whiteView.width-16, 15);
    _discriptionLab.frame = CGRectMake(_titleLab.leftX, _titleLab.bottomY, _titleLab.width, 40);
}

-(void)cellRefreshDataWithMKCourseListModel:(MKCourseListModel *)model
{
    [self.contentIma sd_setImageWithURL:[NSURL URLWithString:model.courseImage] placeholderImage:K_MKPlaceholderImage2_1];
    self.titleLab.text = model.courseName;
    self.discriptionLab.text = model.courseDescription;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
