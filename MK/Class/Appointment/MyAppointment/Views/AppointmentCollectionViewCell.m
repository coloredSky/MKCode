//
//  AppointmentCollectionViewCell.m
//  MK
//
//  Created by 周洋 on 2019/3/20.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "AppointmentCollectionViewCell.h"
@interface AppointmentCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIImageView *titleIma;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *timeIma;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIImageView *courseNameIma;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLab;
@property (weak, nonatomic) IBOutlet UIImageView *teacherIma;
@property (weak, nonatomic) IBOutlet UILabel *teacherLab;

@end
@implementation AppointmentCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.shadowView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.shadowView.layer.shadowColor = K_Text_DeepGrayColor.CGColor;
    self.shadowView.layer.shadowRadius = 3.0f;
    self.shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    self.shadowView.layer.shadowOpacity = .5;
    
    self.whiteView.layer.masksToBounds = YES;
    self.whiteView.layer.cornerRadius = 8;
    [self.titleLab setFont:MKBoldFont(16) textColor:K_Text_BlackColor withBackGroundColor:nil];
    [self.timeLab setFont:K_Font_Text_Normal textColor:K_Text_grayColor withBackGroundColor:nil];
    [self.teacherLab setFont:K_Font_Text_Normal textColor:K_Text_grayColor withBackGroundColor:nil];
    [self.courseNameLab setFont:K_Font_Text_Normal textColor:K_Text_grayColor withBackGroundColor:nil];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.shadowView.frame = CGRectMake(5, 5, self.contentView.width-10, self.contentView.height-10);
    self.whiteView.frame = CGRectMake(0, 0, self.shadowView.width, self.shadowView.height);
    self.titleIma.frame = CGRectMake(KScaleWidth(20), KScaleWidth(20), KScaleWidth(16), KScaleWidth(16));
    self.titleLab.frame = CGRectMake(self.titleIma.rightX+KScaleWidth(10), self.titleIma.centerY-KScaleWidth(10), self.contentView.width-self.titleLab.leftX, KScaleWidth(20));
    self.timeIma.frame = CGRectMake(self.titleIma.leftX, self.titleIma.bottomY+KScaleWidth(14), self.titleIma.width, self.titleIma.height);
    self.timeLab.frame = CGRectMake(self.titleLab.leftX, self.timeIma.centerY-self.titleLab.height/2, self.titleLab.width, self.titleLab.height);
    self.courseNameIma.frame = CGRectMake(self.timeIma.leftX, self.timeIma.bottomY+KScaleWidth(8), self.timeIma.width, self.timeIma.height);
    self.courseNameLab.frame = CGRectMake(self.titleLab.leftX, self.courseNameIma.centerY-self.titleLab.height/2, self.titleLab.width, self.titleLab.height);
    self.teacherIma.frame = CGRectMake(self.timeIma.leftX, self.courseNameIma.bottomY+KScaleWidth(8), self.timeIma.width, self.timeIma.height);
    self.teacherLab.frame = CGRectMake(self.titleLab.leftX, self.teacherIma.centerY-self.titleLab.height/2, self.timeLab.width, self.timeLab.height);
}

-(void)cellRefreshDataWithDisplayType:(AppointmentDisplayType )displayType
{
    NSArray *titleArr = @[@"更换班级",@"请假",@"预约相谈"];
    self.titleIma.image = KImageNamed(@"appointment_changeClass");
    self.timeIma.image = KImageNamed(@"appointment_Coursetime");
    self.courseNameIma.image = KImageNamed(@"appointment_CourseName");
    self.teacherIma.image = KImageNamed(@"appointment_CourseTeacher");
    self.titleLab.text = titleArr[displayType];
    self.timeLab.text = @"12月20日";
    self.courseNameLab.text = @"日语基础-日语进阶";
    self.teacherLab.text = @"大学院美术 施晋昊";
}
@end
