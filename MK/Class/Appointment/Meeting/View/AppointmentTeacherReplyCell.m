//
//  AppointmentTeacherReplyCell.m
//  MK
//
//  Created by 周洋 on 2019/4/1.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "AppointmentTeacherReplyCell.h"
@interface AppointmentTeacherReplyCell()
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIImageView *iconIma;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLab;
@property (weak, nonatomic) IBOutlet UILabel *replyContentLab;

@end
@implementation AppointmentTeacherReplyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _whiteView.layer.masksToBounds = YES;
    _whiteView.layer.cornerRadius = KScaleWidth(10);
    _whiteView.backgroundColor = K_BG_deepGrayColor;
    
    [_courseNameLab setFont:K_Font_Text_Min_Max textColor:K_Text_grayColor withBackGroundColor:nil];
    [_replyContentLab setFont:K_Font_Text_Normal textColor:K_Text_BlackColor withBackGroundColor:nil];
    _replyContentLab.numberOfLines = 2;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.whiteView.frame = CGRectMake(K_Padding_Home_LeftPadding, 0, self.contentView.width-K_Padding_Home_LeftPadding*2, self.contentView.height-KScaleHeight(15));
    self.iconIma.frame = CGRectMake(KScaleWidth(15), KScaleHeight(10), KScaleWidth(35), KScaleWidth(35));
    self.courseNameLab.frame = CGRectMake(self.iconIma.rightX+KScaleWidth(15), self.iconIma.topY, self.whiteView.width-self.iconIma.rightX-KScaleWidth(15), KScaleHeight(20));
    self.replyContentLab.frame = CGRectMake(self.courseNameLab.leftX, self.courseNameLab.bottomY, self.courseNameLab.width, KScaleHeight(40));
}

-(void)cellRefreshData
{
    self.iconIma.image = KImageNamed(@"course_Teacher");
    self.courseNameLab.text = @"每刻美术学院";
    self.replyContentLab.text = @"张同学放心，按照我们的课程来没有问题的。加 油！";
}
@end
