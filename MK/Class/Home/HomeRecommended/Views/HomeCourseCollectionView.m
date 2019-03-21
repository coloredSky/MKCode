//
//  HomeCourseCollectionView.m
//  MK
//
//  Created by 周洋 on 2019/3/19.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "HomeCourseCollectionView.h"
#import "HomeCourseCollectionViewCell.h"

@interface HomeCourseCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *contentCollectionView;
@end
@implementation HomeCourseCollectionView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(UICollectionView *)contentCollectionView
{
    if (!_contentCollectionView) {
//        CGFloat itemWidth = (KScreenWidth-25*2-18*3)/4;
        CGSize itemSize = CGSizeMake(KScaleWidth(194)+10, KScaleWidth(88)+10);
        UICollectionViewFlowLayout *defaultLaout = [[UICollectionViewFlowLayout alloc]init];
        defaultLaout.itemSize = itemSize;
        defaultLaout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        defaultLaout.sectionInset = UIEdgeInsetsMake(0, K_Padding_Home_LeftPadding-5, 0, K_Padding_Home_LeftPadding-5);
        defaultLaout.minimumInteritemSpacing  = 0;//行间距
        defaultLaout.minimumLineSpacing = 5;//列间距
        _contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:defaultLaout];
        _contentCollectionView.showsVerticalScrollIndicator = NO;
        _contentCollectionView.showsHorizontalScrollIndicator = NO;
        _contentCollectionView.backgroundColor = K_BG_deepGrayColor;
        [self addSubview:_contentCollectionView];
        
        [_contentCollectionView registerNib:[UINib nibWithNibName:@"HomeCourseCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HomeCourseCollectionViewCell"];
        _contentCollectionView.delegate = self;
        _contentCollectionView.dataSource = self;
    }
    return _contentCollectionView;
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HomeCourseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCourseCollectionViewCell" forIndexPath:indexPath];
    [cell cellRefreshData];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

#pragma mark --  cell did selected
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([delegate respondsToSelector:@selector(itemDidSelectedWithIndex:)]) {
//        [delegate itemDidSelectedWithIndex:indexPath.row];
//    }
}
#pragma mark --  reload data
-(void)homeCourseCollectionViewReloadData
{
    [self.contentCollectionView reloadData];
}
@end
