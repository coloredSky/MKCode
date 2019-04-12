//
//  OrderDetailController.m
//  MK
//
//  Created by ginluck on 2019/4/6.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "OrderDetailController.h"
#import "OrderDetailCell.h"
#import "OrderDetailCell_2.h"
@interface OrderDetailController()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)IBOutlet  UIView  * bgView;
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) NSArray  *dataAry;
@end
@implementation OrderDetailController

#pragma mark --- instancetype method
-(instancetype)init
{
    if (self = [super init]) {
        self.dataAry =@[@"单号",@"套餐",@"缴费日期",@"下次缴费日期",@"登录时间",@"登录人",@"备注"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =K_BG_WhiteColor;
    [self.bgView addSubview:self.contentTable];
}
#pragma mark --  lazy
-(MKBaseTableView *)contentTable
{
    if (!_contentTable) {
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, 5, KScreenWidth-40,self.bgView.size.height-5) style:UITableViewStyleGrouped];
        [self.view addSubview:_contentTable];
        _contentTable.backgroundColor = [UIColor clearColor];
        [_contentTable registerNib:[UINib nibWithNibName:@"OrderDetailCell" bundle:nil] forCellReuseIdentifier:@"OrderDetailCell"];
        [_contentTable registerNib:[UINib nibWithNibName:@"OrderDetailCell_2" bundle:nil] forCellReuseIdentifier:@"OrderDetailCell_2"];
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
    }
    return _contentTable;
}

#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==2) {
        OrderDetailCell_2 *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailCell_2" forIndexPath:indexPath];
          cell.titleLab.text =self.dataAry[indexPath.row];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailCell" forIndexPath:indexPath];
        cell.titleLab.text =self.dataAry[indexPath.row];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        cell.detailLab.text =@"";
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
    if (indexPath.row ==2) {
        return 94.f;
    }
    return 40.f;
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
#pragma mark -- course category did selected
-(void)itemDidSelectedWithIndex:(NSUInteger )index
{
    
}
@end
