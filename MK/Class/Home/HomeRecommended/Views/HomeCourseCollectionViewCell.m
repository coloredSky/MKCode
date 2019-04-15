//
//  HomeCourseCollectionViewCell.m
//  MK
//
//  Created by 周洋 on 2019/3/19.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "HomeCourseCollectionViewCell.h"
@interface HomeCourseCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIImageView *courseIma;
@property (weak, nonatomic) IBOutlet UILabel *courseTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *courseTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *courseTimeLab;
@property (weak, nonatomic) IBOutlet UIImageView *typeIma;

@end

@implementation HomeCourseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.shadowView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.shadowView.layer.shadowColor = K_Text_DeepGrayColor.CGColor;
    self.shadowView.layer.shadowRadius = 3.0f;
    self.shadowView.layer.shadowOffset = CGSizeMake(2, 2);
    self.shadowView.layer.shadowOpacity = .5;
    
    self.whiteView.layer.masksToBounds = YES;
    self.whiteView.layer.cornerRadius = 8;
    [self.courseTitleLab setFont:K_Font_Text_Min_Max textColor:K_Text_grayColor withBackGroundColor:nil];
    [self.courseTimeLab setFont:K_Font_Text_Min textColor:K_Text_grayColor withBackGroundColor:nil];
    [self.courseTypeLab setFont:K_Font_Text_Min textColor:K_Text_grayColor withBackGroundColor:nil];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.shadowView.frame = CGRectMake(5, 5, self.contentView.width-10, self.contentView.height-10);
//    self.contentView.backgroundColor = [UIColor redColor];
//    self.shadowView.backgroundColor = [UIColor blueColor];
    self.whiteView.frame = CGRectMake(0, 0, self.shadowView.width, self.shadowView.height);
    self.courseIma.frame = CGRectMake(10, 10, KScaleWidth(70), KScaleWidth(70));
    self.courseTypeLab.frame = CGRectMake(self.courseIma.rightX+KScaleWidth(10), self.courseIma.centerY-9, self.whiteView.width-self.courseTypeLab.leftX-KScaleWidth(10), 18);
    self.courseTitleLab.frame = CGRectMake(self.courseTypeLab.leftX, self.courseTypeLab.topY-18, self.courseTypeLab.width, self.courseTypeLab.height);
    self.courseTimeLab.frame = CGRectMake(self.courseTypeLab.leftX, self.courseTypeLab.bottomY, self.courseTypeLab.width, self.courseTypeLab.height);
    self.typeIma.frame = CGRectMake(self.whiteView.width-10-24, 0, 24, 24);
}

-(void)cellRefreshData
{
    self.courseIma.image = KImageNamed(@"home_collection");
    self.courseTitleLab.text = @"日语基础";
    self.courseTypeLab.text = @"语态：可能态";
    self.courseTimeLab.text = @"02-27 10:00-12:00";
    self.typeIma.image = KImageNamed(@"homeCourse_live");
}
@end
