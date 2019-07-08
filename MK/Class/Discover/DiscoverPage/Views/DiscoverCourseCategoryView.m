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
#import "MKCourseListModel.h"


@interface DiscoverCourseCategoryView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *contentCollectionView;
@property (nonatomic, strong) NSArray <MKCourseListModel *>*dataList;
@end

@implementation DiscoverCourseCategoryView
@synthesize delegate;

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        CGFloat itemWidth = (KScreenWidth-20*2-8*3)/4;
        UICollectionViewFlowLayout *defaultLaout = [[UICollectionViewFlowLayout alloc]init];
        defaultLaout.itemSize = CGSizeMake(itemWidth, itemWidth);
        defaultLaout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        defaultLaout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
        defaultLaout.minimumInteritemSpacing  = 0;//行间距
        defaultLaout.minimumLineSpacing = 8;//列间距
        _contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:defaultLaout];
        _contentCollectionView.backgroundColor = K_BG_deepGrayColor;
        _contentCollectionView.delegate = self;
        _contentCollectionView.dataSource = self;
        [self addSubview:_contentCollectionView];
        _contentCollectionView.showsVerticalScrollIndicator = NO;
        _contentCollectionView.showsHorizontalScrollIndicator = NO;
        [_contentCollectionView registerNib:[UINib nibWithNibName:@"CourseCategoryCell" bundle:nil] forCellWithReuseIdentifier:@"CourseCategoryCell"];
    }
    return self;
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CourseCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CourseCategoryCell" forIndexPath:indexPath];
    MKCourseListModel *courseModel = self.dataList[indexPath.row];
    [cell.contentIma sd_setImageWithURL:[NSURL URLWithString:courseModel.courseImage] placeholderImage:K_MKPlaceholderImage1_1];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

#pragma mark --  cell did selected
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([delegate respondsToSelector:@selector(itemDidSelectedWithIndex:)]) {
        [delegate itemDidSelectedWithIndex:indexPath.row];
    }
}
#pragma mark --  reload data
-(void)CourseCategoryViewReloadDataWithList:(NSArray <MKCourseListModel  *>*)dataList
{
    self.dataList = dataList;
    [self.contentCollectionView reloadData];
}
@end
