//
//  DiscoverCourseCategoryView.m
//  MK
//
//  Created by 周洋 on 2019/3/18.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "DiscoverCourseCategoryView.h"
//View
#import "CourseCategoryCell.h"

@interface DiscoverCourseCategoryView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *contentCollectionView;
@end

@implementation DiscoverCourseCategoryView
@synthesize delegate;

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        CGFloat itemWidth = (KScreenWidth-25*2-18*3)/4;
        UICollectionViewFlowLayout *defaultLaout = [[UICollectionViewFlowLayout alloc]init];
        defaultLaout.itemSize = CGSizeMake(itemWidth, itemWidth);
        defaultLaout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        defaultLaout.sectionInset = UIEdgeInsetsMake(0, 25, 0, 25);
        defaultLaout.minimumInteritemSpacing  = 0;//行间距
        defaultLaout.minimumLineSpacing = 18;//列间距
        _contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:defaultLaout];
        _contentCollectionView.backgroundColor = K_BG_deepGrayColor;
        [self addSubview:_contentCollectionView];
        [_contentCollectionView registerNib:[UINib nibWithNibName:@"CourseCategoryCell" bundle:nil] forCellWithReuseIdentifier:@"CourseCategoryCell"];
        _contentCollectionView.delegate = self;
        _contentCollectionView.dataSource = self;
    }
    return self;
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CourseCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CourseCategoryCell" forIndexPath:indexPath];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

#pragma mark --  cell did selected
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([delegate respondsToSelector:@selector(itemDidSelectedWithIndex:)]) {
        [delegate itemDidSelectedWithIndex:indexPath.row];
    }
}
#pragma mark --  reload data
-(void)CourseCategoryViewReloadData
{
    [self.contentCollectionView reloadData];
}
@end
