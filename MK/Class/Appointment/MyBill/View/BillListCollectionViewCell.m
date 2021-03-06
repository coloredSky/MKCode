//
//  BillListCollectionViewCell.m
//  MK
//
//  Created by 周洋 on 2019/4/4.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "BillListCollectionViewCell.h"
#import "UserBillListModel.h"

@interface BillListCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIImageView *contentIma;
@property (weak, nonatomic) IBOutlet UIImageView *bgIma;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end
@implementation BillListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.shadowView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.shadowView.layer.shadowColor = K_Text_grayColor.CGColor;
    self.shadowView.layer.shadowRadius = 3.0f;
    self.shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    self.shadowView.layer.shadowOpacity = .5;
    
    self.whiteView.layer.masksToBounds = YES;
    self.whiteView.layer.cornerRadius = KScaleWidth(10);
    self.contentIma.layer.masksToBounds = YES;
    self.contentIma.layer.cornerRadius = KScaleWidth(10);
    
    self.contentIma.contentMode = UIViewContentModeScaleAspectFill;
    self.contentIma.clipsToBounds = YES;
    
    self.bgIma.layer.masksToBounds = YES;
    self.bgIma.layer.cornerRadius = KScaleWidth(10);
    self.bgIma.backgroundColor = [UIColor colorWithWhite:.5 alpha:.5];
    
    [self.courseNameLab setFont:MKBoldFont(15) textColor:K_Text_WhiteColor withBackGroundColor:nil];
    [self.timeLab setFont:K_Font_Text_Normal_Max textColor:K_Text_WhiteColor withBackGroundColor:nil];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.shadowView.frame = CGRectMake(K_Padding_Home_LeftPadding, KScaleHeight(10), self.contentView.width-K_Padding_Home_LeftPadding*2, self.contentView.height-KScaleHeight(20));
    self.whiteView.frame = CGRectMake(0, 0, self.shadowView.width, self.shadowView.height);
    self.contentIma.frame = CGRectMake(KScaleWidth(11), KScaleHeight(13), self.whiteView.width-KScaleWidth(22), self.whiteView.height-KScaleHeight(26));
    self.bgIma.frame = CGRectMake(KScaleWidth(11), KScaleHeight(13), self.whiteView.width-KScaleWidth(22), self.whiteView.height-KScaleHeight(26));
    self.courseNameLab.frame = CGRectMake(self.contentIma.leftX +K_Padding_LeftPadding, self.contentIma.topY+KScaleHeight(45), self.contentIma.width-K_Padding_LeftPadding*2, KScaleHeight(20));
    self.timeLab.frame = CGRectMake(self.courseNameLab.leftX, self.courseNameLab.bottomY, self.courseNameLab.width, self.courseNameLab.height);
}

-(void)cellRefreshDataWithUserBillListModel:(UserBillListModel *)billModel
{
     [self.contentIma sd_setImageWithURL:[NSURL URLWithString:billModel.course_post] placeholderImage:K_MKPlaceholderImage2_1];
    self.courseNameLab.text = billModel.course_name;
    self.timeLab.text = billModel.log_date;
}
@end
