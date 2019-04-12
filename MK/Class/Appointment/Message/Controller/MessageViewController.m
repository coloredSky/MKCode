//
//  MessageViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/27.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MessageViewController.h"
//View
#import "MessageCell.h"
//Model
#import "MKMessageModel.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) NSMutableArray *messageArr;
@property (nonatomic, strong) MKMessageModel *selectedMessageModel;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_YellowColor;
    for (int i=0; i<5; i++) {
        MKMessageModel *model = [[MKMessageModel alloc]init];
        [self.messageArr addObject:model];
        [self.contentTable reloadData];
    }
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
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:_contentTable];
        if (@available(ios 11.0,*)) {
            _contentTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleHeight(190))];
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(K_Padding_Home_LeftPadding, headerView.height-KScaleHeight(40*2), 200, KScaleHeight(40))];
        [headerView addSubview:titleLab];
        [titleLab setFont:MKBoldFont(24) textColor:K_Text_BlackColor withBackGroundColor:nil];
        titleLab.text = @"消息中心";
        _contentTable.tableHeaderView = headerView;
        _contentTable.backgroundColor = K_BG_YellowColor;
        [_contentTable registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:@"MessageCell"];
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
    }
    return _contentTable;
}
-(NSMutableArray *)messageArr
{
    if (!_messageArr) {
        _messageArr = [NSMutableArray array];
    }
    return _messageArr;
}
#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    MKMessageModel *model = self.messageArr[indexPath.section];
    [cell cellRefreshDataWithSelected:model.cellSelected];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.messageArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MKMessageModel *model = self.messageArr[indexPath.section];
    if (model.cellSelected) {
        return model.cellHeight;
    }
    return KScaleHeight(135);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return KScaleHeight(20);
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
#pragma mark - cell did selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"====");
    MKMessageModel *model = self.messageArr[indexPath.section];
    if (self.selectedMessageModel == model) {
        model.cellSelected = !model.cellSelected;
        [self.contentTable reloadData];
        return;
    }
    self.selectedMessageModel.cellSelected = NO;
    self.selectedMessageModel = model;
    model.cellSelected = YES;
    [self.contentTable reloadData];
}

@end
