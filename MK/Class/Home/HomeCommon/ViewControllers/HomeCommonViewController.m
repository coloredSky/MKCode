//
//  HomeCommonViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/19.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "HomeCommonViewController.h"
#import "CourseDetailViewController.h"
//View
#import "HomePageCell.h"
//manager
#import "HomePageManager.h"
//model
#import "MKBannerModel.h"
#import "HomePublicCourseModel.h"
#import "MKCourseListModel.h"

@interface HomeCommonViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MKBaseTableView *contentTable;

@property (nonatomic, strong) NSMutableArray <MKCourseListModel *>*commonCourseList;//推荐课
//分页
@property (nonatomic, assign) NSInteger pageOffset;//从第几条取数据
@property (nonatomic, assign) NSInteger pageLimit;//取数据的条数
@end

@implementation HomeCommonViewController

-(instancetype)init
{
    if (self = [super init]) {
        self.pageOffset = 1;
        self.pageLimit = 5;
    }
    return self;
}

#pragma mark --- destruct method
-(void)dealloc
{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.view.backgroundColor = [UIColor redColor];
    //refresh
    [self setUpRefresh];
}
-(void)homeCommonrefreshCourseListData
{
    if (self.commonCourseList.count == 0) {
        [self startRequest];
    }
}

#pragma mark --  refresh
-(void)setUpRefresh
{
    //下拉刷新
    @weakObject(self);
    self.contentTable.mj_header = [XHRefreshHeader headerWithRefreshingBlock:^{
        @strongObject(self);
        self.pageOffset = 1;
        [self startRequest];
    }];
    //上拉加载
    self.contentTable.mj_footer = [XHRefreshFooter footerWithRefreshingBlock:^{
        @strongObject(self);
        self.pageOffset += self.pageLimit;
        [self startRequest];
    }];
}

#pragma mark --  request
-(void)startRequest
{
    [HomePageManager callBackHomePageCouurseListDataWithHUDShow:YES categoryID:self.categoryID pageOffset:self.pageOffset pageLimit:self.pageLimit andCompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message,NSArray<HomeCourseCategoryModel *> * _Nonnull courseCategoryList, NSArray<MKBannerModel *> * _Nonnull bannerList, NSArray<HomePublicCourseModel *> * _Nonnull publicCourseList, NSArray<MKCourseListModel *> * _Nonnull recommentCourseList) {
        [self.contentTable.mj_header endRefreshing];
        [self.contentTable.mj_footer endRefreshing];
        if (isSuccess) {
            if (self.pageOffset == 1) {
                [self.commonCourseList removeAllObjects];
                [self.commonCourseList addObjectsFromArray:recommentCourseList];
            }else{
                [self.commonCourseList addObjectsFromArray:recommentCourseList];
            }
            if (recommentCourseList.count < self.pageLimit) {
                [self.contentTable.mj_footer endRefreshingWithNoMoreData];
            }
            [self.contentTable reloadData];
        }else{
            self.pageOffset -= self.pageLimit;
        }
    }];
}

#pragma mark --  lazy
-(NSMutableArray <MKCourseListModel *>*)commonCourseList
{
    if (!_commonCourseList) {
        _commonCourseList = [NSMutableArray array];
    }
    return _commonCourseList;
}
-(MKBaseTableView *)contentTable
{
    if (!_contentTable) {
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight-(K_NaviHeight+KScaleHeight(35)+KScaleHeight(20))-K_TabbarHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:_contentTable];
        [_contentTable registerNib:[UINib nibWithNibName:@"HomePageCell" bundle:nil] forCellReuseIdentifier:@"HomePageCell"];
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
    }
    return _contentTable;
}

#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageCell" forIndexPath:indexPath];
    MKCourseListModel *model = self.commonCourseList[indexPath.row];
    [cell cellRefreshDataWithMKCourseListModel:model];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commonCourseList.count;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KScaleHeight(80);
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
    CourseDetailViewController *courseDetailVC = [CourseDetailViewController new];
    [self.navigationController pushViewController:courseDetailVC animated:YES];
}


@end
