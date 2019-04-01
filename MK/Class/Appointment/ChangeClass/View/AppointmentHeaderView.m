//
//  AppointmentHeaderView.m
//  MK
//
//  Created by 周洋 on 2019/3/31.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "AppointmentHeaderView.h"

@interface AppointmentHeaderView()
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *lineIma;
@end

@implementation AppointmentHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createSubView];
    }
    return self;
}
-(instancetype)init
{
    if (self = [super init]) {
        [self createSubView];
    }
    return self;
}
-(void)createSubView
{
    _lineIma = [UIImageView new];
    [self addSubview:_lineIma];
    _lineIma.backgroundColor = K_Line_lineColor;
    
    _titleLab = [UILabel new];
    [self addSubview:_titleLab];
    [_titleLab setFont:MKBoldFont(24) textColor:K_Text_BlackColor withBackGroundColor:nil];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.lineIma.frame = CGRectMake(K_Padding_Home_LeftPadding, self.height-K_Line_lineWidth, self.width-K_Padding_Home_LeftPadding*2, K_Line_lineWidth);
    self.titleLab.frame = CGRectMake(self.lineIma.leftX, self.lineIma.topY-KScaleHeight(5)-KScaleHeight(40), self.lineIma.width, KScaleHeight(40));
}

-(void)setTitleString:(NSString *)titleString
{
    self.titleLab.text = titleString;
}
@end
