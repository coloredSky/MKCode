//
//  MKBillDetailViewController.m
//  MK
//
//  Created by 周洋 on 2019/4/8.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKBillDetailViewController.h"
//View
#import "BillDetailCell.h"
#import "BillDetailPayTimeCell.h"

@interface MKBillDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) UIView *headerView;

@end

@implementation MKBillDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_WhiteColor;
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
-(UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, K_NaviHeight, KScreenWidth, KScaleHeight(84))];
        [self.view addSubview:_headerView];
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(K_Padding_LeftPadding, _headerView.height-KScaleHeight(20+10), 200, KScaleHeight(20))];
        [_headerView addSubview:titleLab];
        [titleLab setFont:MKBoldFont(24) textColor:K_Text_BlackColor withBackGroundColor:nil];
        titleLab.text = @"订单详情";
        
        UIImageView *lineIma = [[UIImageView alloc]initWithFrame:CGRectMake(K_Padding_LeftPadding, _headerView.height-K_Line_lineWidth, _headerView.width-K_Padding_LeftPadding*2, K_Line_lineWidth)];
        [_headerView addSubview:lineIma];
        lineIma.backgroundColor = K_Line_lineColor;
    }
    return _headerView;
}
-(MKBaseTableView *)contentTable
{
    if (!_contentTable) {
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, self.headerView.bottomY, KScreenWidth, KScreenHeight-self.headerView.height-K_NaviHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:_contentTable];
        _contentTable.backgroundColor = K_BG_WhiteColor;
        _contentTable.estimatedRowHeight = KScaleHeight(56);
        [_contentTable registerNib:[UINib nibWithNibName:@"BillDetailCell" bundle:nil] forCellReuseIdentifier:@"BillDetailCell"];
        [_contentTable registerNib:[UINib nibWithNibName:@"BillDetailPayTimeCell" bundle:nil] forCellReuseIdentifier:@"BillDetailPayTimeCell"];
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
    }
    return _contentTable;
}

#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        BillDetailPayTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BillDetailPayTimeCell" forIndexPath:indexPath];
       [cell cellRefreshDataWithIndexPath:indexPath];
        return cell;
    }else{
        BillDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BillDetailCell" forIndexPath:indexPath];
        [cell cellRefreshDataWithIndexPath:indexPath];
        return cell;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        NSString *content  = @"2019-01-18 23:49:21\nJPY 300,000\n 支付宝 \n单号9581\n剩余 JPY 215,200\n状态 未确认";
           CGSize size = [content getStrSizeWithSize:CGSizeMake(KScaleWidth(150), 3000) font:K_Font_Text_Normal_Max];
        return size.height+KScaleHeight(28);
    }
    return KScaleHeight(56);
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
    
}

@end
