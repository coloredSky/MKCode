//
//  MyCouseViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/11.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MyCouseViewController.h"
#import "CourseDetailViewController.h"
#import "MyCourseListViewController.h"
#import "CourseDetailViewController.h"
#import "LoginActionController.h"
//View
#import "MyCouseHeaderView.h"
#import "MyOnlineCourseListView.h"
#import "EmptyView.h"
//manager
#import "UserCourseListManager.h"
//model
#import "MKCourseListModel.h"
#import "UserCourseModel.h"


@interface MyCouseViewController()<UITableViewDelegate,UITableViewDataSource,MyOnlineCourseListViewDelagate,EmptyViewDelegate,MyCouseHeaderViewDelegate>

@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong)MyCouseHeaderView *headerView;
@property (nonatomic, strong) NSArray *titleArr;//区头标题

@property (nonatomic, strong) MKCourseListModel *userLastCourse;
@property (nonatomic, strong) NSArray <UserCourseModel *>*userCourseList;
@property (nonatomic, strong) NSArray<MKCourseListModel *> *offlineCourseList;
@property (nonatomic, strong) EmptyView *emptyView;
@end

@implementation MyCouseViewController



#pragma mark --- destruct method
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_deepGrayColor;
//    self.emptyView.hidden = NO;
//    self.contentTable.hidden = YES;
    self.emptyView.showType = EmptyViewShowTypeNoUserCourse;
    //refresh
    [self setUpRefresh];
    //request
    [self startRequest];
    [self addNotification];
}

-(void)addNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginInTarget:) name:kMKLoginInNotifcationKey object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginOutTarget:) name:kMKLoginOutNotifcationKey object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userCouseListRefresh:) name:kMKUserCourseListRefreshNotifcationKey object:nil];
}

#pragma mark --  refresh
-(void)setUpRefresh
{
    //下拉刷新
    @weakObject(self);
    self.contentTable.mj_header = [XHRefreshHeader headerWithRefreshingBlock:^{
        @strongObject(self);
        [self startRequest];
    }];
}

#pragma mark --  request
-(void)startRequest
{
    if (![[UserManager shareInstance]isLogin]) {
        self.emptyView.hidden = NO;
        self.emptyView.showType = EmptyViewShowTypeUserCourseNoLogin; 
        self.contentTable.hidden = YES;
        return;
    }
    [self.emptyView EmptyViewReloadDataWithMKCourseListModel:nil];
    [UserCourseListManager callBackUserCourseListWithCompletionBlock:^(BOOL isSuccess,MKCourseListModel *lastCourseListModel, NSArray<UserCourseModel *> * _Nonnull userCourseList, NSArray<MKCourseListModel *> * _Nonnull offLineCourseList, NSString * _Nonnull message) {
        [self.contentTable.mj_header endRefreshing];
        if (isSuccess) {
            self.userLastCourse = lastCourseListModel;
            self.userCourseList = userCourseList;
            self.offlineCourseList = offLineCourseList;
            [self.contentTable reloadData];
            if (self.userCourseList.count == 0) {
                self.emptyView.hidden = NO;
                self.contentTable.hidden = YES;
                self.emptyView.showType = EmptyViewShowTypeNoUserCourse;
                [self.emptyView EmptyViewReloadDataWithMKCourseListModel:lastCourseListModel];
                self.contentTable.hidden = YES;
            }else{
                self.emptyView.hidden = YES;
                self.contentTable.hidden = NO;
                [self.headerView userCourseHeaderViewRefreshDataWithMKCourseListModel:self.userLastCourse];
            }
        }
    }];
    
//    [UserCourseListManager callBackUserCourseListWithCompletionBlock:^(BOOL isSuccess, NSArray<NSArray *> * _Nonnull userCourseList, NSArray<MKCourseListModel *> * _Nonnull onLineCourseList, NSArray<MKCourseListModel *> * _Nonnull offLineCourseList, NSString * _Nonnull message) {
//        [self.contentTable.mj_header endRefreshing];
//        if (isSuccess) {
//            self.allCourseList = userCourseList;
//            self.onlineCourseList = onLineCourseList;
//            self.offlineCourseList = offLineCourseList;
//            [self.contentTable reloadData];
//        }
//        if (self.onlineCourseList.count == 0 && self.offlineCourseList.count == 0) {
//            self.emptyView.hidden = NO;
//            self.emptyView.showType = EmptyViewShowTypeNoUserCourse;
//            self.contentTable.hidden = YES;
//        }
//    }];
}

#pragma mark --  lazy

-(EmptyView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[EmptyView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight-K_TabbarHeight)];
        [self.view addSubview:_emptyView];
        _emptyView.delegate = self;
    }
    return _emptyView;
}

-(MKBaseTableView *)contentTable
{
    if (!_contentTable) {
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight-K_TabbarHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:_contentTable];
        if (@available(ios 11.0,*)) {
            _contentTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
        [_contentTable registerNib:[UINib nibWithNibName:@"UITableViewCell" bundle:nil] forCellReuseIdentifier:@"UITableViewCell"];
        _contentTable.tableHeaderView = self.headerView;
        _contentTable.backgroundColor = K_BG_WhiteColor;
    }
    return _contentTable;
}

-(MyCouseHeaderView *)headerView
{
    if (!_headerView) {
            _headerView = [[NSBundle mainBundle]loadNibNamed:@"MyCouseHeaderView" owner:nil options:nil][0];
        _headerView.delegate = self;
        _headerView.frame =CGRectMake(0, 0,KScreenWidth ,KScaleWidth(136)+KScaleHeight(60));
    }
    return _headerView;
}
#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.userCourseList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    UserCourseModel *userCourseModel = self.userCourseList[section];
    if (userCourseModel.isOnline) {
        return KScaleHeight(40);
    }else{
        if (userCourseModel.isOfflineFirst) {
            return KScaleHeight(70+20);
        }else{
            return KScaleHeight(35+20);
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    UserCourseModel *userCourseModel = self.userCourseList[section];
    if (userCourseModel.courseList.count > 0) {
        if (userCourseModel.courseList.count < 3) {
            return KScaleHeight(userCourseModel.courseList.count*60);
        }
        return KScaleHeight(180);
    }else{
        return CGFLOAT_MIN;
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UserCourseModel *userCourseModel = self.userCourseList[section];
    UIView *headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, KScreenWidth, [self tableView:tableView heightForHeaderInSection:section]);
    headerView.backgroundColor =K_Text_WhiteColor;
    
    if (userCourseModel.isOnline) {
        UIImageView *lineIma = [UIImageView new];
        lineIma.backgroundColor = K_Line_lineColor;
        [headerView addSubview:lineIma];
        lineIma.frame = CGRectMake(28, 0, KScreenWidth-28, K_Line_lineWidth);
        UILabel *titleLab = [UILabel new];
        titleLab.frame = CGRectMake(28, KScaleHeight(10), 200, 22);
        [headerView addSubview:titleLab];
        titleLab.text = userCourseModel.title;
        
        UILabel *allLab = [[UILabel alloc]initWithFrame:CGRectMake(headerView.width-KScaleWidth(30+30), titleLab.centerY-KScaleHeight(10), KScaleWidth(30), KScaleHeight(20))];
        [headerView addSubview:allLab];
        [allLab setFont:K_Font_Text_Normal_little textColor:K_Text_BlueColor withBackGroundColor:nil];
        allLab.textAlignment = NSTextAlignmentRight;
        allLab.text = @"all";
        UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [headerView addSubview:clickBtn];
        clickBtn.tag = section;
        clickBtn.frame = CGRectMake(headerView.width-KScaleWidth(60), allLab.centerY-KScaleHeight(20), KScaleWidth(60), KScaleHeight(40));
        [clickBtn addTarget:self action:@selector(clickAllCourseListTarget:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        if (userCourseModel.isOfflineFirst) {
            UIImageView *lineIma = [UIImageView new];
            lineIma.backgroundColor = K_Line_lineColor;
            [headerView addSubview:lineIma];
            lineIma.frame = CGRectMake(28, 20, KScreenWidth-28, K_Line_lineWidth);
            UILabel *titleLab = [UILabel new];
            titleLab.frame = CGRectMake(28, lineIma.bottomY+KScaleHeight(12), 200, 22);
            [headerView addSubview:titleLab];
            titleLab.text =  userCourseModel.title;
            UILabel *courseTypeLab = [UILabel new];
            [headerView addSubview:courseTypeLab];
            courseTypeLab.frame = CGRectMake(titleLab.leftX, titleLab.bottomY+KScaleHeight(5), titleLab.width, KScaleHeight(16));
            [courseTypeLab setFont:K_Font_Text_Min_Max textColor:K_Text_DeepGrayColor withBackGroundColor:nil];
            courseTypeLab.text = userCourseModel.message;
            
            UILabel *allLab = [[UILabel alloc]initWithFrame:CGRectMake(headerView.width-KScaleWidth(30+30), titleLab.centerY-KScaleHeight(10), KScaleWidth(30), KScaleHeight(20))];
            [headerView addSubview:allLab];
            [allLab setFont:K_Font_Text_Normal_little textColor:K_Text_BlueColor withBackGroundColor:nil];
            allLab.textAlignment = NSTextAlignmentRight;
            allLab.text = @"all";
            
            UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [headerView addSubview:clickBtn];
            clickBtn.tag = section;
            clickBtn.frame = CGRectMake(headerView.width-KScaleWidth(60), allLab.centerY-KScaleHeight(20), KScaleWidth(60), KScaleHeight(40));
            [clickBtn addTarget:self action:@selector(clickAllCourseListTarget:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            UILabel *courseTypeLab = [UILabel new];
            [headerView addSubview:courseTypeLab];
            courseTypeLab.frame = CGRectMake(28, headerView.height-KScaleHeight(20)-KScaleHeight(5), 200, KScaleHeight(20));
            [courseTypeLab setFont:K_Font_Text_Min_Max textColor:K_Text_DeepGrayColor withBackGroundColor:nil];
            courseTypeLab.text = userCourseModel.message;
        }
    }
    UIImageView *bottomLine = [UIImageView new];
    [headerView addSubview:bottomLine];
    bottomLine.backgroundColor = K_Line_lineColor;
    return headerView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UserCourseModel *userCourseModel = self.userCourseList[section];
    UIView *headerView = [UIView new];
    if (userCourseModel.isOnline) {
        headerView.frame = CGRectMake(0, 0, KScreenWidth, [self tableView:tableView heightForFooterInSection:section]);
        MyOnlineCourseListView *onlineListView = [[MyOnlineCourseListView alloc]initWithFrame:CGRectMake(0, 0, headerView.width, headerView.height)];
        onlineListView.delegate = self;
        onlineListView.listViewShowType = UserCourseListViewShowTypeOnline;
        [headerView addSubview:onlineListView];
        [onlineListView onlineCourseListViewRefreshDataWithContentArr:userCourseModel.courseList];
    }else{
        headerView.frame = CGRectMake(0, 0, KScreenWidth, [self tableView:tableView heightForFooterInSection:section]);
        MyOnlineCourseListView *onlineListView = [[MyOnlineCourseListView alloc]initWithFrame:CGRectMake(0, 0, headerView.width, headerView.height)];
        onlineListView.delegate = self;
        onlineListView.listViewShowType = UserCourseListViewShowTypeOfflineUnderWay;
        [headerView addSubview:onlineListView];
        [onlineListView onlineCourseListViewRefreshDataWithContentArr:userCourseModel.courseList];
    }
    return headerView;
}

#pragma mark --  EVENT
#pragma mark - cell did selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseDetailViewController *detailVC = [CourseDetailViewController new];
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark --  all
-(void)clickAllCourseListTarget:(UIButton *)sender
{
    UserCourseModel *userCourseModel = self.userCourseList[sender.tag];
    MyCourseListViewController *courseListVC = [MyCourseListViewController new];
    if (userCourseModel.isOnline) {
        courseListVC.courseListShowType = UserCourseListViewShowTypeOnline;
        courseListVC.courseList = userCourseModel.courseList;
    }else{
        courseListVC.courseList = self.offlineCourseList;
        courseListVC.courseListShowType = UserCourseListViewShowTypeOfflineUnderWay;
    }
    [self.navigationController pushViewController:courseListVC animated:YES];
}

#pragma mark --  Course-DidSelected
-(void)myOnlineCourseListViewDidSelectedCourseWithIndexPath:(NSIndexPath *)indexPath andUserCourseListViewShowType:(UserCourseListViewShowType)listViewShowType withCourseModel:(nonnull MKCourseListModel *)courseModel
{
    CourseDetailViewController *detailVC = [CourseDetailViewController new];
    detailVC.course_id = courseModel.courseID;
    if (listViewShowType == UserCourseListViewShowTypeOnline) {
        detailVC.courseType = CourseSituationTypeOnline;
    }else{
        detailVC.courseType = CourseSituationTypeOffline;
    }
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark --  emptyView-delegate
-(void)emptyViewClickTargetWithView:(EmptyView *)view withEmptyViewOperationType:(EmptyViewOperationType )operationType;
{
    if (operationType == EmptyViewOperationTypeLogin) {
        if (![[UserManager shareInstance]isLogin]) {
            LoginActionController *loginVC = [LoginActionController new];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
    }else if(operationType == EmptyViewOperationVideoPlay){
        CourseDetailViewController *detailVC = [CourseDetailViewController new];
        detailVC.course_id = self.userLastCourse.courseID;
        detailVC.lessonID = self.userLastCourse.lessonID;
        detailVC.courseType = CourseSituationTypeOnline;
        detailVC.autoPlay = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}
#pragma mark --  视频播放-点击
-(void)userCouseHeaderViewVideoPlay
{
    CourseDetailViewController *detailVC = [CourseDetailViewController new];
    detailVC.course_id = self.userLastCourse.courseID;
    detailVC.lessonID = self.userLastCourse.lessonID;
    detailVC.courseType = CourseSituationTypeOnline;
    detailVC.autoPlay = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark --  登录
-(void)loginInTarget:(NSNotification *)noti
{
    [self startRequest];
}

#pragma mark --  退出登录
-(void)loginOutTarget:(NSNotification *)noti
{
    if (![[UserManager shareInstance]isLogin]) {
        self.emptyView.hidden = NO;
        self.emptyView.showType = EmptyViewShowTypeUserCourseNoLogin;
        self.contentTable.hidden = YES;
    }
}

#pragma mark --  列表刷新
-(void)userCouseListRefresh:(NSNotification *)noti
{
    [self startRequest];
}

@end
