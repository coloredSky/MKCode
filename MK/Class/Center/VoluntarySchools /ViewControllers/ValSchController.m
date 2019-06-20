//
//  ValSchController.m
//  MK
//
//  Created by ginluck on 2019/3/30.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "ValSchController.h"
#import "BasicInfoCell.h"
#import "university.h"
@interface ValSchController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) NSArray *titleArr;//标题数组
@property (nonatomic, strong) NSArray *sectionArr;//区头数组

@property (nonatomic, strong) NSMutableArray *contentArr;//区头数组
@end

@implementation ValSchController

#pragma mark --- instancetype method
-(instancetype)init
{
    if (self = [super init]) {
        self.titleArr = @[@[@"学校名称",@"学部/研究科",@"学科/专攻"],@[@"学校名称",@"学部/研究科",@"学科/专攻"],@[@"学校名称",@"学部/研究科",@"学科/专攻"]];
        self.sectionArr =@[@"第一志愿",@"第二志愿",@"第三志愿"];
        self.contentArr =[NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =K_BG_WhiteColor;
    [self.view addSubview:self.contentTable];
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
-(void)setModel:(PersonModel *)model
{
    _model =model;
}
#pragma mark --  lazy
-(MKBaseTableView *)contentTable
{
    if (!_contentTable) {
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-(K_NaviHeight+190)) style:UITableViewStyleGrouped];
        [self.view addSubview:_contentTable];
        _contentTable.backgroundColor = K_BG_WhiteColor;
        [_contentTable registerNib:[UINib nibWithNibName:@"BasicInfoCell" bundle:nil] forCellReuseIdentifier:@"BasicInfoCell"];
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
    }
    return _contentTable;
}
#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BasicInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BasicInfoCell" forIndexPath:indexPath];
    NSArray * ary =self.titleArr[indexPath.section];
    cell.ttLabel.text =ary[indexPath.row];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    if (self.contentArr.count)
    {
        if (self.contentArr.count ==1&&indexPath.section ==0)
        {
            NSArray * arr =self.contentArr[0];
            cell.textField.text =arr[indexPath.row];
            
        }
        else if (self.contentArr.count==2 && indexPath.section <2)
        {
            NSArray * arr =self.contentArr[indexPath.section];
            cell.textField.text =arr [indexPath.row];
        }
        else if (self.contentArr.count ==3)
        {
            NSArray * arr =self.contentArr[indexPath.section];
            cell.textField.text =arr [indexPath.row];
        }
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * ary =self.titleArr[section];
    return ary.count;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section ==self.sectionArr.count-1) {
        return 130;
    }
    return .1f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * bgView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    bgView.backgroundColor =K_BG_WhiteColor;
    
    UILabel  * label  =[[UILabel alloc]initWithFrame:CGRectMake(26, 15, KScreenWidth-52, 25)];
    [label setFont:MKFont(13) textColor:UIColorFromRGB_0x(0x707070) withBackGroundColor:[UIColor clearColor]];
    label.text =self.sectionArr [section];
    [bgView addSubview:label];
    return bgView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section ==self.sectionArr.count-1) {
        UIView * bgView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 130)];
        bgView.backgroundColor =K_BG_WhiteColor;
        
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setNormalTitle:@"保存" font:MKFont(13) titleColor:K_Text_DeepGrayColor];
        btn.backgroundColor =UIColorFromRGB_0x(0xfdf303);
        btn.frame =CGRectMake(26, 55, KScreenWidth-52, 60);
        btn.layer.cornerRadius =5.f;
        btn.layer.masksToBounds =YES;
        [bgView addSubview:btn];
        return bgView;
    }
    return nil;
}

#pragma mark --  EVENT
#pragma mark - cell did selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - modelDatasource
-(void)createDataSource
{

    if (self.model.userInfo.university.count)
    {
        for (university * uni in self.model.userInfo.university) {
            NSMutableArray * u =[NSMutableArray array];
            [u  addObject:uni.university_name];
            [u addObject:uni.faculty_name];
            [u addObject:uni.discipline_name];
           [ self.contentArr addObject:u];
        }
    }
    if (self.contentArr.count>3) {
        [self.contentArr removeObjectsInRange:NSMakeRange(3, self.contentArr.count-3)];
    }
    [self.contentTable reloadData];
}
#pragma mark -viewappear
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createDataSource];
}


@end
