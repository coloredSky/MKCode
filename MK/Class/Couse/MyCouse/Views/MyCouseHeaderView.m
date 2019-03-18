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
    [_VideoTimeLab setFont:MKBoldFont(10) textColor:K_Text_grayColor withBackGroundColor:nil];
    [_VideoTitleLab setFont:MKBoldFont(13) textColor:K_Text_BlackColor withBackGroundColor:nil];
    [_VideoStatusLab setFont:MKBoldFont(14) textColor:K_Text_WhiteColor withBackGroundColor:nil];

}

-(void)cellRefreshData
{
    self.VideoTimeLab.text = @"23:49";
    self.VideoTitleLab.text = @"语态：可能态";
    self.VideoStatusLab.text = @"继续观看";
}
@end
