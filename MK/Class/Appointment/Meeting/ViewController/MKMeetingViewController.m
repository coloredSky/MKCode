//
//  MKMeetingViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/31.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKMeetingViewController.h"
//View
#import "AppointmentHeaderView.h"
#import "AppointmentTapView.h"

@interface MKMeetingViewController ()<XDSDropDownMenuDelegate,AppointmentTapViewDelegate>
@property (nonatomic, strong) MKBaseScrollView *contentScroll;
@property (nonatomic, strong) AppointmentHeaderView *headerView;
@property (nonatomic, strong) NSArray *tipStringArr;


//下拉
@property (nonatomic, strong) XDSDropDownMenu *purposeDownMenu;//目的选择
@property (nonatomic, strong) XDSDropDownMenu *teacherDownMenu;//相谈老师选择
@property (nonatomic, strong) NSArray *downMenuArr;//装载下拉控件
@property (nonatomic, strong) NSMutableArray *tapViewArr;//装载点击控件
@property (nonatomic, strong) NSArray *purposeArr;
@property (nonatomic, strong) NSArray *teacherArr;
@end

@implementation MKMeetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_YellowColor;
    [self initData];
}
-(void)initData
{
    self.downMenuArr = @[self.purposeDownMenu,self.teacherDownMenu];
    self.tapViewArr = [NSMutableArray arrayWithCapacity:2];
    self.purposeArr = @[@"心理辅导",@"心理辅导",@"心理辅导",@"心理辅导",@"心理辅导"];
    self.teacherArr = @[@"王大锤",@"王大锤",@"王大锤"];
}

#pragma mark --  lazy
-(XDSDropDownMenu *)purposeDownMenu
{
    if (!_purposeDownMenu) {
        _purposeDownMenu = [[XDSDropDownMenu alloc]init];
        _purposeDownMenu.delegate = self;
    }
    return _purposeDownMenu;
}
-(XDSDropDownMenu *)teacherDownMenu
{
    if (!_teacherDownMenu) {
        _teacherDownMenu = [[XDSDropDownMenu alloc]init];
        _teacherDownMenu.delegate = self;
    }
    return _teacherDownMenu;
}
-(NSArray *)tipStringArr
{
    if (!_tipStringArr) {
        _tipStringArr = @[@"目的选择",@"相谈老师填写",@"希望时间选择1",@"希望时间选择2",@"希望时间选择3"];
    }
    return _tipStringArr;
}
-(MKBaseScrollView *)contentScroll
{
    if (!_contentScroll) {
        _contentScroll = [MKBaseScrollView new];
        [self.view addSubview:_contentScroll];
        _contentScroll.backgroundColor = K_BG_YellowColor;
        //
        for (int i=0; i < self.tipStringArr.count; i++) {
            AppointmentTapView *tapView = [AppointmentTapView new];
            tapView.delegate = self;
            CGFloat tapViewY = 0;
            tapView.tag = i+1;
            if (i < 2) {
                tapViewY = KScaleHeight(86)+K_NaviHeight+KScaleHeight(35)+(KScaleHeight(33+15)*i);
                [self.tapViewArr addObject:tapView];
            }else{
                tapViewY = KScaleHeight(86)+K_NaviHeight+KScaleHeight(35)+KScaleHeight(20)+(KScaleHeight(33+15)*i);
            }
            if (i == 1) {
                tapView.normalColor = K_Text_grayColor;
            }
            tapView.frame =  CGRectMake(K_Padding_Home_LeftPadding, tapViewY, KScreenWidth-K_Padding_Home_LeftPadding*2, KScaleHeight(33));
            tapView.textString = self.tipStringArr[i];
            [self.contentScroll addSubview:tapView];
            
            if (i == self.tipStringArr.count-1) {
                UIButton *submitBtn = [UIButton getBottomBtnWithBtnX:tapView.leftX btnY:tapView.bottomY+KScaleHeight(80) btnTitle:@"发送"];
                [self.contentScroll addSubview:submitBtn];
            }
        }
    }
    return  _contentScroll;
}
-(AppointmentHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [AppointmentHeaderView new];
        if (self.operationType == MeetingOperationTypeNew) {
            _headerView.titleString = @"新建预约";
        }else{
            _headerView.titleString = @"修改申请";
        }
        [self.contentScroll addSubview:_headerView];
    }
    return _headerView;
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.contentScroll.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    self.headerView.frame = CGRectMake(0, 0, KScreenWidth, KScaleHeight(86)+K_NaviHeight);
}

#pragma mark --  EVENT
#pragma mark --  下拉表出现
-(void)appointmentTapViewTapClickWithView:(AppointmentTapView *)tapView
{
    if (tapView.tag <= 2) {
        if (tapView.tag == 1) {//原有班级
            //初始化选择菜单
            [self showDropDownMenuWithView:tapView withTapViewFrame:tapView.frame downMenu:self.purposeDownMenu titleArr:self.purposeArr];
        }else{
            //更改后的班级
            [self showDropDownMenuWithView:tapView withTapViewFrame:tapView.frame downMenu:self.teacherDownMenu titleArr:self.teacherArr];
        }
    }
}
#pragma mark --  下拉表点击
-(void)XDSDropDownMenu:(XDSDropDownMenu *)downMenuView didSelectedWithIndex:(NSInteger )index
{
    if (downMenuView == self.purposeDownMenu) {
        AppointmentTapView *tapView = self.tapViewArr[0];
        tapView.textString = self.purposeArr[index];
    }else{
        AppointmentTapView *tapView = self.tapViewArr[1];
        tapView.textString = self.teacherArr[index];
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
