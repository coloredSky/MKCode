//
//  HomePageCell.m
//  MK
//
//  Created by 周洋 on 2019/3/14.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "HomePageCell.h"
@interface HomePageCell()
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIImageView *courseIma;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLab;
@property (weak, nonatomic) IBOutlet UILabel *courseTeacherLab;
@property (weak, nonatomic) IBOutlet UILabel *coursePriceLab;

@end
@implementation HomePageCell

- (void)awakeFromNib {
    [super awakeFromNib];
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
//    _whiteView.frame = CGRectMake(K_Padding_LeftPadding, KScaleHeight(15), KScreenWidth-K_Padding_LeftPadding*2, KScaleHeight(60));
//    _courseIma.frame = CGRectMake(KScaleWidth(12), <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
}

-(void)cellRefreshData
{
    self.courseIma.image = [UIImage imageNamed:@"home_course"];
    self.courseNameLab.text = @"日语基础";
    self.courseTeacherLab.text = @"冯利兵";
    self.coursePriceLab.text = @"¥1800";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
