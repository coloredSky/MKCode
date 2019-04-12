//
//  MyBillListViewController.m
//  MK
//
//  Created by 周洋 on 2019/4/4.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MyBillListViewController.h"
#import "MKBillDetailViewController.h"
//flowLayout
#import "BillListCollectionViewFlowLayout.h"
//View
#import "BillListCollectionViewCell.h"

@interface MyBillListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UICollectionView *contentCollectionView;
@end

@implementation MyBillListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpRefresh];
}

#pragma mark --  refresh
-(void)setUpRefresh
{
    //下拉刷新
    @weakObject(self);
    self.contentCollectionView.mj_header = [XHRefreshHeader headerWithRefreshingBlock:^{
        @strongObject(self);
        [self.contentCollectionView.mj_header endRefreshing];
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
-(UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, K_NaviHeight, KScreenWidth, KScaleHeight(106))];
        [self.view addSubview:_headerView];
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(K_Padding_Home_LeftPadding, _headerView.height-KScaleHeight(60+20), 200, KScaleHeight(20))];
        [_headerView addSubview:titleLab];
        [titleLab setFont:MKBoldFont(24) textColor:K_Text_BlackColor withBackGroundColor:nil];
        titleLab.text = @"订单";
    }
    return _headerView;
}
-(UICollectionView *)contentCollectionView
{
    if (!_contentCollectionView) {
        BillListCollectionViewFlowLayout *listFlowLayout = [[BillListCollectionViewFlowLayout alloc]init];
        _contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.headerView.bottomY, KScreenWidth, KScreenHeight-self.headerView.height-K_NaviHeight) collectionViewLayout:listFlowLayout];
        _contentCollectionView.backgroundColor = K_BG_deepGrayColor;
        _contentCollectionView.dataSource = self;
        _contentCollectionView.delegate = self;
        _contentCollectionView.showsVerticalScrollIndicator = NO;
        _contentCollectionView.showsHorizontalScrollIndicator = NO;
        [_contentCollectionView registerNib:[UINib nibWithNibName:@"BillListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"BillListCollectionViewCell"];
        [self.view addSubview:_contentCollectionView];
    }
    return _contentCollectionView;
}

#pragma mark --  collectionView-delegate-datasource
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BillListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BillListCollectionViewCell" forIndexPath:indexPath];
    [cell cellRefreshData];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

#pragma mark --  EVENT
#pragma mark --  collection-didSelected
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MKBillDetailViewController *billDetailVC  = [MKBillDetailViewController new];
    [self.navigationController pushViewController:billDetailVC animated:YES];
}
@end
