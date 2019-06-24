//
//  BasicInfoController.m
//  MK
//
//  Created by ginluck on 2019/3/30.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "BasicInfoController.h"
#import "BasicInfoCell.h"
#import "BasicInfoManager.h"
#import "userInfo.h"

@interface BasicInfoController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) NSArray *celltitleArr;//标题数组
@property (nonatomic, strong) NSArray *sectionTileArr;//区头数组
@property(nonatomic,strong)NSArray * contentArr;//内容数组
@property(nonatomic,strong)userInfo * userInfoModel;



@end

@implementation BasicInfoController
#pragma mark --- instancetype method
-(instancetype)init
{
    if (self = [super init]) {
        self.celltitleArr = @[@[@"姓",@"名"],@[@"姓",@"名"],@[@"中国手机",@"日本手机",@"Email",@"微信",@"QQ",@"城市"]];
        self.sectionTileArr =@[@"汉字",@"读音",@"联系方式"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =K_BG_WhiteColor;
    [self.contentTable reloadData];
}

-(void)setOriginalModel:(PersonModel *)originalModel
{
    _originalModel =originalModel;
    self.userInfoModel = [_originalModel.userInfo copy];
    [self.contentTable reloadData];
}

#pragma mark --  lazy
-(MKBaseTableView *)contentTable
{
    if (!_contentTable) {
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-(K_NaviHeight+190)) style:UITableViewStyleGrouped];
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
        _contentTable.showsVerticalScrollIndicator = NO;
        _contentTable.showsHorizontalScrollIndicator = NO;
        _contentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.01)];
        _contentTable.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.01)];
        [self.view addSubview:_contentTable];
        _contentTable.backgroundColor = K_BG_WhiteColor;
        [_contentTable registerNib:[UINib nibWithNibName:@"BasicInfoCell" bundle:nil] forCellReuseIdentifier:@"BasicInfoCell"];
    }
    return _contentTable;
}
#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BasicInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BasicInfoCell" forIndexPath:indexPath];
//    @weakObject(self);
    cell.BasicInfoCellTFContentChangeBlock = ^(NSString * _Nonnull contentString, UITextField * _Nonnull sender) {
    };
    cell.ttLabel.text = self.celltitleArr[indexPath.section][indexPath.row];
    [cell cellBasicInfoRefreshDataWithUserInfo:self.userInfoModel indexPath:indexPath];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionTileArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * titleAry =self.celltitleArr[section];
    return titleAry.count;
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
    if (section == self.sectionTileArr.count-1) {
        return 130;
    }
    return CGFLOAT_MIN;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * bgView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    bgView.backgroundColor =K_BG_WhiteColor;
    UILabel  * label  =[[UILabel alloc]initWithFrame:CGRectMake(26, 15, KScreenWidth-52, 25)];
    [label setFont:MKFont(13) textColor:UIColorFromRGB_0x(0x707070) withBackGroundColor:[UIColor clearColor]];
    label.text =self.sectionTileArr [section];
    [bgView addSubview:label];
    return bgView;
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == self.sectionTileArr.count-1) {
        UIView * bgView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 130)];
        bgView.backgroundColor =K_BG_WhiteColor;
        
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =CGRectMake(26, 55, KScreenWidth-52, 60);
        [btn setNormalTitle:@"保存" font:MKFont(14) titleColor:K_Text_DeepGrayColor];
       btn.backgroundColor =UIColorFromRGB_0x(0xfdf303);
        btn.layer.cornerRadius =5.f;
        btn.layer.masksToBounds =YES;
        [bgView addSubview:btn];
        [btn addTarget:self action:@selector(submitTarget:) forControlEvents:UIControlEventTouchUpInside];
        return bgView;
    }
    return nil;
}

#pragma mark --  EVENT
#pragma mark - cell did selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark --  提交
-(void)submitTarget:(UIButton *)sender
{
    if (self.userInfoModel.firstname == self.originalModel.userInfo.firstname &&
        self.userInfoModel.lastname == self.originalModel.userInfo.lastname &&
        self.userInfoModel.firstkana == self.originalModel.userInfo.firstkana &&
        self.userInfoModel.lastkana == self.originalModel.userInfo.lastkana &&
        self.userInfoModel.mobile == self.originalModel.userInfo.mobile &&
        self.userInfoModel.mobile_jp == self.originalModel.userInfo.mobile_jp &&
        self.userInfoModel.email == self.originalModel.userInfo.email &&
        self.userInfoModel.weixin == self.originalModel.userInfo.weixin &&
        self.userInfoModel.qq == self.originalModel.userInfo.qq &&
        self.userInfoModel.city == self.originalModel.userInfo.city) {
        [MBHUDManager showBriefAlert:@"请修改后保存！"];
        return;
    }
    [BasicInfoManager callBackUpdateBasicInfoWithHudShow:NO lastname:self.userInfoModel.lastname firstname:self.userInfoModel.firstname lastkana:self.userInfoModel.lastkana firstkana:self.userInfoModel.firstkana mobile:self.userInfoModel.mobile mobile_jp:self.userInfoModel.mobile_jp email:self.userInfoModel.email weixin:self.userInfoModel.weixin qq:self.userInfoModel.qq province:@"" city:self.userInfoModel.city CompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message) {
        if (isSuccess) {
            [MBHUDManager showBriefAlert:@"修改成功！"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            if (![NSString isEmptyWithStr:message]) {
                [MBHUDManager showBriefAlert:message];
            }
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
