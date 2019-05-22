//
//  CourseOnlineTitleCell.m
//  MK
//
//  Created by 周洋 on 2019/3/25.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "CourseOnlineTitleCell.h"
#import "MKCourseDetailModel.h"
@interface CourseOnlineTitleCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *timeConsumingLab;//课程耗时
@property (weak, nonatomic) IBOutlet UIImageView *timeConsumingIma;
@property (weak, nonatomic) IBOutlet UILabel *personsLab;//课程人数
@property (weak, nonatomic) IBOutlet UIImageView *personsIma;
@property (weak, nonatomic) IBOutlet UIImageView *lineIma;

@end
@implementation CourseOnlineTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_titleLab setFont:K_Font_Text_Min_Max textColor:K_Text_grayColor withBackGroundColor:nil];
    _titleLab.numberOfLines = 2;
    [_likeBtn setBackgroundImage:KImageNamed(@"courseDetail_likeNormal") forState:UIControlStateNormal];
     [_likeBtn setBackgroundImage:KImageNamed(@"courseDetail_likeSelected") forState:UIControlStateSelected];
    _timeConsumingIma.image = KImageNamed(@"courseDetail_time");
    _personsIma.image = KImageNamed(@"courseDetail_Persons");
    [_timeConsumingLab setFont:K_Font_Text_Min_Max textColor:K_Text_grayColor withBackGroundColor:nil];
    [_personsLab setFont:K_Font_Text_Min_Max textColor:K_Text_grayColor withBackGroundColor:nil];
    _lineIma.backgroundColor = K_Line_lineColor;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLab.frame = CGRectMake(KScaleWidth(20), KScaleHeight(10), self.contentView.width-KScaleWidth(40)-KScaleWidth(36)-15, 40);
    self.likeBtn.frame = CGRectMake(self.contentView.width-KScaleWidth(20)-KScaleWidth(36), self.titleLab.centerY-KScaleWidth(18),KScaleWidth(36), KScaleWidth(36));
    self.bottomView.frame = CGRectMake(0, self.titleLab.bottomY, self.contentView.width, self.contentView.height-self.titleLab.bottomY);
    self.timeConsumingIma.frame = CGRectMake(self.titleLab.leftX, self.bottomView.height/2-KScaleWidth(6), KScaleWidth(12), KScaleWidth(12));
    self.timeConsumingLab.frame = CGRectMake(self.timeConsumingIma.rightX+5, self.timeConsumingIma.centerY-KScaleHeight(10), KScaleWidth(40), KScaleHeight(20));
    self.personsIma.frame = CGRectMake(self.timeConsumingLab.rightX, self.timeConsumingIma.topY, self.timeConsumingIma.width, self.timeConsumingIma.height);
    self.personsLab.frame = CGRectMake(self.personsIma.rightX+5, self.timeConsumingLab.topY, self.timeConsumingLab.width, self.timeConsumingLab.height);
    self.lineIma.frame = CGRectMake(KScaleWidth(20), self.bottomView.height-K_Line_lineWidth, self.bottomView.width-KScaleWidth(20*2), K_Line_lineWidth);
}

-(void)cellRefreshDataWithCourseDetailModel:(MKCourseDetailModel *)courseDetailMode
{
    NSString *text = [NSString filterHTML:courseDetailMode.courseInfoDetail.courseDetail];
    self.titleLab.attributedText = [NSString setStringSpaceWithText:text andLineSpacValue:5 andWordSpace:0 withFont:self.titleLab.font];
    self.timeConsumingLab.text = [NSString stringWithFormat:@"%@h",courseDetailMode.courseInfoDetail.courseConsumingTime];
    self.personsLab.text = @"00人";
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
