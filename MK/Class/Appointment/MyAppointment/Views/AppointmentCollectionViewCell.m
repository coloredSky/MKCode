//
//  AppointmentCollectionViewCell.m
//  MK
//
//  Created by 周洋 on 2019/3/20.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "AppointmentCollectionViewCell.h"
#import "AppointmentListModel.h"

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
@property (weak, nonatomic) IBOutlet UILabel *statusLab;

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
    [self.statusLab setFont:K_Font_Text_Normal textColor:K_Text_BlueColor withBackGroundColor:nil];
    self.statusLab.hidden = YES;
    
    self.titleIma.image = KImageNamed(@"appointment_changeClass");
    self.timeIma.image = KImageNamed(@"appointment_Coursetime");
    self.courseNameIma.image = KImageNamed(@"appointment_CourseName");
    self.teacherIma.image = KImageNamed(@"appointment_CourseTeacher");
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.shadowView.frame = CGRectMake(5, 5, self.contentView.width-10, self.contentView.height-10);
    self.whiteView.frame = CGRectMake(0, 0, self.shadowView.width, self.shadowView.height);
    self.titleIma.frame = CGRectMake(KScaleWidth(20), KScaleWidth(20), KScaleWidth(16), KScaleWidth(16));
    self.titleLab.frame = CGRectMake(self.titleIma.rightX+KScaleWidth(10), self.titleIma.centerY-KScaleWidth(10), self.contentView.width-self.titleLab.leftX, KScaleWidth(20));
    self.statusLab.frame = CGRectMake(self.whiteView.width-20-KScaleWidth(60), self.titleLab.centerY-10, KScaleWidth(60), 20);
    self.timeIma.frame = CGRectMake(self.titleIma.leftX, self.titleIma.bottomY+KScaleWidth(14), self.titleIma.width, self.titleIma.height);
    self.timeLab.frame = CGRectMake(self.titleLab.leftX, self.timeIma.centerY-self.titleLab.height/2, self.titleLab.width, self.titleLab.height);
    self.courseNameIma.frame = CGRectMake(self.timeIma.leftX, self.timeIma.bottomY+KScaleWidth(8), self.timeIma.width, self.timeIma.height);
    self.courseNameLab.frame = CGRectMake(self.titleLab.leftX, self.courseNameIma.centerY-self.titleLab.height/2, self.titleLab.width, self.titleLab.height);
    self.teacherIma.frame = CGRectMake(self.timeIma.leftX, self.courseNameIma.bottomY+KScaleWidth(8), self.timeIma.width, self.timeIma.height);
    self.teacherLab.frame = CGRectMake(self.titleLab.leftX, self.teacherIma.centerY-self.titleLab.height/2, self.timeLab.width, self.timeLab.height);
    
}

-(void)cellRefreshDataWithDisplayType:(AppointmentDisplayType )displayType andAppointmentListModel:(AppointmentListModel *)appointmentModel
{
    NSArray *titleArr = @[@"更换班级",@"请假",@"预约相谈"];
    if (displayType == AppointmentDisplayTypeMeeting) {
        self.titleLab.text = appointmentModel.type;
        self.statusLab.hidden = NO;
        self.statusLab.text = appointmentModel.status_msg;
    }else{
     self.titleLab.text = titleArr[displayType];
    }
    self.timeLab.text = appointmentModel.add_time;
    self.courseNameLab.text = appointmentModel.address;
    self.teacherLab.text = appointmentModel.staff_name;
}
@end
