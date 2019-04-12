//
//  BillListCollectionViewFlowLayout.m
//  MK
//
//  Created by 周洋 on 2019/4/4.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "BillListCollectionViewFlowLayout.h"
@interface BillListCollectionViewFlowLayout()
@property (nonatomic, strong) NSMutableArray *itemAttributesArr;
@end
@implementation BillListCollectionViewFlowLayout
-(instancetype)init
{
    if (self = [super init]) {
        self.itemAttributesArr = [NSMutableArray array];
    }
    return self;
}

-(void)prepareLayout
{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.itemSize = CGSizeMake(KScreenWidth, KScaleWidth(180));
    NSInteger itemsCount = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i=0; i<itemsCount; i++) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes * attrs=[self layoutAttributesForItemAtIndexPath:indexPath];
        [self.itemAttributesArr addObject:attrs];
    }
}

- (CGSize)collectionViewContentSize
{
    NSInteger itemsCount = [self.collectionView numberOfItemsInSection:0];
    CGFloat height =  (self.itemSize.height-KScaleHeight(60))*itemsCount+self.itemSize.height+20;
    return CGSizeMake(KScreenWidth, height);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.itemAttributesArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    itemAttributes.frame = CGRectMake(0, (self.itemSize.height-KScaleHeight(60))*indexPath.row, self.itemSize.width, self.itemSize.height);
    itemAttributes.zIndex = indexPath.row;
    return itemAttributes;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
@end
