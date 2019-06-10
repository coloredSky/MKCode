//
//  EmptyView.m
//  MK
//
//  Created by 周洋 on 2019/6/3.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "EmptyView.h"

@interface EmptyView()
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
        self.logoImageArr = @[@"appoinmentlist_nodata",@"appoinmentlist_nodata"];
        self.tipTextArr = @[@"看不到已预约课程？先登录试试吧！",@"您还没有预约的课程！先去参加课程吧"];
        _logoIma = [UIImageView new];
        _logoIma.frame = CGRectMake(self.width/2-134/2, self.height/2-134/2, 134, 134);
        [self addSubview:_logoIma];
        _contentLab = [UILabel new];
        _contentLab.textAlignment = NSTextAlignmentCenter;
        _contentLab.frame = CGRectMake(15, self.logoIma.bottomY+10, self.width-30, 20);
        [_contentLab setFont:K_Font_Text_Normal textColor:K_Text_BlackColor withBackGroundColor:nil];
        [self addSubview:_contentLab];
        _clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_clickBtn];
        _clickBtn.frame = CGRectMake(self.contentLab.centerX-50, self.contentLab.topY, 100, 20);
        [_clickBtn addTarget:self action:@selector(clickBtnTarget:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
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
    if (showType == 0 || showType >= self.tipTextArr.count) {
        return;
    }
    self.logoIma.image = [UIImage imageNamed:self.logoImageArr[showType-1]];
    if (showType == EmptyViewShowTypeUnknown) {
        self.contentLab.text = @"";
        self.logoIma.image = nil;
    }else if (showType == EmptyViewShowTypeAppointmentNoLogin){
        NSString *contentString = self.tipTextArr[showType-1];
        self.contentLab.attributedText = [contentString attributStrWithTargetStr:@"登录" color:K_Text_YellowColor];
    }else if (showType == EmptyViewShowTypeNoAppointment){
        self.contentLab.text = self.tipTextArr[showType-1];
    }
}

@end
