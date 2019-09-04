//
//  CourseTeacherCell.m
//  MK
//
//  Created by 周洋 on 2019/3/25.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "CourseTeacherCell.h"
#import "MKCourseDetailModel.h"
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
    _teacherIntroduceLab.numberOfLines = 3;
    _teacherHeaderIma.contentMode = UIViewContentModeScaleAspectFill;
    _teacherHeaderIma.clipsToBounds = YES;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.teacherHeaderIma.frame = CGRectMake(KScaleWidth(25), KScaleWidth(10), (self.contentView.height-KScaleWidth(20))*5.0/6.0, self.contentView.height-KScaleWidth(20));
    self.teacherNameLab.frame = CGRectMake(self.teacherHeaderIma.rightX+KScaleWidth(10), self.teacherHeaderIma.topY, self.contentView.width-self.teacherHeaderIma.rightX-KScaleWidth(10+25), KScaleWidth(20));
//    CGSize teacherIntroduceLabSize = [self.teacherIntroduceLab.text getStrSizeWithSize:CGSizeMake(self.teacherNameLab.width, 3000) font:self.teacherIntroduceLab.font];
    self.teacherIntroduceLab.frame = CGRectMake(self.teacherNameLab.leftX, self.teacherNameLab.bottomY, self.teacherNameLab.width, self.teacherHeaderIma.height-self.teacherNameLab.height);
}
-(void)cellRefreshDataWithTeacherName:(NSString *)teacherNmae teacherIma:(NSString *)teacherIma teacherDescription:(NSString *)teacherDescription
{
//    self.teacherIntroduceLab.text = teacherDescription;
    [self.teacherHeaderIma sd_setImageWithURL:[NSURL URLWithString:teacherIma] placeholderImage:K_MKPlaceholderImage1_1];
    self.teacherNameLab.text = teacherNmae;
    NSString *teacherString = [NSString filterHTML:teacherDescription];
    NSString *resultTeacherString = [teacherString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
  
    self.teacherIntroduceLab.attributedText = [self configTeacherDesvriptipnString:resultTeacherString];
}

-(NSMutableAttributedString *)configTeacherDesvriptipnString:(NSString *)teacherStr
{
    NSRange rangeString1 = [teacherStr rangeOfString:@"讲师简历"];
    NSRange rangeString2 = [teacherStr rangeOfString:@"寄语"];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:teacherStr];
    [attributedText addAttributes:@{NSFontAttributeName : MKBoldFont(12), NSForegroundColorAttributeName : K_Text_BlackColor} range:rangeString1];
    [attributedText addAttributes:@{NSFontAttributeName : MKBoldFont(12), NSForegroundColorAttributeName : K_Text_BlackColor} range:rangeString2];
    return attributedText;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
