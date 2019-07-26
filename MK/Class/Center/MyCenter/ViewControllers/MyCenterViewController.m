//
//  MyCenterViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/11.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MyCenterViewController.h"
#import "MyBillListViewController.h"//订单列表
#import "MessageNoticeController.h"//消息通知
#import "SetPasswordController.h"//修改密码
#import "PolicyViewController.h"//隐私声明
#import "SupportController.h"//帮助
#import "VersionUpdateController.h"//版本更新
#import "BookmarkController.h"//书签
#import "FeedBackController.h"//反馈
#import "UpdateMessageController.h"//编辑个人资料
#import "OrderDetailController.h"//订单
#import "LoginActionController.h"
//views
#import "MyCenterTopCell.h"
#import "MyCenterBottomoCell.h"
#import "MyCenterHeaderView.h"
#import "MyCenterCollectionViewFlowLayout.h"

@interface MyCenterViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MyCenterHeaderViewDelegate>
@property (nonatomic, strong) MyCenterHeaderView *headerView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *titleArr;//区头标题
@property (nonatomic, strong) NSArray *bannerArr;//banner 图片
@end

@implementation MyCenterViewController

#pragma mark --- destruct method
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark --- instancetype method
-(instancetype)init
{
    if (self = [super init]) {
        self.titleArr = @[@[@"我的账单",@"bookmark",@"通知设置",@"更改密码"],@[@"隐私声明",@"Feedback",@"更新",@"服务条款",@"Logout"]];
        self.bannerArr = @[@[@"MyCenter_Cash",@"MyCenter_bookmark",@"MyCenter_message",@"MyCenter_password"],@[@"MyCenter_secure",@"MyCenter_feedback",@"MyCenter_update",@"MyCenter_service",@"MyCenter_log out"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_deepGrayColor;
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.collectionView];
    //refresh
    //    [self setUpRefresh];
    [self addCenterNoti];
}

-(void)addCenterNoti
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(logoinTarget:) name:kMKLoginInNotifcationKey object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(logoOutTarget:) name:kMKLoginOutNotifcationKey object:nil];
}

#pragma mark --  lazy
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        MyCenterCollectionViewFlowLayout *layout = [[MyCenterCollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.headerView.bottomY, KScreenWidth, KScreenHeight-self.headerView.height-K_TabbarHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = K_BG_deepGrayColor;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"MyCenterTopCell" bundle:nil] forCellWithReuseIdentifier:@"MyCenterTopCell"];
        [_collectionView  registerNib:[UINib nibWithNibName:@"MyCenterTopCell" bundle:nil] forCellWithReuseIdentifier:@"MyCenterBottomoCell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return _collectionView;
}

-(MyCenterHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[NSBundle mainBundle]loadNibNamed:@"MyCenterHeaderView" owner:nil options:nil][0];
        _headerView.frame =CGRectMake(0, 0,KScreenWidth ,KScaleWidth(130+K_StatusBarHeight));
        _headerView.delegate =self;
        [_headerView refreshData];
    }
    return _headerView;
}

#pragma mark - UICollectionViewDatasource
#pragma mark - cell
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.titleArr.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray * ary =self.titleArr [section];
    return ary.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        MyCenterTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCenterTopCell" forIndexPath:indexPath];
        cell.myCenterLab.text =self.titleArr[indexPath.section][indexPath.row];
        NSString * imageStr =self.bannerArr[indexPath.section][indexPath.row];
        cell.myCenterImage.image  =[UIImage imageNamed:imageStr];
        return cell;
    }
  else
  {
      MyCenterBottomoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCenterBottomoCell" forIndexPath:indexPath];
      cell.myCenterLab.text =self.titleArr[indexPath.section][indexPath.row];
      NSString * imageStr =self.bannerArr[indexPath.section][indexPath.row];
      cell.myCenterImage.image  =[UIImage imageNamed:imageStr];
      return cell;
      
  }
}

// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        if(headerView == nil){
            headerView = [[UICollectionReusableView alloc] init];
        }
        return headerView;
    }
    else if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        UICollectionReusableView *footerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        if(footerView == nil){
            footerView = [[UICollectionReusableView alloc] init];
        }
        return footerView;
    }
    return nil;
}

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (![[UserManager shareInstance]isLogin]) {
        [self loginAlterViewShow];
        return;
    }
    if (indexPath.section ==0)
    {
        if (indexPath.item ==0)
        {
            MyBillListViewController *billVC = [MyBillListViewController new];
            [self.navigationController pushViewController:billVC animated:YES];

        }
        if (indexPath.item ==1)
        {
            BookmarkController * bvc =[BookmarkController new];
            bvc.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:bvc animated:YES];
        }
        if (indexPath.item ==2)
        {
            MessageNoticeController * mvc =[MessageNoticeController new];
            mvc.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:mvc animated:YES];
        }
        if (indexPath.item ==3)
        {
            SetPasswordController * svc =[SetPasswordController new];
            svc.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:svc animated:YES];
        }
    }
    else
    {
        if (indexPath.item ==0)
        {
            PolicyViewController * policyVC =[PolicyViewController new];
            policyVC.titleString = @"隐私声明";
            //隐私声明地址
            policyVC.contentUrl = kMKPrivacyStatementUrl;
            [self.navigationController pushViewController:policyVC animated:YES];
        }
        if (indexPath.item ==1)
        {
            FeedBackController *fvc =[FeedBackController new];
            fvc.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:fvc animated:YES];
        }
        if (indexPath.item ==2)
        {
            VersionUpdateController * vc =[VersionUpdateController new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.item ==3)
        {
            PolicyViewController *policyVC = [PolicyViewController new];
            policyVC.titleString = @"服务条款";
            policyVC.contentUrl = kMKTheTermsOfServiceUrl;
            [self.navigationController pushViewController:policyVC animated:YES];
        }
        if (indexPath.item ==4)
        {
            [self loginOutAlterViewShow];
        }
    }
   
}

#pragma mark-headerViewDelegate
-(void)headerViewBtnClickWithOperationType:(MyCenterHeaderViewOperationType )operationType
{
    if (operationType == MyCenterHeaderViewOperationTypeEditUserInfo) {
        if (![[UserManager shareInstance]isLogin]){
            [self loginAlterViewShow];
            return;
        }
        UpdateMessageController * messageVC =[UpdateMessageController new];
        [self.navigationController pushViewController:messageVC animated:YES];
    }else if (operationType == MyCenterHeaderViewOperationTypeLoginIn){
        LoginActionController *loginVC = [LoginActionController new];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

#pragma mark --  登录
-(void)logoinTarget:(NSNotification *)noti
{
    [self.headerView refreshData];
}

#pragma mark --  登出
-(void)logoOutTarget:(NSNotification *)noti
{
    [self.headerView refreshData];
}

@end
