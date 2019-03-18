//
//  MyCouseViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/11.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MyCouseViewController.h"
#import "MyCouseCell.h"
#import "MyCouseHeaderView.h"
@interface MyCouseViewController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong)MyCouseHeaderView *headerView;
@property (nonatomic, strong) NSArray *titleArr;//区头标题
@property (nonatomic, strong) NSArray *bannerArr;//banner 图片
@end

@implementation MyCouseViewController



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
        [_contentTable registerNib:[UINib nibWithNibName:@"MyCouseCell" bundle:nil] forCellReuseIdentifier:@"MyCouseCell"];
        _contentTable.tableHeaderView = self.headerView;
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
    }
    return _contentTable;
}
-(MyCouseHeaderView *)headerView
{
    if (!_headerView) {
            _headerView = [[NSBundle mainBundle]loadNibNamed:@"MyCouseHeaderView" owner:nil options:nil][0];
        _headerView.frame =CGRectMake(0, 0,KScreenWidth ,KScreenWidth *136/375+60);
        [_headerView cellRefreshData];
    }
    return _headerView;
}
#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCouseCell" forIndexPath:indexPath];
    [cell cellRefreshData];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KScaleHeight(50.5);
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
    headerView.backgroundColor =K_Text_WhiteColor;
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(28, 0, 100, headerView.height)];
    [headerView addSubview:titleLab];
    [titleLab setFont:MKBoldFont(16) textColor:K_Text_BlackColor withBackGroundColor:nil];
    titleLab.text = section ==0?@"线上课程":@"线下课程";
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [headerView addSubview:button];
    [button setNormalTitle:@"all" font:MKBoldFont(13) titleColor:K_Text_BlueColor];
    return headerView;
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
