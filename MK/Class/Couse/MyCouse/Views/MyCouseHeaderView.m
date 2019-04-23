//
//  MyCouseHeaderView.m
//  MK
//
//  Created by ginluck on 2019/3/18.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MyCouseHeaderView.h"
@interface MyCouseHeaderView()
@property (weak, nonatomic) IBOutlet UIView *VideoView;
@property (weak, nonatomic) IBOutlet UILabel *VideoStatusLab;
@property (weak, nonatomic) IBOutlet UILabel *VideoTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *VideoTimeLab;
@property (weak, nonatomic) IBOutlet UIImageView *courseIma;
@property (weak, nonatomic) IBOutlet UIImageView *coursePlayIma;
@property (weak, nonatomic) IBOutlet UIImageView *lineIma;
//layout
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeightConstraints;

@end
@implementation MyCouseHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.VideoView.backgroundColor = K_BG_YellowColor;
    [_VideoTimeLab setFont:MKBoldFont(10) textColor:K_Text_grayColor withBackGroundColor:nil];
    [_VideoTitleLab setFont:MKBoldFont(12) textColor:K_Text_BlackColor withBackGroundColor:nil];
    [_VideoStatusLab setFont:MKBoldFont(14) textColor:K_Text_WhiteColor withBackGroundColor:nil];
    _lineIma.backgroundColor = K_Line_lineColor;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.lineHeightConstraints.constant = K_Line_lineWidth;
}
-(void)cellRefreshData
{
    self.lineIma.hidden = YES;
    self.courseIma.image = KImageNamed(@"timg.jpeg");
    self.coursePlayIma.image = KImageNamed(@"Course_list_play");
    self.VideoTimeLab.text = @"23:49";
    self.VideoTitleLab.text = @"语态：可能态";
    self.VideoStatusLab.text = @"继续观看";
}
@end
