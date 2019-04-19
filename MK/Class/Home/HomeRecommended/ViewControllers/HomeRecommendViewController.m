//
//  HomeRecommendViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/18.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "HomeRecommendViewController.h"
#import "CourseDetailViewController.h"
#import "NewsViewController.h"
#import "CourseDetailViewController.h"
//View
#import "HomePageCell.h"
#import "NewPagedFlowView.h"
#import "HomeRecommenCell.h"
#import "HomeCourseCollectionView.h"
//manager
#import "HomePageManager.h"
//model
#import "MKCourseListModel.h"

@interface HomeRecommendViewController ()<UITableViewDelegate,UITableViewDataSource,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource,HomeCourseCollectionViewDelegate>

@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong)NewPagedFlowView *bannerView;
@property (nonatomic, strong) NSArray *bannerArr;//banner 图片
@property (nonatomic, assign) CGSize bannerItemSize;//banner图片的大小
@property (nonatomic, strong) NSMutableArray <MKCourseListModel *>*recommendCourseList;
@property (nonatomic, strong) NSMutableArray <MKCourseListModel *>*publicCourseList;
@end

@implementation HomeRecommendViewController
-(instancetype)init
{
    if (self = [super init]) {
        self.bannerArr = @[@"home_banner",@"home_banner",@"home_banner",@"home_banner"];
        self.bannerItemSize = CGSizeMake(KScreenWidth-K_Padding_Home_LeftPadding*2, 451*(KScreenWidth-K_Padding_Home_LeftPadding*2)/324);
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
            self.recommendCourseList = resultList;
            [self.contentTable reloadData];
        }
    }];
}

#pragma mark --  lazy
-(NSMutableArray <MKCourseListModel *>*)recommendCourseList
{
    if (!_recommendCourseList) {
        _recommendCourseList = [NSMutableArray array];
    }
    return _recommendCourseList;
}
-(NSMutableArray <MKCourseListModel *>*)publicCourseList
{
    if (!_publicCourseList) {
        _publicCourseList = [NSMutableArray array];
    }
    return _publicCourseList;
}
-(MKBaseTableView *)contentTable
{
    if (!_contentTable) {
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight-(K_NaviHeight+KScaleHeight(35)+KScaleHeight(20))-K_TabbarHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:_contentTable];
        [_contentTable registerNib:[UINib nibWithNibName:@"HomeRecommenCell" bundle:nil] forCellReuseIdentifier:@"HomeRecommenCell"];
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, self.bannerItemSize.height)];
        [headerView addSubview:self.bannerView];
        _contentTable.tableHeaderView = headerView;
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
    }
    return _contentTable;
}

-(NewPagedFlowView *)bannerView
{
    if (!_bannerView) {
//        _bannerView = [[NewPagedFlowView alloc]initWithFrame:CGRectMake(KScreenWidth/2-KScaleWidth(308)/2-20, 44, KScaleWidth(308)+40, KScaleWidth(228))];
        _bannerView = [[NewPagedFlowView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, self.bannerItemSize.height)];
        _bannerView.delegate = self;
        _bannerView.dataSource = self;
        _bannerView.minimumPageAlpha = 0.1;
        _bannerView.isOpenAutoScroll = YES;
        _bannerView.isCarousel = YES;
        _bannerView.orientation = NewPagedFlowViewOrientationHorizontal;
        _bannerView.orginPageCount = 3;
        [_bannerView reloadData];
    }
    return _bannerView;
}

#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeRecommenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeRecommenCell" forIndexPath:indexPath];
    MKCourseListModel *model = self.recommendCourseList[indexPath.row];
    [cell cellRefreshDataWithMKCourseListModel:model];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section > 0) {
        return self.recommendCourseList.count;
    }
    return 0;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (KScreenWidth-K_Padding_Home_LeftPadding*2)/2+15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return KScaleHeight(50);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return KScaleHeight(88)+10;
    }
    return CGFLOAT_MIN;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleHeight(50))];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(K_Padding_Home_LeftPadding, headerView.height-20-8, 200, 20)];
    [headerView addSubview:titleLab];
    if (section == 0) {
        titleLab.text = @"公开课";
    }else{
        titleLab.text = @"推荐";
    }
    [titleLab setFont:MKBoldFont(16) textColor:K_Text_BlackColor withBackGroundColor:nil];
    return headerView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section ==0) {
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleWidth(88)+10)];
        HomeCourseCollectionView *courseCollectionView = [[HomeCourseCollectionView alloc]initWithFrame:CGRectMake(0, 0, footerView.width, footerView.height)];
        courseCollectionView.delegate = self;
        [courseCollectionView homeCourseCollectionViewReloadDataWithCourseList:@[@"",@"",@"",@"",@""].mutableCopy];
        [footerView addSubview:courseCollectionView];
        return footerView;
    }
    return nil;
}

#pragma mark --  NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return self.bannerItemSize;
}
#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return self.bannerArr.count;
}
- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
//        bannerView.layer.cornerRadius = 8;
//        bannerView.layer.masksToBounds = YES;
//        [bannerView setSubviewsWithSuperViewBounds:CGRectMake(0, 0, KScaleWidth(308), KScaleWidth(228))];
    }
    bannerView.mainImageView.image = [UIImage imageNamed:self.bannerArr[index]];
    return bannerView;
}


#pragma mark --  EVENT
#pragma mark - cell did selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseDetailViewController *courseDetailVC = [CourseDetailViewController new];
    [self.navigationController pushViewController:courseDetailVC animated:YES];
}
#pragma mark --  collection-DidSelected
-(void)homeCourseCollectionViewDidSelectedWithIndexPath:(NSIndexPath *)indexPath
{
    CourseDetailViewController *courseDetailVC = [CourseDetailViewController new];
    [self.navigationController pushViewController:courseDetailVC animated:YES];
}
#pragma mark --  banner did selected
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    NewsViewController *newsDetailVC = [NewsViewController new];
    [self.navigationController pushViewController:newsDetailVC animated:YES];
}

@end
