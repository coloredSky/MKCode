//
//  MKBillDetailViewController.m
//  MK
//
//  Created by 周洋 on 2019/4/8.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKBillDetailViewController.h"
//View
#import "BillDetailHeaderCell.h"
#import "BillDetailPayTimeCell.h"
#import "UserBillListModel.h"

@interface MKBillDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSArray *sectionTitleArr;
@end

@implementation MKBillDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_deepGrayColor;
    [self.contentTable reloadData];
}

#pragma mark --  request
-(void)startRequest
{
}


#pragma mark --  lazy

-(NSArray *)sectionTitleArr
{
    if (!_sectionTitleArr) {
        _sectionTitleArr = @[@"",@"支付方式",@"单号",@"状态",@"交易日期"];
    }
    return _sectionTitleArr;
}

-(UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, K_NaviHeight, KScreenWidth, KScaleHeight(64))];
        [self.view addSubview:_headerView];
        _headerView.backgroundColor = [UIColor clearColor];
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(K_Padding_LeftPadding, _headerView.height-KScaleHeight(20+20), 200, KScaleHeight(20))];
        [_headerView addSubview:titleLab];
        [titleLab setFont:MKBoldFont(24) textColor:K_Text_BlackColor withBackGroundColor:nil];
        titleLab.text = @"订单详情";
    }
    return _headerView;
}

-(MKBaseTableView *)contentTable
{
    if (!_contentTable) {
        UIView *shadowView = [[UIView alloc]initWithFrame:CGRectMake(K_Padding_Home_LeftPadding, self.headerView.bottomY, KScreenWidth-K_Padding_Home_LeftPadding*2, KScreenHeight-self.headerView.height-K_NaviHeight-10)];
        [self.view addSubview:shadowView];
        shadowView.backgroundColor = [UIColor clearColor];
        shadowView.layer.shadowColor = K_Text_DeepGrayColor.CGColor;
        shadowView.layer.shadowRadius = 5.0f;
        shadowView.layer.shadowOffset = CGSizeMake(1, 1);
        shadowView.layer.shadowOpacity = .5;
        
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, 0, shadowView.width, shadowView.height) style:UITableViewStyleGrouped];
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
        _contentTable.backgroundColor = K_BG_WhiteColor;
        [shadowView addSubview:_contentTable];
        _contentTable.layer.masksToBounds = YES;
        _contentTable.layer.cornerRadius = 16;
        _contentTable.estimatedRowHeight = KScaleHeight(56);
        [_contentTable registerNib:[UINib nibWithNibName:@"BillDetailHeaderCell" bundle:nil] forCellReuseIdentifier:@"BillDetailHeaderCell"];
        [_contentTable registerNib:[UINib nibWithNibName:@"BillDetailPayTimeCell" bundle:nil] forCellReuseIdentifier:@"BillDetailPayTimeCell"];
    }
    return _contentTable;
}

#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BillDetailHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BillDetailHeaderCell" forIndexPath:indexPath];
        [cell cellRefreshDataWithUserBillListModel:self.billModel];
        return cell;
    }else{
        BillDetailPayTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BillDetailPayTimeCell" forIndexPath:indexPath];
        if (indexPath.section == 1) {
            [cell cellRefreshOrderDataWithUserBillListModel:self.billModel];
        }else{
            [cell cellRefreshPayRecordDataWithIndexPath:indexPath sectionTitleArr:self.sectionTitleArr UserBillListModel:self.billModel];
        }
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2+self.billModel.payments.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else{
        return self.sectionTitleArr.count;
    }
    return 0;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return KScaleWidth(180);
    }
    return KScaleHeight(24);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 ||section == 2) {
        return KScaleHeight(30);
    }
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section >= 2) {
        return 10;
    }
    return CGFLOAT_MIN;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1 ||section == 2) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.contentTable.width, KScaleHeight(30))];
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, headerView.height)];
        [headerView addSubview:titleLab];
        [titleLab setFont:MKBoldFont(15) textColor:K_Text_BlackColor withBackGroundColor:nil];
        if (section == 1) {
            titleLab.text = @"单号";
        }else{
           titleLab.text = @"交易记录";
        }
        return headerView;
    }
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
