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
//Manager
#import "MakeMeetingManager.h"

#import "MakeMeetingModel.h"
#import "AppointmentListModel.h"

@interface MKMeetingViewController ()<XDSDropDownMenuDelegate,AppointmentTapViewDelegate>
@property (nonatomic, strong) MKBaseScrollView *contentScroll;
@property (nonatomic, strong) AppointmentHeaderView *headerView;
//下拉
@property (nonatomic, strong) NSMutableArray *tipStringArr;
@property (nonatomic, strong)AppointmentTapView *teacherTapView;
@property (nonatomic, strong) XDSDropDownMenu *purposeDownMenu;//目的选择
@property (nonatomic, strong) XDSDropDownMenu *time1DownMenu;//时间选择
@property (nonatomic, strong) XDSDropDownMenu *time2DownMenu;//时间选择
@property (nonatomic, strong) XDSDropDownMenu *time3DownMenu;//时间选择

@property (nonatomic, strong) NSArray *downMenuArr;//装载下拉控件
@property (nonatomic, strong) NSMutableArray *tapViewArr;//装载点击控件



@property (nonatomic, strong) MakeMeetingModel *meetingModel;

@end

@implementation MKMeetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_YellowColor;
    self.downMenuArr = @[self.purposeDownMenu,self.time1DownMenu,self.time2DownMenu,self.time3DownMenu];
    [self startRequest];
}

-(void)startRequest
{
    [MBHUDManager showLoading];
    [MakeMeetingManager callBackMeetingPurposeListWithCompletionBlock:^(BOOL isSuccess, NSArray<NSDictionary *> * _Nonnull purposeList, NSArray <NSString *>*purposeStringList, NSString * _Nonnull message) {
        [MBHUDManager hideAlert];
        if (isSuccess) {
            self.meetingModel.purposeList  = purposeList;
            self.meetingModel.purposeStringList = purposeStringList;
            if (self.operationType == MeetingOperationTypeEdit) {
                self.meetingModel.teacherName = self.appointmentModel.staff_name;
                for (NSDictionary *dic in purposeList) {
                    if ([dic[@"name"] isEqualToString:self.appointmentModel.type]) {
                        self.meetingModel.purposeType = [dic[@"id"] integerValue];
                        self.meetingModel.purposeString = dic[@"name"];
                    }
                }
            }
        }
    }];
    
    [MBHUDManager showLoading];
    [MakeMeetingManager callBackMeetingTimeListWithCompletionBlock:^(BOOL isSuccess, NSArray<NSString *> * _Nonnull time1List, NSArray<NSString *> * _Nonnull time2List, NSArray<NSString *> * _Nonnull time3List, NSString * _Nonnull message) {
        [MBHUDManager hideAlert];
        if (isSuccess) {
            self.meetingModel.time1List = time1List;
            self.meetingModel.time2List = time2List;
            self.meetingModel.time3List = time3List;
        }
    }];
}

#pragma mark --  lazy
-(NSMutableArray *)tapViewArr
{
    if (!_tapViewArr) {
        _tapViewArr = [NSMutableArray arrayWithCapacity:4];
    }
    return _tapViewArr;
}

-(MakeMeetingModel *)meetingModel
{
    if (!_meetingModel) {
        _meetingModel = [MakeMeetingModel new];
        if (self.operationType == MeetingOperationTypeEdit) {
            self.meetingModel.meetingTime1 = self.appointmentModel.select_time_one;
            self.meetingModel.meetingTime2 = self.appointmentModel.select_time_two;
            self.meetingModel.meetingTime3 = self.appointmentModel.select_time_three;
        }
    }
    return _meetingModel;
}

-(NSMutableArray *)tipStringArr
{
    if (!_tipStringArr) {
        if (self.operationType == MeetingOperationTypeNew) {
            _tipStringArr = @[@"目的选择",@"相谈老师填写",@"希望时间选择1",@"希望时间选择2",@"希望时间选择3"].mutableCopy;
        }else{
           _tipStringArr = [NSMutableArray arrayWithCapacity:5];
            [_tipStringArr addObject:self.appointmentModel.type];
            [_tipStringArr addObject:self.appointmentModel.staff_name];
            [_tipStringArr addObject:self.appointmentModel.show_time_one];
            [_tipStringArr addObject:self.appointmentModel.show_time_two];
            [_tipStringArr addObject:self.appointmentModel.show_time_three];
        }
        
    }
    return _tipStringArr;
}
-(XDSDropDownMenu *)purposeDownMenu
{
    if (!_purposeDownMenu) {
        _purposeDownMenu = [[XDSDropDownMenu alloc]init];
        _purposeDownMenu.delegate = self;
    }
    return _purposeDownMenu;
}
-(XDSDropDownMenu *)time1DownMenu
{
    if (!_time1DownMenu) {
        _time1DownMenu = [[XDSDropDownMenu alloc]init];
        _time1DownMenu.delegate = self;
    }
    return _time1DownMenu;
}
-(XDSDropDownMenu *)time2DownMenu
{
    if (!_time2DownMenu) {
        _time2DownMenu = [[XDSDropDownMenu alloc]init];
        _time2DownMenu.delegate = self;
    }
    return _time2DownMenu;
}
-(XDSDropDownMenu *)time3DownMenu
{
    if (!_time3DownMenu) {
        _time3DownMenu = [[XDSDropDownMenu alloc]init];
        _time3DownMenu.delegate = self;
    }
    return _time3DownMenu;
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
            }else{
                tapViewY = KScaleHeight(86)+K_NaviHeight+KScaleHeight(35)+KScaleHeight(20)+(KScaleHeight(33+15)*i);
            }
            if (i == 1) {
                tapView.canEditing = YES;
                tapView.placeholderString = self.tipStringArr[i];
                self.teacherTapView = tapView;
            }else{
                tapView.textString = self.tipStringArr[i];
                [self.tapViewArr addObject:tapView];
            }
            tapView.frame =  CGRectMake(K_Padding_Home_LeftPadding, tapViewY, KScreenWidth-K_Padding_Home_LeftPadding*2, KScaleHeight(33));
            [self.contentScroll addSubview:tapView];
            
            if (i == self.tipStringArr.count-1) {
                UIButton *submitBtn = [UIButton getBottomBtnWithBtnX:tapView.leftX btnY:tapView.bottomY+KScaleHeight(80) btnTitle:@"发送"];
                [submitBtn addTarget:self action:@selector(submitTarget:) forControlEvents:UIControlEventTouchUpInside];
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
    if (tapView.tag != 2) {
        if (tapView.tag == 1) {//目的选择
            //初始化选择菜单
            [self showDropDownMenuWithView:tapView withTapViewFrame:tapView.frame downMenu:self.purposeDownMenu titleArr:self.meetingModel.purposeStringList];
        }else if(tapView.tag == 3){
            //时间选择1
            [self showDropDownMenuWithView:tapView withTapViewFrame:tapView.frame downMenu:self.time1DownMenu titleArr:self.meetingModel.time1List];
        }else if(tapView.tag == 4){
            //时间选择2
            [self showDropDownMenuWithView:tapView withTapViewFrame:tapView.frame downMenu:self.time2DownMenu titleArr:self.meetingModel.time2List];
        }else if(tapView.tag == 5){
            //时间选择3
            [self showDropDownMenuWithView:tapView withTapViewFrame:tapView.frame downMenu:self.time3DownMenu titleArr:self.meetingModel.time3List];
        }
    }
}
#pragma mark --  下拉表点击
-(void)dropDownMenu:(XDSDropDownMenu *)downMenuView didSelectedWithIndex:(NSInteger )index
{
    if (downMenuView == self.purposeDownMenu) {
        AppointmentTapView *tapView = self.tapViewArr[0];
        tapView.textString = self.meetingModel.purposeStringList[index];
        self.meetingModel.purposeString = tapView.textString;
        NSDictionary *purposeDic = self.meetingModel.purposeList[index];
        self.meetingModel.purposeType = [purposeDic[@"id"] integerValue];
    }else if (downMenuView == self.time1DownMenu) {
        AppointmentTapView *tapView = self.tapViewArr[1];
        tapView.textString = self.meetingModel.time1List[index];
        self.meetingModel.meetingTime1 = tapView.textString;
    }else if (downMenuView == self.time2DownMenu) {
        AppointmentTapView *tapView = self.tapViewArr[2];
        tapView.textString = self.meetingModel.time2List[index];
        self.meetingModel.meetingTime2 = tapView.textString;
    }else if (downMenuView == self.time3DownMenu) {
        AppointmentTapView *tapView = self.tapViewArr[3];
        tapView.textString = self.meetingModel.time3List[index];
        self.meetingModel.meetingTime3 = tapView.textString;
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

#pragma mark --  提交
-(void)submitTarget:(UIButton *)sender
{
    if (self.operationType == MeetingOperationTypeNew) {
        self.meetingModel.teacherName = self.teacherTapView.textString;
    }else{
        if (![NSString isEmptyWithStr:self.teacherTapView.textString]) {
            self.meetingModel.teacherName = self.teacherTapView.textString;
        }
    }
    if ([NSString isEmptyWithStr:self.meetingModel.purposeString]) {
        [MBHUDManager showBriefAlert:@"请选择您预约相谈的目的"];
        return;
    }
    if ([NSString isEmptyWithStr:self.meetingModel.teacherName]) {
        [MBHUDManager showBriefAlert:@"请填写您预约相谈的老师"];
        return;
    }
    if ([NSString isEmptyWithStr:self.meetingModel.meetingTime1]) {
        [MBHUDManager showBriefAlert:@"请选择您希望预约相谈的时间1"];
        return;
    }
    if ([NSString isEmptyWithStr:self.meetingModel.meetingTime2]) {
        [MBHUDManager showBriefAlert:@"请选择您希望预约相谈的时间2"];
        return;
    }
    if ([NSString isEmptyWithStr:self.meetingModel.meetingTime3]) {
        [MBHUDManager showBriefAlert:@"请选择您希望预约相谈的时间3"];
        return;
    }
    [MakeMeetingManager callBackAddMeetingRequestWithParameterType:self.meetingModel.purposeType teacherName:self.meetingModel.teacherName select_time_one:self.meetingModel.meetingTime1 select_time_two:self.meetingModel.meetingTime2 select_time_three:self.meetingModel.meetingTime3 withCompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message) {
        if (isSuccess) {
            [MBHUDManager showBriefAlert:@"新增预约相谈成功！！"];
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter]postNotificationName:kMKApplyMeetingListRefreshNotifcationKey object:nil];
        }else{
            if (![NSString isEmptyWithStr:message]) {
                [MBHUDManager showBriefAlert:message];
            }
        }
    }];
}
@end
