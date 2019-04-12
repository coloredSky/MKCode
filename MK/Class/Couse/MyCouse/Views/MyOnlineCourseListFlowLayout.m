//
//  MyOnlineCourseListFlowLayout.m
//  MK
//
//  Created by 周洋 on 2019/4/10.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MyOnlineCourseListFlowLayout.h"

@interface MyOnlineCourseListFlowLayout()
@property (nonatomic, strong) NSMutableArray *itemAttribuitesArr;
@end
@implementation MyOnlineCourseListFlowLayout

-(instancetype)init
{
    if (self = [super init]) {
        _itemAttribuitesArr = [NSMutableArray array];
    }
    return self;
}

-(void)prepareLayout
{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.itemSize = CGSizeMake(KScreenWidth-K_Padding_Home_LeftPadding-KScaleWidth(50), KScaleHeight(60));
    NSInteger itemsCount = [self.collectionView numberOfItemsInSection:0];
    for (int i=0; i<itemsCount; i++) {
        NSIndexPath *indesPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indesPath];
        [self.itemAttribuitesArr addObject:attributes];
    }
}
- (CGSize)collectionViewContentSize
{
    NSInteger itemsCount = [self.collectionView numberOfItemsInSection:0];
    CGFloat height = itemsCount < 3 ? (self.itemSize.height*itemsCount) : KScaleHeight(180);
    return CGSizeMake(KScreenWidth*(itemsCount/3+1), height);
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.itemAttribuitesArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = CGRectMake(K_Padding_Home_LeftPadding+(self.itemSize.width)*(indexPath.row/3), (self.itemSize.height)*(indexPath.row%3), self.itemSize.width, self.itemSize.height);
    return attributes;
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    NSInteger index = (proposedContentOffset.x-K_Padding_Home_LeftPadding)/self.itemSize.width;
    CGFloat offsetX = index == 0 ? 0:self.itemSize.width*index;
    CGPoint targetPoint = CGPointMake(offsetX, 0);
    return targetPoint;
//    CGFloat miniDistance = MAXFLOAT;
//    for (UICollectionViewLayoutAttributes *attributes in self.itemAttribuitesArr) {
//        if (ABS(miniDistance) > ABS(attributes.frame.origin.x-attributes.frame.origin.x)) {
//            miniDistance = proposedContentOffset.x-attributes.frame.origin.x;
//        }
//    }
//    proposedContentOffset.x += miniDistance;
//    proposedContentOffset.x -= K_Padding_Home_LeftPadding;
//    return proposedContentOffset;
}
@end
