//
//  MyCenterViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/11.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MyCenterViewController.h"
#import "MyCenterTopCell.h"
#import "MyCenterBottomoCell.h"
@interface MyCenterViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *titleArr;//区头标题
@property (nonatomic, strong) NSArray *bannerArr;//banner 图片
@end

@implementation MyCenterViewController
#pragma mark --- instancetype method
-(instancetype)init
{
    if (self = [super init]) {
        self.titleArr = @[@[@"我的账单",@"bookmark",@"通知设置",@"更改密码"],@[@"隐私声明",@"support",@"Feedback",@"更新",@"服务条款",@"Logout"]];
        self.bannerArr = @[@[@"MyCenter_Cash",@"MyCenter_bookmark",@"MyCenter_message",@"MyCenter_password"],@[@"MyCenter_secure",@"MyCenter_help",@"MyCenter_feedback",@"MyCenter_update",@"MyCenter_service",@"MyCenter_log out"]];
    }
    return self;
}

#pragma mark --- destruct method
-(void)dealloc
{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_deepGrayColor;
    [self.view addSubview:self.collectionView];
    //refresh
    //    [self setUpRefresh];
    //request
    [self startRequest];
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
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[MyCenterTopCell class] forCellWithReuseIdentifier:@"MyCenterTopCell"];
        [_collectionView registerClass:[MyCenterBottomoCell class] forCellWithReuseIdentifier:@"MyCenterBottomoCell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return _collectionView;
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

// 点击高亮
//- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor greenColor];
//}


// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}



#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0)
    {
        CGSize size={156,101};
        return size;
    }
    else
    {
        CGSize size={100,92};
        return size;
    }
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 12, 5, 12);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){KScreenWidth,22};
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return (CGSize){KScreenWidth,22};
}




@end
