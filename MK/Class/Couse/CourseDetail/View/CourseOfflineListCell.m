//
//  CourseOfflineListCell.m
//  MK
//
//  Created by 周洋 on 2019/3/27.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "CourseOfflineListCell.h"
@interface CourseOfflineListCell()
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UILabel *courseNumLab;//课程编号
@property (weak, nonatomic) IBOutlet UILabel *courseTimeLab;//课程时间
@property (weak, nonatomic) IBOutlet UILabel *courseDecriptionLab;//课程描述
@property (weak, nonatomic) IBOutlet UIImageView *courseSelectedIma;//是否上过c课程

@end
@implementation CourseOfflineListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.whiteView.backgroundColor = K_BG_deepGrayColor;
    [self.courseNumLab setFont:K_Font_Text_Normal textColor:K_Text_grayColor withBackGroundColor:nil];
    [self.courseTimeLab setFont:MKBoldFont(13) textColor:K_Text_grayColor withBackGroundColor:nil];
    [self.courseDecriptionLab setFont:K_Font_Text_Min_Max textColor:K_Text_grayColor withBackGroundColor:nil];
    self.courseDecriptionLab.numberOfLines = 2;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.whiteView.frame = CGRectMake(K_Padding_LeftPadding, 0, self.contentView.width-K_Padding_LeftPadding*2, self.contentView.height-KScaleHeight(10));
    self.courseNumLab.frame = CGRectMake(K_Padding_LeftPadding, 0, KScaleWidth(30), self.whiteView.height);
    self.courseSelectedIma.frame = CGRectMake(self.whiteView.width-K_Padding_LeftPadding-KScaleWidth(22), self.whiteView.height/2-KScaleWidth(11), KScaleWidth(22), KScaleWidth(22));
    self.courseTimeLab.frame = CGRectMake(self.courseNumLab.rightX, KScaleHeight(6), self.courseSelectedIma.leftX-self.courseNumLab.rightX-K_Padding_LeftPadding*2, KScaleHeight(20));
    self.courseDecriptionLab.frame = CGRectMake(self.courseTimeLab.leftX, self.courseTimeLab.bottomY, self.courseTimeLab.width, KScaleHeight(40));
}

-(void)cellRefreshData
{
    self.courseSelectedIma.image = KImageNamed(@"courseDetail_selected");
    self.courseNumLab.text = @"1";
    self.courseTimeLab.text = @"03月14日   17:00-19:00";
    self.courseDecriptionLab.text = @"概述大学院美术进学的概念，介绍确认研究课题的方法，通过随堂练习导入方法 …";
}
@end
