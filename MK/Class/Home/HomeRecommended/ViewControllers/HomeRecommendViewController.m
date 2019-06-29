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
//View
#import "HomePageCell.h"
#import "NewPagedFlowView.h"
#import "HomeRecommenCell.h"
#import "HomeCourseCollectionView.h"
//manager
#import "HomePageManager.h"
//model
#import "MKBannerModel.h"
#import "HomePublicCourseModel.h"
#import "MKCourseListModel.h"


@interface HomeRecommendViewController ()<UITableViewDelegate,UITableViewDataSource,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource,HomeCourseCollectionViewDelegate>

@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong)NewPagedFlowView *bannerView;
@property (nonatomic, assign) CGSize bannerItemSize;//banner图片的大小
@property (nonatomic, strong) NSArray <MKBannerModel *>*bannerList;//banner 图片
@property (nonatomic, strong) NSArray <HomePublicCourseModel *>*publicCourseList;//公开课
@property (nonatomic, strong) NSMutableArray <MKCourseListModel *>*recommendCourseList;//推荐课
//分页
@property (nonatomic, assign) NSInteger pageOffset;//从第几条取数据
@property (nonatomic, assign) NSInteger pageLimit;//取数据的条数

@end

@implementation HomeRecommendViewController
-(instancetype)init
{
    if (self = [super init]) {
        self.bannerItemSize = CGSizeMake(KScreenWidth-K_Padding_Home_LeftPadding*2, 451*(KScreenWidth-K_Padding_Home_LeftPadding*2)/324);
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
    //refresh
        [self setUpHeaderRefresh];
    //request
    [self startRequestWithHUDShow:YES];
}
-(void)homeRecommendfreshCourseListData
{
    if (self.recommendCourseList.count == 0) {
        [self startRequestWithHUDShow:YES];
    }
}

#pragma mark --  refresh
-(void)setUpHeaderRefresh
{
    //下拉刷新
    @weakObject(self);
    self.contentTable.mj_header = [XHRefreshHeader headerWithRefreshingBlock:^{
        @strongObject(self);
        self.pageOffset = 1;
        [self startRequestWithHUDShow:NO];
    }];
}

-(void)setUpFooterRefresh
{
    //上拉加载
    @weakObject(self);
    self.contentTable.mj_footer = [XHRefreshFooter footerWithRefreshingBlock:^{
        @strongObject(self);
        self.pageOffset += self.pageLimit;
        [self startRequestWithHUDShow:NO];
    }];
}

#pragma mark --  request
-(void)startRequestWithHUDShow:(BOOL)HUDShow
{
    [HomePageManager callBackHomePageCouurseListDataWithHUDShow:HUDShow categoryID:self.categoryID pageOffset:self.pageOffset pageLimit:self.pageLimit andCompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message,NSArray<HomeCourseCategoryModel *> * _Nonnull courseCategoryList, NSArray<MKBannerModel *> * _Nonnull bannerList, NSArray<HomePublicCourseModel *> * _Nonnull publicCourseList, NSArray<MKCourseListModel *> * _Nonnull recommentCourseList) {
        [self.contentTable.mj_header endRefreshing];
        if (isSuccess) {
            if (self.pageOffset == 1) {
                if (bannerList.count > 0) {
                    self.contentTable.tableHeaderView = self.bannerView;
                    self.bannerList = bannerList;
                    [self.bannerView reloadData];
                }else{
                    self.contentTable.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.size.width, CGFLOAT_MIN)];
                }
                self.publicCourseList = publicCourseList;
                [self.recommendCourseList removeAllObjects];
                [self.recommendCourseList addObjectsFromArray:recommentCourseList];
                if (recommentCourseList.count == self.pageLimit) {
                    [self setUpFooterRefresh];
                }
            }else{
                [self.recommendCourseList addObjectsFromArray:recommentCourseList];
            }
            if (recommentCourseList.count < self.pageLimit) {
                [self.contentTable.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.contentTable.mj_footer endRefreshing];
            }
            [self.contentTable reloadData];
        }else{
            if (self.pageOffset > self.pageLimit) {
                [self.contentTable.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.contentTable.mj_footer endRefreshing];
            }
            self.pageOffset -= self.pageLimit;
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

-(MKBaseTableView *)contentTable
{
    if (!_contentTable) {
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight-(KScaleHeight(91)+KScaleHeight(20))-K_TabbarHeight) style:UITableViewStyleGrouped];
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
        [self.view addSubview:_contentTable];
        _contentTable.sectionHeaderHeight = 0.1;
        _contentTable.sectionFooterHeight = 0.1;
        [_contentTable registerNib:[UINib nibWithNibName:@"HomeRecommenCell" bundle:nil] forCellReuseIdentifier:@"HomeRecommenCell"];
    }
    return _contentTable;
}

-(NewPagedFlowView *)bannerView
{
    if (!_bannerView) {
        _bannerView = [[NewPagedFlowView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, self.bannerItemSize.height)];
        _bannerView.delegate = self;
        _bannerView.dataSource = self;
        _bannerView.minimumPageAlpha = 0.1;
        _bannerView.isOpenAutoScroll = YES;
        _bannerView.isCarousel = YES;
        _bannerView.orientation = NewPagedFlowViewOrientationHorizontal;
        _bannerView.orginPageCount = 3;
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
        [courseCollectionView homeCourseCollectionViewReloadDataWithCourseList:self.publicCourseList];
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
    return self.bannerList.count;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
    }
    MKBannerModel *model = self.bannerList[index];
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.bannerImage] placeholderImage:K_MKPlaceholder_Annoument_Banner_Image];
    return bannerView;
}


#pragma mark --  EVENT
#pragma mark - cell did selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MKCourseListModel *model = self.recommendCourseList[indexPath.row];
    CourseDetailViewController *courseDetailVC = [CourseDetailViewController new];
    courseDetailVC.course_id = model.courseID;
    [self.navigationController pushViewController:courseDetailVC animated:YES];
}
#pragma mark --  collection-DidSelected
-(void)homeCourseCollectionViewDidSelectedWithIndexPath:(NSIndexPath *)indexPath
{
    HomePublicCourseModel *model = self.publicCourseList[indexPath.row];
//    CourseDetailViewController *courseDetailVC = [CourseDetailViewController new];
//    [self.navigationController pushViewController:courseDetailVC animated:YES];
    NewsViewController *newsDetailVC = [NewsViewController new];
    newsDetailVC.titleString = model.courseName;
    newsDetailVC.contentUrl = model.courseUrl;
    [self.navigationController pushViewController:newsDetailVC animated:YES];
}

#pragma mark --  banner did selected
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    NewsViewController *newsDetailVC = [NewsViewController new];
    MKBannerModel *model = self.bannerList[subIndex];
    newsDetailVC.titleString = model.bannerTitle;
    newsDetailVC.contentUrl = model.bannerILinkUrl;
    [self.navigationController pushViewController:newsDetailVC animated:YES];
}

@end
