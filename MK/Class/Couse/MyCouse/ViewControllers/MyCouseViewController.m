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
//View
#import "MyCouseHeaderView.h"
#import "MyOnlineCourseListView.h"

@interface MyCouseViewController()<UITableViewDelegate,UITableViewDataSource,MyOnlineCourseListViewDelagate>

@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong)MyCouseHeaderView *headerView;
@property (nonatomic, strong) NSArray *titleArr;//区头标题
@end

@implementation MyCouseViewController



#pragma mark --- destruct method
-(void)dealloc
{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_deepGrayColor;
    //refresh
    [self setUpRefresh];
    //request
    [self startRequest];
}

#pragma mark --  refresh
-(void)setUpRefresh
{
    //下拉刷新
    @weakObject(self);
    self.contentTable.mj_header = [XHRefreshHeader headerWithRefreshingBlock:^{
        @strongObject(self);
        [self.contentTable.mj_header endRefreshing];
    }];
    //上拉加载
    //    self.contentTable.mj_footer = [XHRefreshFooter footerWithRefreshingBlock:^{
    //                @strongObject(self);
    //    }];
}

#pragma mark --  request
-(void)startRequest
{
}

#pragma mark --  lazy
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
        _headerView.frame =CGRectMake(0, 0,KScreenWidth ,KScreenWidth *136/375+60);
        [_headerView cellRefreshData];
    }
    return _headerView;
}
#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
//    [cell cellRefreshDataWithIndexPath:indexPath];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KScaleHeight(60);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return KScaleHeight(40);
    }else if (section ==1){
        return KScaleHeight(70+20);
    }
    return KScaleHeight(35+20);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return KScaleHeight(180);
    }else if (section ==1){
        return KScaleHeight(180);
    }
    return KScaleHeight(180);
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, KScreenWidth, [self tableView:tableView heightForHeaderInSection:section]);
    headerView.backgroundColor =K_Text_WhiteColor;
    
    if (section == 0) {//线上课程
        UIImageView *lineIma = [UIImageView new];
        lineIma.backgroundColor = K_Line_lineColor;
        [headerView addSubview:lineIma];
        lineIma.frame = CGRectMake(28, 0, KScreenWidth-28, K_Line_lineWidth);
        UILabel *titleLab = [UILabel new];
         titleLab.frame = CGRectMake(28, KScaleHeight(10), 200, 22);
        [headerView addSubview:titleLab];
        titleLab.text = @"线上课程";
        
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
    }else if (section == 1){
        UIImageView *lineIma = [UIImageView new];
        lineIma.backgroundColor = K_Line_lineColor;
        [headerView addSubview:lineIma];
        lineIma.frame = CGRectMake(28, 20, KScreenWidth-28, K_Line_lineWidth);
        UILabel *titleLab = [UILabel new];
        titleLab.frame = CGRectMake(28, lineIma.bottomY+KScaleHeight(12), 200, 22);
        [headerView addSubview:titleLab];
        titleLab.text =  @"线下课程";
        UILabel *courseTypeLab = [UILabel new];
        [headerView addSubview:courseTypeLab];
        courseTypeLab.frame = CGRectMake(titleLab.leftX, titleLab.bottomY+KScaleHeight(5), titleLab.width, KScaleHeight(16));
        [courseTypeLab setFont:K_Font_Text_Min_Max textColor:K_Text_DeepGrayColor withBackGroundColor:nil];
        courseTypeLab.text = @"正在进行的课程";
        
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
        courseTypeLab.text = @"还未开始的课程";
    }
    UIImageView *bottomLine = [UIImageView new];
    [headerView addSubview:bottomLine];
    bottomLine.backgroundColor = K_Line_lineColor;
//        self.lineIma.frame = CGRectMake(_courseNameLab.leftX, self.contentView.height-K_Line_lineWidth, self.contentView.width-_courseNameLab.leftX-K_Padding_LeftPadding, K_Line_lineWidth);
//    bottomLine.frame = CGRectMake(KScaleWidth(110), headerView.height-K_Line_lineWidth, headerView.width-KScaleWidth(110)-K_Padding_LeftPadding-KScaleWidth(50), K_Line_lineWidth);
    return headerView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    if (section ==0) {
        headerView.frame = CGRectMake(0, 0, KScreenWidth, KScaleHeight(180));
        MyOnlineCourseListView *onlineListView = [[MyOnlineCourseListView alloc]initWithFrame:CGRectMake(0, 0, headerView.width, headerView.height)];
        onlineListView.delegate = self;
        onlineListView.listViewShowType = UserCourseListViewShowTypeOnline;
        [headerView addSubview:onlineListView];
        [onlineListView onlineCourseListViewRefreshDataWithContentArr:[NSArray array].mutableCopy];
    }else if (section == 1){
        headerView.frame = CGRectMake(0, 0, KScreenWidth, KScaleHeight(180));
        MyOnlineCourseListView *onlineListView = [[MyOnlineCourseListView alloc]initWithFrame:CGRectMake(0, 0, headerView.width, headerView.height)];
        onlineListView.delegate = self;
        onlineListView.listViewShowType = UserCourseListViewShowTypeOfflineUnderWay;
        [headerView addSubview:onlineListView];
        [onlineListView onlineCourseListViewRefreshDataWithContentArr:[NSArray array].mutableCopy];
    }else{
        headerView.frame = CGRectMake(0, 0, KScreenWidth, KScaleHeight(180));
        MyOnlineCourseListView *onlineListView = [[MyOnlineCourseListView alloc]initWithFrame:CGRectMake(0, 0, headerView.width, headerView.height)];
        onlineListView.delegate = self;
        onlineListView.listViewShowType = UserCourseListViewShowTypeOfflineNotStart;
        [headerView addSubview:onlineListView];
        [onlineListView onlineCourseListViewRefreshDataWithContentArr:[NSArray array].mutableCopy];
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
    MyCourseListViewController *courseListVC = [MyCourseListViewController new];
    if (sender.tag == 0) {
        courseListVC.courseListShowType = UserCourseListViewShowTypeOnline;
    }else{
        courseListVC.courseListShowType = UserCourseListViewShowTypeOfflineUnderWay;
    }
    [self.navigationController pushViewController:courseListVC animated:YES];
}
#pragma mark --  Course-DidSelected
-(void)myOnlineCourseListViewDidSelectedCourseWithIndexPath:(NSIndexPath *)indexPath andUserCourseListViewShowType:(UserCourseListViewShowType)listViewShowType
{
    CourseDetailViewController *detailVC = [CourseDetailViewController new];
    if (listViewShowType == UserCourseListViewShowTypeOnline) {
        detailVC.courseType = CourseSituationTypeOnline;
    }else{
        detailVC.courseType = CourseSituationTypeOffline;
    }
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
