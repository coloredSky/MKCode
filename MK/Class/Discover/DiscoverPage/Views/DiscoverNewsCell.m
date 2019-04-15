//
//  DiscoverNewsCell.m
//  MK
//
//  Created by 周洋 on 2019/3/15.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "DiscoverNewsCell.h"
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
    self.shadowView.layer.shadowColor = UIColorFromRGB_0x(000000) .CGColor;
    self.shadowView.layer.shadowRadius = 4.0f;
    self.shadowView.layer.shadowOffset = CGSizeMake(0, 0);
    self.shadowView.layer.shadowOpacity = .2;
    
    _whiteView.layer.masksToBounds = YES;
    _whiteView.layer.cornerRadius = 16;
    
    [_titleLab setFont:MKBoldFont(14) textColor:K_Text_grayColor withBackGroundColor:nil];[_contentLab setFont:K_Font_Text_Min_Max textColor:K_Text_grayColor withBackGroundColor:nil];
    self.contentLab.numberOfLines = 2;
}

-(void)cellRefreshData
{
    self.contentIma.image = KImageNamed(@"dicover_contentimage");
    self.titleLab.text = @"今日应试技巧";
    self.contentLab.text = @"关于面试，各位同学是否已经做到胸有成竹了呢？";
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.shadowView.frame = CGRectMake(K_Padding_LeftPadding, KScaleHeight(5), self.contentView.width-K_Padding_LeftPadding*2, self.contentView.height-KScaleHeight(10));
    self.whiteView.frame = CGRectMake(0, 0, self.shadowView.width, self.shadowView.height);
    self.contentIma.frame = CGRectMake(0, 0, self.whiteView.width, 257*self.whiteView.width/342);
    self.titleLab.frame = CGRectMake(KScaleHeight(16), self.contentIma.bottomY+ KScaleHeight(14), self.whiteView.width-KScaleHeight(16), KScaleHeight(20));
    self.contentLab.frame = CGRectMake(self.titleLab.leftX, self.titleLab.bottomY+KScaleHeight(5), self.titleLab.width, KScaleHeight(20));
}
@end
