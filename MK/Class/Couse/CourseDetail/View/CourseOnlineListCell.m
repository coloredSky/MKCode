//
//  CourseOnlineListCell.m
//  MK
//
//  Created by 周洋 on 2019/3/25.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "CourseOnlineListCell.h"
@interface CourseOnlineListCell()
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedLeftIma;//选中播放 右侧展示图
@property (weak, nonatomic) IBOutlet UIImageView *playIma;//播放Ima
@property (weak, nonatomic) IBOutlet UIImageView *courseIma;//课程介绍图
@property (weak, nonatomic) IBOutlet UILabel *courseNumLab;//课程编号
@property (weak, nonatomic) IBOutlet UILabel *courseNameLab;//课程名字
@property (weak, nonatomic) IBOutlet UILabel *courseTimeLab;//课程时间

@end
@implementation CourseOnlineListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectedLeftIma.backgroundColor = K_BG_blackColor;
    self.whiteView.backgroundColor = K_BG_deepGrayColor;
    self.playIma.image = KImageNamed(@"courseDetail_play");
    [self.courseNumLab setFont:K_Font_Text_Normal textColor:K_Text_grayColor withBackGroundColor:nil];
    [self.courseNameLab setFont:K_Font_Text_Min_Max textColor:K_Text_BlackColor withBackGroundColor:nil];
    [self.courseTimeLab setFont:K_Font_Text_Min textColor:K_Text_grayColor withBackGroundColor:nil];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.whiteView.frame = CGRectMake(K_Padding_LeftPadding, 0, self.contentView.width-K_Padding_LeftPadding*2, self.contentView.height-KScaleHeight(5));
    self.selectedLeftIma.frame = CGRectMake(0, 0, KScaleWidth(4), self.whiteView.height);
    self.playIma.frame = CGRectMake(self.whiteView.height/2-KScaleWidth(10), self.whiteView.height/2-KScaleWidth(10), KScaleWidth(20), KScaleWidth(20));
    self.courseNumLab.frame = CGRectMake(self.playIma.leftX, self.playIma.centerY-KScaleHeight(10), KScaleWidth(40), KScaleHeight(20));
    self.courseIma.frame = CGRectMake(self.whiteView.height, 0, self.whiteView.height*3/2, self.whiteView.height);
    self.courseNameLab.frame = CGRectMake(self.courseIma.rightX+KScaleWidth(13), 0, self.whiteView.width-self.courseIma.rightX-KScaleWidth(13), self.whiteView.height/2);
    self.courseTimeLab.frame = CGRectMake(self.courseNameLab.leftX, self.courseNameLab.bottomY, self.courseNameLab.width, self.courseNameLab.height);
    
}

-(void)cellRefreshWithData:(BOOL )selected
{
    self.courseIma.image = KImageNamed(@"coursedetail_list");
    self.courseNameLab.text = @"语态：可能态";
    self.courseTimeLab.text = @"23:34";
    if (selected) {
        self.whiteView.backgroundColor = K_BG_YellowColor;
        self.courseNumLab.hidden = YES;
    }else{
        self.whiteView.backgroundColor = K_BG_deepGrayColor;
        self.selectedLeftIma.hidden = YES;
        self.playIma.hidden = YES;
        self.courseNumLab.text = @"1.";
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
