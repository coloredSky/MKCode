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
        self.titleArr = @[@[@"我的账单",@"bookmark",@"通知设置",@"更改密码"],@[@"隐私声明",@"support",@"Feedback",@"更新",@"服务条款",@"Logout"]];
        self.bannerArr = @[@[@"MyCenter_Cash",@"MyCenter_bookmark",@"MyCenter_message",@"MyCenter_password"],@[@"MyCenter_secure",@"MyCenter_help",@"MyCenter_feedback",@"MyCenter_update",@"MyCenter_service",@"MyCenter_log out"]];
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
    //request
    [self startRequest];
    [self addCenterNoti];
}

-(void)addCenterNoti
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(logoinTarget:) name:kMKLoginInNotifcationKey object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(logoOutTarget:) name:kMKLoginOutNotifcationKey object:nil];
}

#pragma mark --  request
-(void)startRequest
{
}

#pragma mark --  lazy
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 203, KScreenWidth, KScreenHeight-203) collectionViewLayout:layout];
        _collectionView.backgroundColor = K_BG_GrayColor;
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
        _headerView.frame =CGRectMake(0, 0,KScreenWidth ,203);
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
        if(headerView == nil)
        {
            headerView = [[UICollectionReusableView alloc] init];
        }
        headerView.backgroundColor = [UIColor grayColor];
        
        return headerView;
    }
    else if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        UICollectionReusableView *footerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        if(footerView == nil)
        {
            footerView = [[UICollectionReusableView alloc] init];
        }
        footerView.backgroundColor = [UIColor lightGrayColor];
        
        return footerView;
    }
    
    return nil;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    
}

#pragma mark ---- UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
            [self.navigationController pushViewController:policyVC animated:YES];
        }
        if (indexPath.item ==1)
        {
            SupportController * svc =[SupportController new];
            svc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:svc animated:YES];
        }
        if (indexPath.item ==2)
        {
            FeedBackController *fvc =[FeedBackController new];
            fvc.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:fvc animated:YES];
        }
        if (indexPath.item ==3)
        {
            VersionUpdateController * vc =[VersionUpdateController new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.item ==4)
        {
            PolicyViewController *policyVC = [PolicyViewController new];
            policyVC.titleString = @"服务条款";
            [self.navigationController pushViewController:policyVC animated:YES];
        }
        if (indexPath.item ==5)
        {
            [self loginOutAlterViewShow];
        }
    }
   
}



#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0)
    {
        CGSize size={KScaleWidth(160),KScaleWidth(90)};
        return size;
    }
    else
    {
        CGSize size={KScaleWidth(100),KScaleWidth(90)};
        return size;
    }
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 20, 10, 20);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.1f;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){KScreenWidth,0.1};
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return (CGSize){KScreenWidth,0.1};
}


#pragma mark-headerViewDelegate
-(void)headerViewBtnClickWithOperationType:(MyCenterHeaderViewOperationType )operationType
{
    if ([[UserManager shareInstance] isLogin ]==YES)
    {

    if (operationType == MyCenterHeaderViewOperationTypeLoginIn)
    {
          LoginActionController *loginVC = [LoginActionController new];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    else
    {
        if (![[UserManager shareInstance]isLogin])
        {
            [self loginAlterViewShow];
            return;
        }

        UpdateMessageController * uvc =[UpdateMessageController new];
        uvc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:uvc animated:YES];
       }
    }
    else
    {

    if (![[UserManager shareInstance]isLogin]) {
        [self loginAlterViewShow];
       }
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
