//
//  CourseTeacherCell.m
//  MK
//
//  Created by 周洋 on 2019/3/25.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "CourseTeacherCell.h"
@interface CourseTeacherCell()
@property (weak, nonatomic) IBOutlet UIImageView *teacherHeaderIma;//老师简介图
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLab;//名字
@property (weak, nonatomic) IBOutlet UILabel *teacherIntroduceLab;//导师介绍

@end
@implementation CourseTeacherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_teacherNameLab setFont:MKBoldFont(14) textColor:K_Text_grayColor withBackGroundColor:nil];
    [_teacherIntroduceLab setFont:K_Font_Text_Min textColor:K_Text_grayColor withBackGroundColor:nil];
    _teacherIntroduceLab.numberOfLines = 2;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.teacherHeaderIma.frame = CGRectMake(KScaleWidth(25), self.contentView.centerY-KScaleWidth(25), KScaleWidth(50), KScaleWidth(50));
    self.teacherNameLab.frame = CGRectMake(self.teacherHeaderIma.rightX+KScaleWidth(10), self.teacherHeaderIma.topY, self.contentView.width-self.teacherHeaderIma.rightX-KScaleWidth(10+50), KScaleWidth(20));
    CGSize teacherIntroduceLabSize = [self.teacherIntroduceLab.text getStrSizeWithSize:CGSizeMake(self.teacherNameLab.width, 3000) font:self.teacherIntroduceLab.font];
    self.teacherIntroduceLab.frame = CGRectMake(self.teacherNameLab.leftX, self.teacherHeaderIma.bottomY-teacherIntroduceLabSize.height, teacherIntroduceLabSize.width, teacherIntroduceLabSize.height);
}
-(void)cellRefreshData
{
    self.teacherHeaderIma.image = KImageNamed(@"course_Teacher");
    self.teacherNameLab.text = @"冯 利兵";
    self.teacherIntroduceLab.text = @"多摩美术大学大学 情报设计硕士 \n每刻美术学院大学院 教务担当";
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
