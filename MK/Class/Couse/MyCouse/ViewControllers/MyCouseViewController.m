//
//  MyCouseViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/11.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MyCouseViewController.h"
#import "CourseDetailViewController.h"

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
    [cell cellRefreshDataWithIndexPath:indexPath];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KScaleHeight(60);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return KScaleHeight(40);
    }else if (section ==1){
        return KScaleHeight(70);
    }
    return KScaleHeight(35);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, KScreenWidth, [self tableView:tableView heightForHeaderInSection:section]);
    headerView.backgroundColor =K_Text_WhiteColor;
    
    if (section <= 1) {
        
        UIImageView *lineIma = [UIImageView new];
        lineIma.backgroundColor = K_Line_lineColor;
        [headerView addSubview:lineIma];
        lineIma.frame = CGRectMake(28, 0, KScreenWidth-28, K_Line_lineWidth);
        
        UILabel *titleLab = [UILabel new];
        [headerView addSubview:titleLab];
        titleLab.text = section ==0?@"线上课程":@"线下课程";
        if (section ==0) {
            titleLab.frame = CGRectMake(28, KScaleHeight(10), 200, 22);
        }else if (section == 1){
            titleLab.frame = CGRectMake(28, KScaleHeight(10), 200, 22);
            UILabel *courseTypeLab = [UILabel new];
            [headerView addSubview:courseTypeLab];
            courseTypeLab.frame = CGRectMake(titleLab.leftX, titleLab.bottomY+KScaleHeight(5), titleLab.width, KScaleHeight(16));
            [courseTypeLab setFont:K_Font_Text_Min_Max textColor:K_Text_DeepGrayColor withBackGroundColor:nil];
            courseTypeLab.text = @"正在进行的课程";
        }
    }else{
        UILabel *courseTypeLab = [UILabel new];
        [headerView addSubview:courseTypeLab];
        courseTypeLab.frame = CGRectMake(28, headerView.height-KScaleHeight(20)-KScaleHeight(5), 200, KScaleHeight(20));
        [courseTypeLab setFont:K_Font_Text_Min_Max textColor:K_Text_DeepGrayColor withBackGroundColor:nil];
        courseTypeLab.text = @"还未开始的课程";
    }

    UIImageView *bottomLine = [UIImageView new];
    [headerView addSubview:bottomLine];
    bottomLine.backgroundColor = K_Line_lineColor;
    bottomLine.frame = CGRectMake(110, headerView.height-K_Line_lineWidth, headerView.width-110, K_Line_lineWidth);
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
    CourseDetailViewController *detailVC = [CourseDetailViewController new];
    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
