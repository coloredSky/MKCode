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
//manager
#import "MyBillManager.h"
#import "UserBillListModel.h"
@interface MyBillListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UICollectionView *contentCollectionView;
@property (nonatomic, strong) NSArray <UserBillListModel *>*billList;
@end

@implementation MyBillListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpRefresh];
    [self startRequest];
}

#pragma mark --  refresh
-(void)setUpRefresh
{
    //下拉刷新
    @weakObject(self);
    self.contentCollectionView.mj_header = [XHRefreshHeader headerWithRefreshingBlock:^{
        @strongObject(self);
        [self startRequest];
        [self.contentCollectionView.mj_header endRefreshing];
        [self reloadPlacehorldViewWithFrame:CGRectMake(0, self.headerView.bottomY, self.view.width, self.view.height-self.headerView.height) placehorldDisplayType:MKPlaceWorderViewDisplayTypeNoOrder];
        self.placeholderViewShow = YES;
        self.contentCollectionView.hidden = YES;
    }];
}

#pragma mark --  request
-(void)startRequest
{
    [MyBillManager callBackMyBillDataWithCompletionBlock:^(BOOL isSuccess, NSArray<UserBillListModel *> * _Nonnull billList, NSString * _Nonnull message) {
        self.billList = billList;
        [self.contentCollectionView reloadData];
    }];
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
    UserBillListModel *model = self.billList[indexPath.row];
    [cell cellRefreshDataWithUserBillListModel:model];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.billList.count;
}

#pragma mark --  EVENT
#pragma mark --  collection-didSelected
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UserBillListModel *model = self.billList[indexPath.row];
    MKBillDetailViewController *billDetailVC  = [MKBillDetailViewController new];
    billDetailVC.billModel = model;
    [self.navigationController pushViewController:billDetailVC animated:YES];
}
@end
