//
//  DiscoverPageViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/11.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "DiscoverPageViewController.h"
#import "NewsViewController.h"
#import "CourseDetailViewController.h"
//View
#import "DiscoverNewsCell.h"
#import "DiscoverCourseCategoryView.h"

@interface DiscoverPageViewController ()<UITableViewDelegate,UITableViewDataSource,DiscoverCourseCategoryViewDelegate>
@property (nonatomic, strong) MKBaseTableView *contentTable;
@end

@implementation DiscoverPageViewController

#pragma mark --- instancetype method
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
    
    [self setUpRefresh];
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
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-K_TabbarHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:_contentTable];
        _contentTable.backgroundColor = [UIColor clearColor];
        [_contentTable registerNib:[UINib nibWithNibName:@"DiscoverNewsCell" bundle:nil] forCellReuseIdentifier:@"DiscoverNewsCell"];
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
    }
    return _contentTable;
}

#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoverNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiscoverNewsCell" forIndexPath:indexPath];
    [cell cellRefreshData];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 257*(KScreenWidth-K_Padding_LeftPadding*2)/342+KScaleHeight(90);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return KScaleHeight(104-5);
    }
    if (section > 1) {
        return KScaleHeight(127-10);
    }
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0){
        return KScaleHeight(140-10);
    }
    return CGFLOAT_MIN;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 1) {
        UIView *headerView = [UIView new];
        if (section == 0) {
            headerView.frame = CGRectMake(0, 0, KScreenWidth, KScaleHeight(104-5));
        }else{
            headerView.frame = CGRectMake(0, 0, KScreenWidth, KScaleHeight(127-10));
        }
        
        UILabel *weekDayLab = [UILabel new];
        weekDayLab.frame = CGRectMake(K_Padding_LeftPadding, headerView.height-KScaleHeight(section == 0 ? KScaleHeight(6) : KScaleHeight(10) )-KScaleHeight(40), 200, KScaleHeight(40));
        [headerView addSubview:weekDayLab];
        [weekDayLab setFont:K_Font_WeekDay_Text textColor:K_Text_BlackColor withBackGroundColor:nil];
        weekDayLab.text = @"星期四";
        
        UILabel *timeLab = [UILabel new];
        timeLab.frame = CGRectMake(weekDayLab.leftX, weekDayLab.topY-KScaleHeight(20), weekDayLab.width, KScaleHeight(20));
        [headerView addSubview:timeLab];
        [timeLab setFont:K_Font_Text_Min_Max textColor:K_Text_grayColor withBackGroundColor:nil];
        timeLab.text = @"1月10日";
        
        return  headerView;
    }
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *fotterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleHeight(140-10))];
        CGFloat itemWidth = (KScreenWidth-25*2-18*3)/4;
        DiscoverCourseCategoryView *categoryView = [[DiscoverCourseCategoryView alloc]initWithFrame:CGRectMake(0, fotterView.height/2-itemWidth/2, fotterView.width, itemWidth)];
        categoryView.delegate = self;
        [fotterView addSubview:categoryView];
        return fotterView;
    }
    return nil;
}

#pragma mark --  EVENT
#pragma mark - cell did selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsViewController *newsVC = [NewsViewController new];
    [self.navigationController pushViewController:newsVC animated:YES];
}
#pragma mark -- course category did selected
-(void)itemDidSelectedWithIndex:(NSUInteger )index
{
    CourseDetailViewController *courseDetailVC = [CourseDetailViewController new];
    [self.navigationController pushViewController:courseDetailVC animated:YES];
}

@end
