//
//  CourseOfflineTitleCell.m
//  MK
//
//  Created by 周洋 on 2019/3/27.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "CourseOfflineTitleCell.h"
#import "MKOfflineCourseDetail.h"

@interface CourseOfflineTitleCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *calendarBtn;
@property (weak, nonatomic) IBOutlet UILabel *calendarSignLab;


@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *timeConsumingIma;
@property (weak, nonatomic) IBOutlet UILabel *timeConsumingLab;//课程耗时
@property (weak, nonatomic) IBOutlet UIImageView *addressIma;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;//上课地址
@property (weak, nonatomic) IBOutlet UIImageView *attendanceIma;
@property (weak, nonatomic) IBOutlet UILabel *attendanceLab;//出勤率
@property (weak, nonatomic) IBOutlet UIImageView *personsIma;
@property (weak, nonatomic) IBOutlet UILabel *personsLab;//上课人数

@property (weak, nonatomic) IBOutlet UIImageView *lineIma;
@end



@implementation CourseOfflineTitleCell
- (void)awakeFromNib {
    [super awakeFromNib];
    [_titleLab setFont:MKBoldFont(15) textColor:K_Text_grayColor withBackGroundColor:nil];
    _titleLab.numberOfLines = 2;
    [_calendarBtn setBackgroundImage:KImageNamed(@"coursedetail_calender") forState:UIControlStateNormal];
    _timeConsumingIma.image = KImageNamed(@"courseDetail_time");
    _addressIma.image = KImageNamed(@"coursedetail_address");
    _attendanceIma.image = KImageNamed(@"coursedetail_attendance");
    _personsIma.image = KImageNamed(@"courseDetail_Persons");
    
    [_timeConsumingLab setFont:K_Font_Text_Min_Max textColor:K_Text_grayColor withBackGroundColor:nil];
    [_addressLab setFont:_timeConsumingLab.font textColor:_timeConsumingLab.textColor withBackGroundColor:nil];
    [_attendanceLab setFont:_timeConsumingLab.font textColor:_timeConsumingLab.textColor withBackGroundColor:nil];
    [_personsLab setFont:_timeConsumingLab.font textColor:_timeConsumingLab.textColor withBackGroundColor:nil];
    [_calendarSignLab setFont:K_Font_Text_Min_MinLittle textColor:_timeConsumingLab.textColor withBackGroundColor:nil];
    _calendarSignLab.text = @"下载到日历";
    _calendarSignLab.textAlignment = NSTextAlignmentCenter;
    _lineIma.backgroundColor = K_Line_lineColor;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.calendarBtn.frame = CGRectMake(self.contentView.width-K_Padding_Home_LeftPadding-KScaleWidth(60), 0, KScaleWidth(60), KScaleWidth(60));
    self.calendarSignLab.frame = CGRectMake(self.calendarBtn.centerX-KScaleWidth(40), KScaleWidth(50), KScaleWidth(80), KScaleHeight(12));
    self.titleLab.frame = CGRectMake(K_Padding_LeftPadding, 0, self.calendarBtn.leftX-K_Padding_LeftPadding*2, KScaleWidth(48));
    
    self.bottomView.frame = CGRectMake(0, self.titleLab.bottomY+10, self.contentView.width, self.contentView.height-self.titleLab.bottomY);
    self.timeConsumingIma.frame = CGRectMake(self.titleLab.leftX, 0, KScaleWidth(12), KScaleWidth(12));
    self.timeConsumingLab.frame = CGRectMake(self.timeConsumingIma.rightX+5, self.timeConsumingIma.centerY-KScaleHeight(10), KScaleWidth(40), KScaleHeight(20));
    float addressWidth  = [self.addressLab.text getStrWidthWithfont:self.addressLab.font];
    if (addressWidth >= 80) {
        addressWidth = 80;
    }
    self.addressIma.frame = CGRectMake(self.timeConsumingLab.rightX, self.timeConsumingIma.topY, self.timeConsumingIma.width, self.timeConsumingIma.height);
    self.addressLab.frame = CGRectMake(self.addressIma.rightX+5, self.timeConsumingLab.topY, addressWidth, self.timeConsumingLab.height);
    self.attendanceIma.frame = CGRectMake(self.addressLab.rightX+15, self.timeConsumingIma.topY, self.timeConsumingIma.width, self.timeConsumingIma.height);
    self.attendanceLab.frame = CGRectMake(self.attendanceIma.rightX+5, self.timeConsumingLab.topY, self.timeConsumingLab.width, self.timeConsumingLab.height);
    self.personsIma.frame = CGRectMake(self.attendanceLab.rightX, self.timeConsumingIma.topY, self.timeConsumingIma.width, self.timeConsumingIma.height);
    self.personsLab.frame = CGRectMake(self.personsIma.rightX+5, self.timeConsumingLab.topY, self.timeConsumingLab.width, self.timeConsumingLab.height);
    self.lineIma.frame = CGRectMake(KScaleWidth(20), self.bottomView.height-K_Line_lineWidth, self.bottomView.width-KScaleWidth(20*2), K_Line_lineWidth);
}

-(void)cellRefreshDataWithMKOfflineCourseDetail:(MKOfflineCourseDetail *)offlineCourseModel
{
    NSString *text = offlineCourseModel.course_name;
    self.titleLab.attributedText = [NSString setStringSpaceWithText:text andLineSpacValue:5 andWordSpace:0 withFont:self.titleLab.font];
    self.timeConsumingLab.text =  [NSString stringWithFormat:@"%@h",offlineCourseModel.total_hour];
    self.addressLab.text = offlineCourseModel.classroom_name;
    self.attendanceLab.text = offlineCourseModel.progress;
    self.personsLab.text = [NSString stringWithFormat:@"%@人",offlineCourseModel.maximun_number];
}

- (IBAction)calendarAddHandleTarget:(UIButton *)sender {
    if (self.CourseOfflineTitleCellCalendarAddBlock) {
        self.CourseOfflineTitleCellCalendarAddBlock(sender.selected);
    }
}

@end
