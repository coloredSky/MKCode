//
//  HomePageViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/11.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "HomePageViewController.h"
//View
#import "HomePageCell.h"
#import "NewPagedFlowView.h"

@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource>
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong)NewPagedFlowView *bannerView;
@property (nonatomic, strong) NSArray *titleArr;//区头标题
@property (nonatomic, strong) NSArray *bannerArr;//banner 图片
@end

@implementation HomePageViewController

#pragma mark --- instancetype method
-(instancetype)init
{
    if (self = [super init]) {
        self.titleArr = @[@"语言",@"学部",@"大学院",@"美术"];
        self.bannerArr = @[@"home_Bnner",@"home_Bnner",@"home_Bnner",@"home_Bnner"];
    }
    return self;
}

#pragma mark --- destruct method
-(void)dealloc
{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_deepGrayColor;
    [self.view addSubview:self.contentTable];
    //refresh
//    [self setUpRefresh];
    //request
    [self startRequest];
}

#pragma mark --  refresh
-(void)setUpRefresh
{
    //下拉刷新
//    @weakObject(self);
    self.contentTable.mj_header = [XHRefreshHeader headerWithRefreshingBlock:^{
//        @strongObject(self);
    }];
    //上拉加载
    self.contentTable.mj_footer = [XHRefreshFooter footerWithRefreshingBlock:^{
//        @strongObject(self);
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
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(K_Padding_LeftPadding, 0, KScreenWidth-K_Padding_LeftPadding*2,KScreenHeight-K_TabbarHeight) style:UITableViewStyleGrouped];
        [_contentTable registerNib:[UINib nibWithNibName:@"HomePageCell" bundle:nil] forCellReuseIdentifier:@"HomePageCell"];
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 44+KScaleWidth(228)+30)];
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
        _bannerView = [[NewPagedFlowView alloc]initWithFrame:CGRectMake(K_Padding_LeftPadding, 44, KScreenWidth-K_Padding_LeftPadding*2, KScaleWidth(228))];
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
    HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageCell" forIndexPath:indexPath];
    [cell cellRefreshData];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KScaleHeight(80);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return KScaleHeight(25);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleHeight(25))];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, headerView.height)];
    [headerView addSubview:titleLab];
    [titleLab setFont:MKBoldFont(16) textColor:K_Text_BlackColor withBackGroundColor:nil];
    titleLab.text = self.titleArr[section];
    return headerView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

#pragma mark --  NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(KScaleWidth(308), KScaleWidth(228));
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
        bannerView.layer.cornerRadius = 8;
        bannerView.layer.masksToBounds = YES;
//        [bannerView setSubviewsWithSuperViewBounds:CGRectMake(0, 0, KScaleWidth(308), KScaleWidth(228))];
    }
    bannerView.mainImageView.image = [UIImage imageNamed:self.bannerArr[index]];
    return bannerView;
}


#pragma mark --  EVENT
#pragma mark - cell did selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark --  banner did selected
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
}
@end
