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
#import "MKCourseListModel.h"

@interface HomeCommonViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) NSMutableArray *commonCourseList;
@end

@implementation HomeCommonViewController

-(instancetype)init
{
    if (self = [super init]) {
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
    //    request
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
    [HomePageManager callBackHomePageCouurseListDataWithHUDShow:YES categoryID:self.categoryID andCompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message, NSMutableArray<MKCourseListModel *> * _Nonnull resultList) {
        if (isSuccess) {
            self.commonCourseList = resultList;
            [self.contentTable reloadData];
        }
    }];
}

#pragma mark --  lazy
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
