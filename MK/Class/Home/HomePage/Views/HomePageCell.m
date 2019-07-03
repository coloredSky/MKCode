//
//  HomePageCell.m
//  MK
//
//  Created by 周洋 on 2019/3/14.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "HomePageCell.h"
#import "MKCourseListModel.h"
@interface HomePageCell()
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIImageView *courseIma;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLab;
@property (weak, nonatomic) IBOutlet UILabel *courseTeacherLab;
@property (weak, nonatomic) IBOutlet UILabel *coursePriceLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *courseNameLabTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *courseTeacherLabBottomContraint;

@end
@implementation HomePageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.courseNameLabTopConstraint.constant =  K_IS_IPHONE_5 ? 0:5;
    self.courseTeacherLabBottomContraint.constant =  K_IS_IPHONE_5 ? 0:-5;
    self.contentView.backgroundColor = K_BG_deepGrayColor;
    _whiteView.layer.masksToBounds = YES;
    _whiteView.layer.cornerRadius = 6;
    
    [_courseNameLab setFont:K_Font_Text_Normal textColor:K_Text_BlackColor withBackGroundColor:nil];
    [_courseTeacherLab setFont:K_Font_Text_Min_Max textColor:K_Text_grayColor withBackGroundColor:nil];
    [_coursePriceLab setFont:K_Font_Text_Large_Little textColor:K_Text_grayColor withBackGroundColor:nil];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)cellRefreshDataWithMKCourseListModel:(MKCourseListModel *)model
{
    [self.courseIma sd_setImageWithURL:[NSURL URLWithString:model.courseImage] placeholderImage:K_MKPlaceholderImage3_2];
//    .image = [UIImage imageNamed:@"home_course"];
    self.courseNameLab.text = model.courseName;
    self.courseTeacherLab.text = model.teacherNmae;
    self.coursePriceLab.text = [NSString stringWithFormat:@"%@分",model.coursePrice];
}


@end
