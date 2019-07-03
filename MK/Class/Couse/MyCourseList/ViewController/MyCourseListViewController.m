//
//  MyCourseListViewController.m
//  MK
//
//  Created by 周洋 on 2019/4/10.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MyCourseListViewController.h"
#import "CourseDetailViewController.h"

#import "MyCourseListCell.h"
#import "MKCourseListModel.h"

@interface MyCourseListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) UIView *headerView;

@end

@implementation MyCourseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_WhiteColor;
//    [self setUpRefresh];
    [self.contentTable reloadData];
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
}

#pragma mark --  request
-(void)startRequest
{
}


#pragma mark --  lazy
-(UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, K_NaviHeight, KScreenWidth, KScaleHeight(100))];
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(K_Padding_LeftPadding, _headerView.height/2-KScaleHeight(10), 200, KScaleHeight(20))];
        [_headerView addSubview:titleLab];
        [titleLab setFont:MKBoldFont(24) textColor:K_Text_BlackColor withBackGroundColor:nil];
        if (self.courseListShowType == UserCourseListViewShowTypeOnline) {
            titleLab.text = @"线上课程";
        }else{
            titleLab.text = @"线下课程";
        }
        UIImageView *lineIma = [[UIImageView alloc]initWithFrame:CGRectMake(K_Padding_LeftPadding, _headerView.height-K_Line_lineWidth, _headerView.width-K_Padding_LeftPadding*2, K_Line_lineWidth)];
        [_headerView addSubview:lineIma];
        lineIma.backgroundColor = K_Line_lineColor;
    }
    return _headerView;
}

-(MKBaseTableView *)contentTable
{
    if (!_contentTable) {
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, K_NaviHeight, KScreenWidth, KScreenHeight-K_NaviHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:_contentTable];
        _contentTable.tableHeaderView = self.headerView;
        _contentTable.backgroundColor = K_BG_WhiteColor;
        _contentTable.estimatedRowHeight = KScaleHeight(60);
        [_contentTable registerNib:[UINib nibWithNibName:@"MyCourseListCell" bundle:nil] forCellReuseIdentifier:@"MyCourseListCell"];
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
    }
    return _contentTable;
}

#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        MyCourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCourseListCell" forIndexPath:indexPath];
        [cell allCoursecellRefreshDataWithIndexPath:indexPath withShowType:self.courseListShowType courseList:self.courseList];
        return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.courseList.count;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KScaleHeight(60);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

#pragma mark --  EVENT
#pragma mark - cell did selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseDetailViewController *detailVC = [CourseDetailViewController new];
    if (self.courseListShowType == UserCourseListViewShowTypeOnline) {
        detailVC.courseType = CourseSituationTypeOnline;
    }else{
        detailVC.courseType = CourseSituationTypeOffline;
    }
    MKCourseListModel *courseModel = self.courseList[indexPath.row];
    detailVC.course_id = courseModel.courseID;
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end
