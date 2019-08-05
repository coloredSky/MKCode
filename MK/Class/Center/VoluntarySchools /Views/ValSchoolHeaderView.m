//
//  ValSchoolHeaderView.m
//  MK
//
//  Created by zhouyang on 2019/8/3.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "ValSchoolHeaderView.h"

@interface ValSchoolHeaderView()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *divisionBtn;//学部按钮
@property(nonatomic,strong)UIButton *collegeBtn;//大学院按钮
@property(nonatomic,strong)UIButton *selectedBtn;
@end

@implementation ValSchoolHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        NSArray *titleArr = @[@"学部",@"大学院",];
        for (int i = 0; i < 2; i++) {
            UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:clickBtn];
            clickBtn.frame = CGRectMake(K_Padding_Home_LeftPadding+(76+10)*i, self.height-10-30, 76, 30);
            [clickBtn setNormalTitle:titleArr[i] font:MKFont(14) titleColor:K_Text_grayColor];
            [clickBtn setSelectedTitle:titleArr[i] titleColor:K_Text_WhiteColor];
            clickBtn.layer.masksToBounds = YES;
            clickBtn.layer.cornerRadius = 6;
            clickBtn.layer.borderColor = K_Line_lineColor.CGColor;
            clickBtn.layer.borderWidth = K_Line_lineWidth;
            [clickBtn setBackgroundImage:KImageNamed(@"schoole_gray_bg") forState:UIControlStateSelected];
            [clickBtn setBackgroundImage:KImageNamed(@"schoole_white_bg") forState:UIControlStateNormal];
            clickBtn.tag = i+1;
            [clickBtn addTarget:self action:@selector(clickTarget:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                clickBtn.selected = YES;
                self.selectedBtn = clickBtn;
                _divisionBtn = clickBtn;
            }else{
                _collegeBtn = clickBtn;
            }
        }
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(_divisionBtn.leftX, _divisionBtn.topY-10-20, 120, 20)];
        [self addSubview:_titleLab];
        [_titleLab setFont:MKFont(13) textColor:UIColorFromRGB_0x(0x707070) withBackGroundColor:[UIColor clearColor]];
        _titleLab.text = @"";
    }
    return self;
}

-(void)valSchoolHeaderViewReloadDataWithTitle:(NSString *)title headerViewShowType:(ValSchoolHeaderViewShowType )type
{
    self.titleLab.text = title;
    if (type == ValSchoolHeaderViewShowTypeDivision) {
        self.collegeBtn.selected = NO;
        self.divisionBtn.selected = YES;
        self.selectedBtn = self.divisionBtn;
    }else{
        self.collegeBtn.selected = YES;
        self.divisionBtn.selected = NO;
        self.selectedBtn = self.collegeBtn;
    }
}

-(void)clickTarget:(UIButton *)sender
{
    if (self.selectedBtn == sender) {
        return;
    }
    sender.selected = YES;
    self.selectedBtn.selected = NO;
    self.selectedBtn = sender;
    if (self.schoolHeaderViewBlock) {
        ValSchoolHeaderViewOperationType type = ValSchoolHeaderViewOperationTypeDivision;
        if (sender.tag == 2) {
            type = ValSchoolHeaderViewOperationTypeCollege;
        }
        self.schoolHeaderViewBlock(type);
    }
    
}

@end
