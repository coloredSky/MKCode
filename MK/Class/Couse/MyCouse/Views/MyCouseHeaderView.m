//
//  MyCouseHeaderView.m
//  MK
//
//  Created by ginluck on 2019/3/18.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MyCouseHeaderView.h"
#import "MKCourseListModel.h"

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

@property (weak, nonatomic) IBOutlet UIImageView *timeIma;
@property (weak, nonatomic) IBOutlet UILabel *tipLab;

@end
@implementation MyCouseHeaderView
@synthesize delegate;

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
    
    [_tipLab setFont:MKBoldFont(15) textColor:K_Text_WhiteColor withBackGroundColor:nil];
    self.tipLab.text = @"";
    
    _courseIma.userInteractionEnabled = YES;
    [_courseIma addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userCoursePlay:)]];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.lineHeightConstraints.constant = K_Line_lineWidth;
}

-(void)userCourseHeaderViewRefreshDataWithMKCourseListModel:(nullable MKCourseListModel *)courseListModel
{
    if (!courseListModel) {
        self.tipLab.text = @"还没有观看视频";
        self.VideoTitleLab.hidden = YES;
        self.lineIma.hidden = YES;
        self.courseIma.hidden = YES;
        self.coursePlayIma.hidden = YES;
        self.VideoStatusLab.hidden = YES;
        self.VideoTimeLab.hidden = YES;
    }else{
        self.VideoTitleLab.hidden = NO;
        self.lineIma.hidden = NO;
        self.courseIma.hidden = NO;
        self.coursePlayIma.hidden = NO;
        self.VideoStatusLab.hidden = NO;
        self.VideoTimeLab.hidden = NO;
        
        [self.courseIma sd_setImageWithURL:[NSURL URLWithString:courseListModel.courseImage] placeholderImage:K_MKPlaceholderImage3_2];
            self.coursePlayIma.image = KImageNamed(@"Course_list_play");
            self.VideoTimeLab.text = courseListModel.view_time;
            self.VideoTitleLab.text = [NSString stringWithFormat:@"%@-%@",courseListModel.courseName,courseListModel.video_name];
            self.VideoStatusLab.text = @"继续观看";
    }
}

-(void)userCoursePlay:(UITapGestureRecognizer *)tap
{
    if ([delegate respondsToSelector:@selector(userCouseHeaderViewVideoPlay)]) {
        [delegate userCouseHeaderViewVideoPlay];
    }
}

@end
