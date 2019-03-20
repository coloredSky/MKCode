//
//  AppointmentChildViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/20.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "AppointmentChildViewController.h"
//View
#import "AppointmentCell.h"
#import "AppointmentCollectionView.h"
@interface AppointmentChildViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MKBaseTableView *contentTable;
@end

@implementation AppointmentChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpRefresh];
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
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight-(K_NaviHeight+KScaleHeight(20))-K_TabbarHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:_contentTable];
        _contentTable.backgroundColor = K_BG_WhiteColor;
        [_contentTable registerNib:[UINib nibWithNibName:@"AppointmentCell" bundle:nil] forCellReuseIdentifier:@"AppointmentCell"];
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
    }
    return _contentTable;
}

#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppointmentCell" forIndexPath:indexPath];
    [cell cellRefreshData];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 5;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KScaleHeight(80);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return KScaleHeight(45);
    }
    else if (section == 1){
        return KScaleHeight(60);
    }
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return KScaleWidth(145);
    }
    return CGFLOAT_MIN;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    float height = 0;
    if (section == 0) {
        height = KScaleHeight(45);
    }else{
        height = KScaleHeight(60);
    }
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, height)];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(K_Padding_Home_LeftPadding, headerView.height-20-KScaleHeight(12), 200, 20)];
    [headerView addSubview:titleLab];
    titleLab.text = @"公开课";
    [titleLab setFont:MKBoldFont(16) textColor:K_Text_grayColor withBackGroundColor:nil];
    return headerView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        AppointmentCollectionView *fotterView = [[AppointmentCollectionView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleWidth(145))];
        [fotterView appointmentCollectionViewReloadData];
        return fotterView;
    }
    return nil;
}
#pragma mark - cell did selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
