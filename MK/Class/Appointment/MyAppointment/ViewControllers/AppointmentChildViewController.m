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

@interface AppointmentChildViewController ()<UITableViewDelegate,UITableViewDataSource,AppointmentCollectionViewDelegate,EmptyViewDelegate>
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) EmptyView *emptyView;
@property (nonatomic, strong) NSArray *sectionOneTitleArr;
@property (nonatomic, strong) NSArray *sectionTwoTitleArr;

@property (nonatomic, strong) NSArray *ongoningList;
@property (nonatomic, strong) NSArray *completeList;
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
        self.emptyView.showType = EmptyViewShowTypeAppointmentNoLogin;
        self.contentTable.hidden = YES;
        return;
    }
    [AppointmentManager callBackAllApplyListWithParameteApply_type:self.dispayType completionBlock:^(BOOL isSuccess, NSArray<AppointmentListModel *> * _Nonnull ongoingApplyList, NSArray<AppointmentListModel *> * _Nonnull completeApplyList, NSString * _Nonnull message) {
        if (isSuccess) {
            self.ongoningList = ongoingApplyList;
            self.completeList = completeApplyList;
            [self.contentTable reloadData];
            [self.contentTable.mj_header endRefreshing];
        }
        if (ongoingApplyList.count==0&&ongoingApplyList.count == 0) {
            self.emptyView.hidden = NO;
            self.emptyView.showType = self.dispayType+1;
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
    AppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppointmentCell" forIndexPath:indexPath];
    AppointmentListModel *model = self.completeList[indexPath.row];
    [cell cellRefreshDataWithDisplayType:self.dispayType andAppointmentListModel:model];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return self.completeList.count;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KScaleHeight(80);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return KScaleHeight(45);
    }
    else if (section == 1){
        return KScaleHeight(60);
    }
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return KScaleWidth(145);
    }
    return CGFLOAT_MIN;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    float height = 0;
    if (section == 0) {
        height = KScaleHeight(45);
    }else{
        height = KScaleHeight(60);
    }
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, height)];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(K_Padding_Home_LeftPadding, headerView.height-20-KScaleHeight(12), 200, 20)];
    [headerView addSubview:titleLab];
    if (section == 0) {
         titleLab.text =self.sectionOneTitleArr[self.dispayType];
    }else{
        titleLab.text = self.sectionTwoTitleArr[self.dispayType];
    }
    [titleLab setFont:MKBoldFont(16) textColor:K_Text_grayColor withBackGroundColor:nil];
    return headerView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        AppointmentCollectionView *fotterView = [[AppointmentCollectionView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleWidth(145))];
        fotterView.delegate = self;
        fotterView.dispayType = self.dispayType;
        [fotterView appointmentCollectionViewReloadDataWithAppointmentList:self.ongoningList];
        return fotterView;
    }
    return nil;
}
#pragma mark --  collectionItem-didSelected
-(void)appointmentCollectionViewItemDidSelectedWithIndexPath:(NSIndexPath *)indexPath
{
    AppointmentListModel *appointmentModel = self.ongoningList[indexPath.row];
    if (self.dispayType == AppointmentDisplayTypeChangeClass) {
        ChangeClassQueryViewController *changeClassQuaryVC = [ChangeClassQueryViewController new];
        changeClassQuaryVC.showType = AppointmentDisplayTypeChangeClass;
        [self.navigationController pushViewController:changeClassQuaryVC animated:YES];
    }else if (self.dispayType == AppointmentDisplayTypeAskForLeave){
        AskForLeaveQueryViewController *askForLeaveQuaryVC = [AskForLeaveQueryViewController new];
        askForLeaveQuaryVC.appointmentModel = appointmentModel;
        askForLeaveQuaryVC.showType = AppointmentDisplayTypeAskForLeave;
        [self.navigationController pushViewController:askForLeaveQuaryVC animated:YES];
    }else if (self.dispayType == AppointmentDisplayTypeMeeting){
        MeetingQueryViewController *meetingQuaryVC = [MeetingQueryViewController new];
        meetingQuaryVC.appointmentModel = appointmentModel;
        meetingQuaryVC.showType = AppointmentDisplayTypeMeeting;
        [self.navigationController pushViewController:meetingQuaryVC animated:YES];
    }
}

#pragma mark - cell did selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dispayType == AppointmentDisplayTypeChangeClass) {
        ChangeClassEndViewController *changClassEndVC = [ChangeClassEndViewController new];
        [self.navigationController pushViewController:changClassEndVC animated:YES];
    }else if (self.dispayType == AppointmentDisplayTypeAskForLeave){
        AskForLeaveEndViewController *askForLeaveEndVC = [AskForLeaveEndViewController new];
        [self.navigationController pushViewController:askForLeaveEndVC animated:YES];
    }else{
        MeetingEndQueryViewController *meetingEndVC = [MeetingEndQueryViewController new];
        [self.navigationController pushViewController:meetingEndVC animated:YES];
    }
}

#pragma mark --  emptyView
-(void)emptyViewClickTargetWithView:(EmptyView *)view
{
    if (![[UserManager shareInstance]isLogin]) {
        LoginActionController *loginVC = [LoginActionController new];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

#pragma mark --  登录
-(void)loginInTarget:(NSNotification *)noti
{
    [self requestData];
}

#pragma mark --  登录
-(void)loginOutTarget:(NSNotification *)noti
{
    if (![[UserManager shareInstance]isLogin]) {
        self.emptyView.hidden = NO;
        self.emptyView.showType = EmptyViewShowTypeAppointmentNoLogin;
        self.contentTable.hidden = YES;
    }
}

@end
