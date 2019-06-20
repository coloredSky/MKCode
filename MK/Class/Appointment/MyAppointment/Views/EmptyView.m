//
//  EmptyView.m
//  MK
//
//  Created by 周洋 on 2019/6/3.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "EmptyView.h"
#import "MyCouseHeaderView.h"

@interface EmptyView()
@property (nonatomic, strong) MyCouseHeaderView *headerView;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *logoIma;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UIButton *clickBtn;

@property (nonatomic, strong) NSArray *logoImageArr;
@property (nonatomic, strong) NSArray *tipTextArr;
@end

@implementation EmptyView
@synthesize delegate;


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.logoImageArr = @[@"appoinmentlist_nodata",@"appoinmentlist_nodata",@"appoinmentlist_nodata",@"appoinmentlist_nodata",@"course_list_nodata",@"course_list_nodata"];
        self.tipTextArr = @[@"看不到已预约课程？先登录试试吧！",@"您还没有换班的课程!",@"您还没有请假的课程！",@"您还没有预约的课程！先去参加课程吧",@"您还没有课程！先去参加课程吧",@"无法添加我的课程！登录试试吧",];
        
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height/2-100, self.width, 200)];
        [self addSubview:_contentView];
        
        _logoIma = [UIImageView new];
        _logoIma.frame = CGRectMake(_contentView.width/2-134/2, _contentView.height/2-134/2, 134, 134);
        [_contentView addSubview:_logoIma];
        
        _contentLab = [UILabel new];
        _contentLab.textAlignment = NSTextAlignmentCenter;
        _contentLab.frame = CGRectMake(15, self.logoIma.bottomY+10, _contentView.width-30, 20);
        [_contentLab setFont:K_Font_Text_Normal textColor:K_Text_BlackColor withBackGroundColor:nil];
        [_contentView addSubview:_contentLab];
        
        _clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contentView addSubview:_clickBtn];
        _clickBtn.frame = CGRectMake(self.contentLab.centerX-50, self.contentLab.topY, 100, 20);
        [_clickBtn addTarget:self action:@selector(clickBtnTarget:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(MyCouseHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[NSBundle mainBundle]loadNibNamed:@"MyCouseHeaderView" owner:nil options:nil][0];
        _headerView.frame =CGRectMake(0, 0,KScreenWidth ,KScaleWidth(136)+KScaleHeight(60));
        [_headerView cellRefreshData];
        [self addSubview:_headerView];
    }
    return _headerView;
}

-(void)clickBtnTarget:(UIButton *)sender
{
    if ([delegate respondsToSelector:@selector(emptyViewClickTargetWithView:)]) {
        [delegate emptyViewClickTargetWithView:self];
    }
}

-(void)setShowType:(EmptyViewShowType)showType
{
    _showType = showType;
    if (showType == -1 || showType >= self.tipTextArr.count) {
        return;
    }
    self.logoIma.image = [UIImage imageNamed:self.logoImageArr[showType]];
    if (showType == EmptyViewShowTypeUnknown) {
        self.contentLab.text = @"";
        self.logoIma.image = nil;
    }else if (showType == EmptyViewShowTypeAppointmentNoLogin){
        NSString *contentString = self.tipTextArr[showType];
        self.contentLab.attributedText = [contentString attributStrWithTargetStr:@"登录" color:K_Text_YellowColor];
    }else if (showType == EmptyViewShowTypeNoAskForLeave || showType == EmptyViewShowTypeNoChangeClass || showType == EmptyViewShowTypeNoAppointment){
        self.contentLab.text = self.tipTextArr[showType];
        self.backgroundColor = K_BG_GrayColor;
    }else if (showType == EmptyViewShowTypeNoUserCourse){
        self.contentLab.text = self.tipTextArr[showType];
        self.headerView.hidden = NO;
        self.contentView.topY = self.height/2-KScaleHeight(50);
        self.backgroundColor = K_BG_WhiteColor;
    }else if (showType == EmptyViewShowTypeUserCourseNoLogin){
        NSString *contentString = self.tipTextArr[showType];
        self.contentLab.attributedText = [contentString attributStrWithTargetStr:@"登录" color:K_Text_YellowColor];
        self.headerView.hidden = NO;
        self.contentView.topY = self.height/2-KScaleHeight(50);
        self.backgroundColor = K_BG_WhiteColor;
    }
}

//-(void)EmptyViewConfigWithImage:(NSString *)contentImage signString:(NSString *)signString viewShowType:(EmptyViewShowType )showType
//{
//    self.logoIma.image = KImageNamed(contentImage);
//    if (showType == EmptyViewShowTypeAppointmentNoLogin) {
//        self.contentLab.attributedText = [signString attributStrWithTargetStr:@"登录" color:K_Text_YellowColor];
//    }else{
//        self.contentLab.text = signString;
//    }
//}

@end
