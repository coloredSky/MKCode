//
//  AskForLeaveViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/31.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "AskForLeaveViewController.h"
//View
#import "AppointmentHeaderView.h"
#import "AppointmentTapView.h"
//category
#import "UITextView+WJPlaceholder.h"

@interface AskForLeaveViewController ()<XDSDropDownMenuDelegate,AppointmentTapViewDelegate>
@property (nonatomic, strong) MKBaseScrollView *contentScroll;
@property (nonatomic, strong) AppointmentHeaderView *headerView;
@property (nonatomic, strong) UITextView *reasonTextView;
@property (nonatomic, strong) NSArray *tipStringArr;

//下拉
@property (nonatomic, strong) XDSDropDownMenu *classsDownMenu;//班级
@property (nonatomic, strong) XDSDropDownMenu *courseDownMenu;//休息的课程
@property (nonatomic, strong) NSArray *downMenuArr;//装载下拉控件
@property (nonatomic, strong) NSMutableArray *tapViewArr;//装载点击控件
@property (nonatomic, strong) NSArray *classArr;
@property (nonatomic, strong) NSArray *courseArr;
@end

@implementation AskForLeaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_YellowColor;
    [self initData];
    [self creatSubVuew];
}
-(void)initData
{
    self.downMenuArr = @[self.classsDownMenu,self.courseDownMenu];
    self.tapViewArr = [NSMutableArray arrayWithCapacity:2];
    self.classArr = @[@"美术A班",@"美术A班",@"美术A班",@"美术A班",@"美术A班",@"美术A班",@"美术A班",@"美术A班"];
    self.courseArr = @[@"第一课时",@"第一课时"];
}
-(void)creatSubVuew
{
    [self.view addSubview:self.contentScroll];
    [self.contentScroll addSubview:self.headerView];
    [self.contentScroll addSubview:self.reasonTextView];
}

#pragma mark --  lazy
-(XDSDropDownMenu *)classsDownMenu
{
    if (!_classsDownMenu) {
        _classsDownMenu = [[XDSDropDownMenu alloc]init];
        _classsDownMenu.delegate = self;
    }
    return _classsDownMenu;
}
-(XDSDropDownMenu *)courseDownMenu
{
    if (!_courseDownMenu) {
        _courseDownMenu = [[XDSDropDownMenu alloc]init];
        _courseDownMenu.delegate = self;
    }
    return _courseDownMenu;
}
-(NSArray *)tipStringArr
{
    if (!_tipStringArr) {
        _tipStringArr = @[@"XXX班",@"选择要休息的课程"];
    }
    return _tipStringArr;
}
-(MKBaseScrollView *)contentScroll
{
    if (!_contentScroll) {
        _contentScroll = [[MKBaseScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        _contentScroll.backgroundColor = K_BG_YellowColor;
        //
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(K_Padding_Home_LeftPadding, self.reasonTextView.bottomY+KScaleHeight(20), 200, KScaleHeight(20))];
        [self.contentScroll addSubview:titleLab];
        [titleLab setFont:K_Font_Text_Normal textColor:K_Text_grayColor withBackGroundColor:nil];
        titleLab.text = @"请假课程";
        
        for (int i=0; i < self.tipStringArr.count; i++) {
            AppointmentTapView *tapView = [AppointmentTapView new];
            [self.tapViewArr addObject:tapView];
            tapView.delegate = self;
            tapView.tag = i+1;
            CGFloat tapViewY = tapViewY = titleLab.bottomY+ KScaleHeight(13)+(KScaleHeight(33+15)*i);
            tapView.frame =  CGRectMake(K_Padding_Home_LeftPadding, tapViewY, KScreenWidth-K_Padding_Home_LeftPadding*2, KScaleHeight(33));
            tapView.textString = self.tipStringArr[i];
            [self.contentScroll addSubview:tapView];
            //底部按钮
            if (i == self.tipStringArr.count-1) {
                UIButton *submitBtn = [UIButton getBottomBtnWithBtnX:tapView.leftX btnY:tapView.bottomY+KScaleHeight(130) btnTitle:@"发送"];
                [self.contentScroll addSubview:submitBtn];
            }
        }
    }
    return  _contentScroll;
}
-(AppointmentHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[AppointmentHeaderView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleHeight(86)+K_NaviHeight)];;
        if (self.operationType == AskForLeaveOperationTypeNew) {
            _headerView.titleString = @"请假申请";
        }else{
            _headerView.titleString = @"修改申请";
        }
    }
    return _headerView;
}
-(UITextView *)reasonTextView
{
    if (!_reasonTextView) {
        _reasonTextView = [[UITextView alloc]initWithFrame:CGRectMake(K_Padding_Home_LeftPadding, self.headerView.bottomY+KScaleHeight(30), KScreenWidth-K_Padding_Home_LeftPadding*2, KScaleHeight(122))];
        _reasonTextView.backgroundColor = K_BG_blackColor;
        _reasonTextView.layer.masksToBounds = YES;
        _reasonTextView.layer.cornerRadius = KScaleWidth(8);
        _reasonTextView.textColor = K_Text_WhiteColor;
        _reasonTextView.font = K_Font_Text_Normal;
        _reasonTextView.placeholder = @"理由";
        _reasonTextView.placeholdFont = K_Font_Text_Normal;
        _reasonTextView.placeholderColor = K_Text_DeepGrayColor;
    }
    return _reasonTextView;
}

#pragma mark --  EVENT
#pragma mark --  下拉表出现
-(void)appointmentTapViewTapClickWithView:(AppointmentTapView *)tapView
{
    if (tapView.tag == 1) {//原有班级
        //初始化选择菜单
        [self showDropDownMenuWithView:tapView withTapViewFrame:tapView.frame downMenu:self.classsDownMenu titleArr:self.classArr];
    }else{
        //更改后的班级
        [self showDropDownMenuWithView:tapView withTapViewFrame:tapView.frame downMenu:self.courseDownMenu titleArr:self.courseArr];
    }
}
#pragma mark --  下拉表点击
-(void)XDSDropDownMenu:(XDSDropDownMenu *)downMenuView didSelectedWithIndex:(NSInteger )index
{
    if (downMenuView == self.classsDownMenu) {
        AppointmentTapView *tapView = self.tapViewArr[0];
        tapView.textString = self.classArr[index];
    }else{
        AppointmentTapView *tapView = self.tapViewArr[1];
        tapView.textString = self.courseArr[index];
    }
}

-(void)showDropDownMenuWithView:(AppointmentTapView *)tapView withTapViewFrame:(CGRect )tapViewFrame downMenu:(XDSDropDownMenu *)downMenue titleArr:(NSArray *)titleArr
{
    for (int i=0; i<self.downMenuArr.count; i++) {
        XDSDropDownMenu *menu = self.downMenuArr[i];
        AppointmentTapView *clickView = self.tapViewArr[i];
        if (menu != downMenue) {
            [menu hideDropDownMenuWithBtnFrame:clickView.frame];
        }
    }
    if (downMenue.isShow ==NO) {
        [downMenue showDropDownMenu:tapView withTapViewFrame:tapView.frame arrayOfTitle:titleArr arrayOfImage:nil animationDirection:@"down"];
        //添加到主视图上
        [self.view addSubview:downMenue];
    }else{
        [downMenue  hideDropDownMenuWithBtnFrame:tapView.frame];
    }
}
@end
