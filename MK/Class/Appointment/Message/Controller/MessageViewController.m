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
#import "MessageManager.h"
#import "MKMessageModel.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) MKMessageModel *selectedMessageModel;

@property (nonatomic, assign) NSInteger pageOffset;//条数起始值
@property (nonatomic, assign) NSInteger pageLimit;//条数
@property (nonatomic, strong) NSMutableArray *messageList;
@end

@implementation MessageViewController

-(instancetype)init
{
    if (self = [super init]) {
        self.pageLimit = 5;
        self.pageOffset = 0;
        self.messageList = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_YellowColor;
    [self startRequest];
    [self setUpHeaderRefresh];
}

#pragma mark --  refresh
-(void)setUpHeaderRefresh
{
    //下拉刷新
    @weakObject(self);
    self.contentTable.mj_header = [XHRefreshHeader headerWithRefreshingBlock:^{
        @strongObject(self);
        self.pageLimit = 5;
        self.pageOffset = 0;
        [self startRequest];
    }];
}
-(void)setUpFooterRefresh
{
    //上拉加载
    @weakObject(self);
    self.contentTable.mj_footer = [XHRefreshFooter footerWithRefreshingBlock:^{
        @strongObject(self);
        self.pageOffset += self.pageLimit;
        [self startRequest];
    }];
}

#pragma mark --  request
-(void)startRequest
{
    [MessageManager callBackMessageListDataWithLimit:self.pageLimit offset:self.pageOffset completionBlock:^(BOOL isSuccess, NSArray<MKMessageModel *> * _Nonnull messageList, NSString * _Nonnull message) {
        [self.contentTable.mj_header endRefreshing];
        if (isSuccess) {
            if (self.pageOffset == 0) {
                [self.messageList removeAllObjects];
                if (messageList.count == self.pageLimit) {
                    [self setUpFooterRefresh];
                }
            }
            if (messageList.count < self.pageLimit) {
                [self.contentTable.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.contentTable.mj_footer endRefreshing];
            }
            [self.messageList addObjectsFromArray:messageList];
            [self.contentTable reloadData];
        }else{
            self.pageOffset -= self.pageLimit;
            [self.contentTable.mj_footer endRefreshingWithNoMoreData];
        }
    }];
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

#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    MKMessageModel *model = self.messageList[indexPath.section];
    [cell cellRefreshDataWithMKMessageMode:model];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.messageList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MKMessageModel *model = self.messageList[indexPath.section];
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
    MKMessageModel *model = self.messageList[indexPath.section];
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
