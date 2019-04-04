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
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *editBtn;
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
    
    _editBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_editBtn];
    [_editBtn setImage:KImageNamed(@"") forState:UIControlStateNormal];
    _editBtn.backgroundColor = K_BG_blackColor;
    _editBtn.hidden = YES;
    [_editBtn addTarget:self action:@selector(senderTarget:) forControlEvents:UIControlEventTouchUpInside];
    _editBtn.tag = 0;
    
    _deleteBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_deleteBtn];
    [_deleteBtn setImage:KImageNamed(@"") forState:UIControlStateNormal];
    _deleteBtn.backgroundColor = K_BG_blackColor;
    _deleteBtn.hidden = YES;
    [_deleteBtn addTarget:self action:@selector(senderTarget:) forControlEvents:UIControlEventTouchUpInside];
    _deleteBtn.tag = 1;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.lineIma.frame = CGRectMake(K_Padding_Home_LeftPadding, self.height-K_Line_lineWidth, self.width-K_Padding_Home_LeftPadding*2, K_Line_lineWidth);
    self.titleLab.frame = CGRectMake(self.lineIma.leftX, self.lineIma.topY-KScaleHeight(5)-KScaleHeight(40), self.lineIma.width, KScaleHeight(40));
    self.editBtn.frame = CGRectMake(self.width-K_Padding_Home_LeftPadding-KScaleWidth(22), self.titleLab.centerY-KScaleWidth(11), KScaleWidth(22), KScaleWidth(22));
    self.deleteBtn.frame = CGRectMake(self.editBtn.leftX-KScaleWidth(40)-self.editBtn.width, self.editBtn.topY, self.editBtn.width, self.editBtn.height);
}

-(void)setTitleString:(NSString *)titleString
{
    self.titleLab.text = titleString;
}

-(void)setShowType:(AppointmentHeaderViewShowType)showType
{
    if (showType == AppointmentHeaderViewShowTypeNormal) {
        self.deleteBtn.hidden = YES;
        self.editBtn.hidden = YES;
    }else{
        self.deleteBtn.hidden = NO;
        self.editBtn.hidden = NO;
    }
}

-(void)senderTarget:(UIButton *)sender
{
    if (self.operationBlock) {
        self.operationBlock(sender.tag);
    }
}
@end
