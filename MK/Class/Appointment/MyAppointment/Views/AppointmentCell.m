//
//  AppointmentCell.m
//  MK
//
//  Created by 周洋 on 2019/3/20.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "AppointmentCell.h"
#import "AppointmentListModel.h"

@interface AppointmentCell()
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIImageView *courseNameIma;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLab;
@property (weak, nonatomic) IBOutlet UIImageView *timeIma;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIImageView *teacherIma;
@property (weak, nonatomic) IBOutlet UILabel *teacherLab;
@property (weak, nonatomic) IBOutlet UIImageView *addressIma;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
//@property (weak, nonatomic) IBOutlet UILabel *applyTypeLab;

@end
@implementation AppointmentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.whiteView.backgroundColor = K_BG_GrayColor;
    self.whiteView.layer.masksToBounds = YES;
    self.whiteView.layer.cornerRadius = KScaleWidth(6);
    
    [self.courseNameLab setFont:MKBoldFont(13) textColor:K_Text_grayColor withBackGroundColor:nil];
    [self.timeLab setFont:K_Font_Text_Min_Little textColor:K_Text_grayColor withBackGroundColor:nil];
    [self.teacherLab setFont:K_Font_Text_Min_Little textColor:K_Text_grayColor withBackGroundColor:nil];
    [self.addressLab setFont:K_Font_Text_Min_Little textColor:K_Text_grayColor withBackGroundColor:nil];
//    [self.applyTypeLab setFont:MKBoldFont(14) textColor:K_Text_BlueColor withBackGroundColor:nil];
    
    self.courseNameIma.image = KImageNamed(@"appointment_changeClass_gray");
    self.timeIma.image = KImageNamed(@"appointment_Coursetime_gray");
    self.teacherIma.image = KImageNamed(@"appointment_Teacher_gray");
    self.addressIma.image = KImageNamed(@"appointment_address_gray");
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.whiteView.frame = CGRectMake(K_Padding_Home_LeftPadding, 0, self.contentView.width-K_Padding_Home_LeftPadding*2, self.contentView.height-KScaleHeight(10));
    self.courseNameIma.frame = CGRectMake(KScaleWidth(15), KScaleHeight(15), KScaleWidth(10), KScaleWidth(10));
    self.courseNameLab.frame = CGRectMake(self.courseNameIma.rightX+5, self.courseNameIma.centerY-KScaleHeight(10), KScaleWidth(200), KScaleHeight(20));
    self.timeIma.frame = CGRectMake(self.courseNameIma.leftX, self.courseNameIma.bottomY+KScaleHeight(15), self.courseNameIma.width, self.courseNameIma.height);
    self.timeLab.frame = CGRectMake(self.timeIma.rightX+KScaleWidth(5), self.timeIma.centerY-KScaleHeight(10), KScaleWidth(80), KScaleHeight(20));
    self.teacherLab.frame = CGRectMake(self.whiteView.width/2-KScaleWidth(40-20)-KScaleWidth(5)-self.timeIma.width, self.timeLab.topY, KScaleWidth(90), self.timeLab.height);
    self.teacherIma.frame = CGRectMake(self.teacherLab.leftX-KScaleWidth(5)-self.timeIma.width, self.timeIma.topY, self.courseNameIma.width, self.courseNameIma.height);
    self.addressLab.frame = CGRectMake(self.whiteView.width-KScaleWidth(80), self.timeLab.topY, KScaleWidth(80), self.timeLab.height);
    self.addressIma.frame = CGRectMake(self.addressLab.leftX-KScaleWidth(5)-self.timeIma.width, self.timeIma.topY, self.timeIma.width, self.timeIma.height);
//    self.applyTypeLab.frame = CGRectMake(self.whiteView.width-KScaleWidth(20)-KScaleWidth(5)-KScaleWidth(60), self.timeLab.topY-KScaleHeight(20), KScaleWidth(60), KScaleHeight(20));
}

-(void)cellRefreshDataWithDisplayType:(AppointmentDisplayType )displayType andAppointmentListModel:(AppointmentListModel *)appointmentModel
{
//    NSArray *titleArr = @[@"换班成功",@"请假成功",@"预约成功"];
//    self.applyTypeLab.text = titleArr[displayType];
    if (displayType == AppointmentDisplayTypeAskForLeave) {
        self.courseNameLab.text = appointmentModel.class_name;
        self.timeLab.text = appointmentModel.add_time;
        self.teacherLab.text = [NSString stringWithFormat:@"%@ %@",appointmentModel.lesson_name,appointmentModel.sname];
        self.addressLab.text = appointmentModel.class_room_name;
    }else if (displayType == AppointmentDisplayTypeMeeting){
        self.courseNameLab.text = appointmentModel.type;
        self.timeLab.text = appointmentModel.add_time;
        self.teacherLab.text  = appointmentModel.staff_name;
        self.addressLab.text = appointmentModel.address;
    }else if (displayType == AppointmentDisplayTypeChangeClass){
        self.courseNameLab.text = [NSString stringWithFormat:@"%@-%@",appointmentModel.class_name,appointmentModel.classNewName];
        self.timeLab.text = appointmentModel.add_time;
        self.teacherLab.text  = [NSString stringWithFormat:@"%@ %@",appointmentModel.course_name,appointmentModel.uname];
        self.addressLab.text = appointmentModel.address;
    }
}


@end
