//
//  MyCenterCollectionViewFlowLayout.m
//  MK
//
//  Created by 周洋 on 2019/7/25.
//  Copyright © 2019 周洋. All rights reserved.
//

static CGFloat const MyCenterCollectionViewHorizontalPadding = 2;
static CGFloat const MyCenterCollectionViewVertialPadding = 5;

#import "MyCenterCollectionViewFlowLayout.h"
@interface MyCenterCollectionViewFlowLayout()

@property (nonatomic, strong) NSMutableArray *cellAttributes;
@property (nonatomic, assign) CGSize section1ItemSize;
@property (nonatomic, assign) CGSize section2ItemSize;
@end

@implementation MyCenterCollectionViewFlowLayout



-(instancetype)init
{
    if (self = [super init]) {
        self.cellAttributes = [NSMutableArray array];
        CGFloat itemOneWidth = (KScreenWidth - K_Padding_Home_LeftPadding *2 -MyCenterCollectionViewHorizontalPadding)/2;
        self.section1ItemSize = CGSizeMake(itemOneWidth, itemOneWidth*101/156);
        CGFloat itemTwoWidth = (KScreenWidth - K_Padding_Home_LeftPadding *2 -MyCenterCollectionViewHorizontalPadding*2)/3;
        self.section2ItemSize = CGSizeMake(itemTwoWidth, itemTwoWidth*92/101);
    }
    return self;
}

- (CGSize)collectionViewContentSize
{
    [super collectionViewContentSize];
    double numSection1Item = (double)[self.collectionView numberOfItemsInSection:0];
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:numSection1Item-1 inSection:1];
     UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:lastIndexPath];
    return CGSizeMake(KScreenWidth, CGRectGetMaxY(attributes.frame)+40);
}

-(void)prepareLayout
{
    [super prepareLayout];
    [self.cellAttributes removeAllObjects];
    UICollectionViewLayoutAttributes *headerAttribute = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [self.cellAttributes addObject:headerAttribute];
    
    NSInteger itemsSection1Count = [self.collectionView numberOfItemsInSection:0];
    for (int i=0; i<itemsSection1Count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *cellAttribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.cellAttributes addObject:cellAttribute];
    }
    NSInteger itemsSection2Count = [self.collectionView numberOfItemsInSection:1];
    for (int i=0; i<itemsSection2Count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:1];
        UICollectionViewLayoutAttributes *cellAttribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.cellAttributes addObject:cellAttribute];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.cellAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    if (indexPath.section == 0) {
        attributes.frame = CGRectMake(K_Padding_Home_LeftPadding+(self.section1ItemSize.width+MyCenterCollectionViewHorizontalPadding)*(indexPath.row%2), 39+(self.section1ItemSize.height+MyCenterCollectionViewVertialPadding)*(indexPath.row/2), self.section1ItemSize.width, self.section1ItemSize.height);
    }else{
        double numSection1Item = (double)[self.collectionView numberOfItemsInSection:0];
        attributes.frame = CGRectMake(K_Padding_Home_LeftPadding+(self.section2ItemSize.width+MyCenterCollectionViewHorizontalPadding)*(indexPath.row%3), 39 +(ceil(numSection1Item/2))*(self.section1ItemSize.height+MyCenterCollectionViewVertialPadding)+30+(self.section2ItemSize.height+MyCenterCollectionViewVertialPadding)*(indexPath.row/3), self.section2ItemSize.width, self.section2ItemSize.height);
    }
    return  attributes;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if (elementKind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.frame =CGRectMake(0, 0,KScreenWidth ,KScaleWidth(180));
            return attributes;
        }
    }
    return nil;
}


@end
