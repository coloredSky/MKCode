//
//  DiscoverNewsCell.m
//  MK
//
//  Created by 周洋 on 2019/3/15.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "DiscoverNewsCell.h"
#import "DiscoverNewsModel.h"

@interface DiscoverNewsCell()
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIImageView *contentIma;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@end
@implementation DiscoverNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.shadowView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    self.shadowView.layer.shadowColor = [UIColor colorWithWhite:.8 alpha:1].CGColor;
    self.shadowView.layer.shadowRadius = 16.0f;
    self.shadowView.layer.shadowOffset = CGSizeMake(0, 0);
    self.shadowView.layer.shadowOpacity = .7;
    
    _whiteView.layer.masksToBounds = YES;
    _whiteView.layer.cornerRadius = 16;
    
    [_titleLab setFont:MKBoldFont(14) textColor:K_Text_grayColor withBackGroundColor:nil];[_contentLab setFont:K_Font_Text_Min_Max textColor:K_Text_grayColor withBackGroundColor:nil];
    _titleLab.numberOfLines = 2;
    self.contentLab.hidden = YES;

    self.contentIma.contentMode = UIViewContentModeScaleAspectFill;
    self.contentIma.clipsToBounds = YES;
}

-(void)cellRefreshDataWithDiscoverNewsModel:(DiscoverNewsModel *)newsModel
{
    [self.contentIma sd_setImageWithURL:[NSURL URLWithString:newsModel.newsImage] placeholderImage:K_MKPlaceholderImage4_3];
    self.titleLab.text = newsModel.newsTitle;
    self.contentLab.text = newsModel.newsDigest;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.shadowView.frame = CGRectMake(K_Padding_LeftPadding, 5, self.contentView.width-K_Padding_LeftPadding*2, self.contentView.height-10);
    self.whiteView.frame = CGRectMake(0, 0, self.shadowView.width, self.shadowView.height);
    self.contentIma.frame = CGRectMake(0, 0, self.whiteView.width, 257*self.whiteView.width/342);
    self.titleLab.frame = CGRectMake(16, self.contentIma.bottomY+ 14, self.whiteView.width-16*2, 40);
//    self.contentLab.frame = CGRectMake(self.titleLab.leftX, self.titleLab.bottomY+KScaleHeight(5), self.titleLab.width, KScaleHeight(20));
}
@end
