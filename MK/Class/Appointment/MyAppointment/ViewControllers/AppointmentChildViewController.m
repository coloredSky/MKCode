//
//  AppointmentChildViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/20.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "AppointmentChildViewController.h"
#import "MeetingQueryViewController.h"
#import "MeetingEndQueryViewController.h"
#import "AskForLeaveQueryViewController.h"
#import "AskForLeaveEndViewController.h"
#import "ChangeClassQueryViewController.h"
#import "ChangeClassEndViewController.h"
#import "LoginActionController.h"
//View
#import "AppointmentCell.h"
#import "AppointmentCollectionView.h"
#import "EmptyView.h"
//model
#import "AppointmentListModel.h"

@interface AppointmentChildViewController ()<UITableViewDelegate,UITableViewDataSource,AppointmentCollectionViewDelegate,EmptyViewDelegate>
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) EmptyView *emptyView;
@property (nonatomic, strong) NSArray *sectionOneTitleArr;
@property (nonatomic, strong) NSArray *sectionTwoTitleArr;

//@property (nonatomic, strong) NSArray *ongoningList;
//@property (nonatomic, strong) NSArray *completeList;
@property (nonatomic, strong) NSArray <AppointmentShowModel *>*appointmentShowList;
@end

@implementation AppointmentChildViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(instancetype)init
{
    if (self = [super init]) {
        self.sectionOneTitleArr = @[@"未完成",@"未完成",@"未完成"];
        self.sectionTwoTitleArr = @[@"已完成的换班申请",@"已完成的请假申请",@"已完成的预约"];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpRefresh];
    [self requestData];
    [self addNotification];
}

-(void)addNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginInTarget:) name:kMKLoginInNotifcationKey object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginOutTarget:) name:kMKLoginOutNotifcationKey object:nil];
    NSString *notiName = @"";
    if (self.dispayType == AppointmentDisplayTypeChangeClass) {
        notiName = kMKApplyChangeClassListRefreshNotifcationKey;
    }else if (self.dispayType == AppointmentDisplayTypeAskForLeave) {
        notiName = kMKApplyAskForLeaveListRefreshNotifcationKey;
    }else if (self.dispayType == AppointmentDisplayTypeMeeting) {
        notiName = kMKApplyMeetingListRefreshNotifcationKey;
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestData) name:notiName object:nil];
}

-(void)requestData
{
    if (![[UserManager shareInstance]isLogin]) {
        self.emptyView.hidden = NO;
        self.emptyView.showType = self.dispayType;
        self.contentTable.hidden = YES;
        return;
    }
    [AppointmentManager callBackAllApplyListWithParameteApply_type:self.dispayType completionBlock:^(BOOL isSuccess, NSArray<AppointmentShowModel *> * _Nonnull apponitmentList, NSString * _Nonnull message) {
        if (isSuccess) {
            self.appointmentShowList = apponitmentList;
//            self.ongoningList = ongoingApplyList;
//            self.completeList = completeApplyList;
            //            self.completeList = ongoingApplyList;
            [self.contentTable reloadData];
            [self.contentTable.mj_header endRefreshing];
        }
        
        if (apponitmentList.count == 0) {
            self.emptyView.hidden = NO;
            self.emptyView.showType = self.dispayType+3;
            self.contentTable.hidden = YES;
        }else{
            self.emptyView.hidden = YES;
            self.contentTable.hidden = NO;
        }
    }];
}

#pragma mark --  refresh
-(void)setUpRefresh
{
    //下拉刷新
    @weakObject(self);
    self.contentTable.mj_header = [XHRefreshHeader headerWithRefreshingBlock:^{
        @strongObject(self);
        [self requestData];
    }];
}

#pragma mark --  request
-(void)startRequest
{
}

#pragma mark --  lazy
-(MKBaseTableView *)contentTable
{
    if (!_contentTable) {
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight-(K_NaviHeight+KScaleHeight(20))-K_TabbarHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:_contentTable];
        _contentTable.backgroundColor = K_BG_WhiteColor;
        [_contentTable registerNib:[UINib nibWithNibName:@"AppointmentCell" bundle:nil] forCellReuseIdentifier:@"AppointmentCell"];
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
    }
    return _contentTable;
}

-(EmptyView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[EmptyView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight-(K_NaviHeight+KScaleHeight(20))-K_TabbarHeight)];
        [self.view addSubview:_emptyView];
        _emptyView.delegate = self;
    }
    return _emptyView;
}

#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppointmentShowModel *showModel = self.appointmentShowList[indexPath.section];
    if (!showModel.isOngoingAppointment) {
        AppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppointmentCell" forIndexPath:indexPath];
        AppointmentListModel *model = showModel.appointmentList[indexPath.row];
        [cell cellRefreshDataWithDisplayType:self.dispayType andAppointmentListModel:model];
        return cell;
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.appointmentShowList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppointmentShowModel *showModel = self.appointmentShowList[section];
    if (showModel.isOngoingAppointment) {
        return 0;
    }else{
        return showModel.appointmentList.count;
    }
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppointmentShowModel *showModel = self.appointmentShowList[indexPath.section];
    if (showModel.isOngoingAppointment) {
        return CGFLOAT_MIN;
    }else{
        return KScaleHeight(80);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    AppointmentShowModel *showModel = self.appointmentShowList[section];
    if (showModel.isOngoingAppointment) {
        return KScaleHeight(45);
    }else{
        return KScaleHeight(60);
    }
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    AppointmentShowModel *showModel = self.appointmentShowList[section];
    if (showModel.isOngoingAppointment) {
        return KScaleWidth(145);
    }
    return CGFLOAT_MIN;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    float height = 0;
    AppointmentShowModel *showModel = self.appointmentShowList[section];
    if (showModel.isOngoingAppointment) {
        height = KScaleHeight(45);
    }else{
        height = KScaleHeight(60);
    }
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, height)];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(K_Padding_Home_LeftPadding, headerView.height-20-KScaleHeight(12), 200, 20)];
    [headerView addSubview:titleLab];
    if (showModel.isOngoingAppointment) {
         titleLab.text =self.sectionOneTitleArr[self.dispayType];
    }else{
        titleLab.text = self.sectionTwoTitleArr[self.dispayType];
    }
    [titleLab setFont:MKBoldFont(16) textColor:K_Text_grayColor withBackGroundColor:nil];
    return headerView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    AppointmentShowModel *showModel = self.appointmentShowList[section];
    if (showModel.isOngoingAppointment) {
        AppointmentCollectionView *fotterView = [[AppointmentCollectionView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleWidth(145))];
        fotterView.delegate = self;
        fotterView.dispayType = self.dispayType;
        [fotterView appointmentCollectionViewReloadDataWithAppointmentList:showModel.appointmentList];
        return fotterView;
    }
    return nil;
}
#pragma mark --  collectionItem-didSelected
-(void)appointmentCollectionViewItemDidSelectedWithIndexPath:(NSIndexPath *)indexPath
{
    AppointmentShowModel *showModel;
    for (AppointmentShowModel *model in self.appointmentShowList) {
        if (model.isOngoingAppointment) {
            showModel = model;
            break;
        }
    }
    if (showModel) {
            AppointmentListModel *appointmentModel = showModel.appointmentList[indexPath.row];
        if (self.dispayType == AppointmentDisplayTypeChangeClass) {
            ChangeClassQueryViewController *changeClassQuaryVC = [ChangeClassQueryViewController new];
            changeClassQuaryVC.showType = AppointmentDisplayTypeChangeClass;
            changeClassQuaryVC.checkType = [appointmentModel.status integerValue] == 0 ? ChangeClassQueryCheckTypeCanEdit : ChangeClassQueryCheckTypeNotEdit;
            changeClassQuaryVC.appointmentModel = appointmentModel;
            [self.navigationController pushViewController:changeClassQuaryVC animated:YES];
        }else if (self.dispayType == AppointmentDisplayTypeAskForLeave){
            AskForLeaveQueryViewController *askForLeaveQuaryVC = [AskForLeaveQueryViewController new];
            askForLeaveQuaryVC.appointmentModel = appointmentModel;
            askForLeaveQuaryVC.showType = AppointmentDisplayTypeAskForLeave;
            askForLeaveQuaryVC.checkType = [appointmentModel.status integerValue] == 0 ? AskForLeaveQueryCheckTypeCanEdit : AskForLeaveQueryCheckTypeNotEdit;
            [self.navigationController pushViewController:askForLeaveQuaryVC animated:YES];
        }else if (self.dispayType == AppointmentDisplayTypeMeeting){
            if ([appointmentModel.status integerValue] == 1) {//预约成功
                MeetingEndQueryViewController *meetingEndVC = [MeetingEndQueryViewController new];
                meetingEndVC.appointmentModel = appointmentModel;
                [self.navigationController pushViewController:meetingEndVC animated:YES];
            }else{
                MeetingQueryViewController *meetingQuaryVC = [MeetingQueryViewController new];
                meetingQuaryVC.appointmentModel = appointmentModel;
                meetingQuaryVC.showType = AppointmentDisplayTypeMeeting;
                meetingQuaryVC.checkType = [appointmentModel.status integerValue] == 0 ? MeetingQueryCheckTypeCanEdit : MeetingQueryCheckTypeNotEdit;
                [self.navigationController pushViewController:meetingQuaryVC animated:YES];
            }
        }
    }
}

#pragma mark - cell did selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppointmentShowModel *showModel = self.appointmentShowList[indexPath.section];
    if (showModel.isOngoingAppointment == NO) {
        AppointmentListModel *appointmentModel = showModel.appointmentList[indexPath.row];
        if (self.dispayType == AppointmentDisplayTypeChangeClass) {
            ChangeClassEndViewController *changClassEndVC = [ChangeClassEndViewController new];
            changClassEndVC.appointmentModel = appointmentModel;
            [self.navigationController pushViewController:changClassEndVC animated:YES];
        }else if (self.dispayType == AppointmentDisplayTypeAskForLeave){
            AskForLeaveEndViewController *askForLeaveEndVC = [AskForLeaveEndViewController new];
            askForLeaveEndVC.appointmentModel = appointmentModel;
            [self.navigationController pushViewController:askForLeaveEndVC animated:YES];
        }else{
            MeetingEndQueryViewController *meetingEndVC = [MeetingEndQueryViewController new];
            meetingEndVC.appointmentModel = appointmentModel;
            [self.navigationController pushViewController:meetingEndVC animated:YES];
        }
    }
}

#pragma mark --  emptyView
-(void)emptyViewClickTargetWithView:(EmptyView *)view withEmptyViewOperationType:(EmptyViewOperationType)operationType
{
    if (operationType == EmptyViewOperationTypeLogin) {
        if (![[UserManager shareInstance]isLogin]) {
            LoginActionController *loginVC = [LoginActionController new];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
    }
}

#pragma mark --  登录
-(void)loginInTarget:(NSNotification *)noti
{
    [self requestData];
}

#pragma mark --  退出登录
-(void)loginOutTarget:(NSNotification *)noti
{
    if (![[UserManager shareInstance]isLogin]) {
        self.emptyView.hidden = NO;
        self.emptyView.showType = self.dispayType;
        self.contentTable.hidden = YES;
    }
}

@end
