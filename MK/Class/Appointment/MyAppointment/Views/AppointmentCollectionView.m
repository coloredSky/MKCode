//
//  AppointmentCollectionView.m
//  MK
//
//  Created by 周洋 on 2019/3/20.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "AppointmentCollectionView.h"
#import "AppointmentCollectionViewCell.h"
#import "AppointmentListModel.h"
@interface AppointmentCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *contentCollectionView;
@property (nonatomic, strong) NSArray *appointmentList;
@end
@implementation AppointmentCollectionView
@synthesize delegate;

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = K_BG_WhiteColor;
    }
    return self;
}

-(UICollectionView *)contentCollectionView
{
    if (!_contentCollectionView) {
        CGSize itemSize = CGSizeMake(KScaleWidth(230), KScaleWidth(144));
        UICollectionViewFlowLayout *defaultLaout = [[UICollectionViewFlowLayout alloc]init];
        defaultLaout.itemSize = itemSize;
        defaultLaout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        defaultLaout.sectionInset = UIEdgeInsetsMake(0, K_Padding_Home_LeftPadding, 0, K_Padding_Home_LeftPadding);
        defaultLaout.minimumInteritemSpacing  = 0;//行间距
        defaultLaout.minimumLineSpacing = 30;//列间距
        _contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:defaultLaout];
        _contentCollectionView.showsVerticalScrollIndicator = NO;
        _contentCollectionView.showsHorizontalScrollIndicator = NO;
        _contentCollectionView.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentCollectionView];
        
        [_contentCollectionView registerNib:[UINib nibWithNibName:@"AppointmentCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"AppointmentCollectionViewCell"];
        _contentCollectionView.delegate = self;
        _contentCollectionView.dataSource = self;
    }
    return _contentCollectionView;
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AppointmentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AppointmentCollectionViewCell" forIndexPath:indexPath];
    AppointmentListModel *model = self.appointmentList[indexPath.row];
    [cell cellRefreshDataWithDisplayType:self.dispayType andAppointmentListModel:model];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.appointmentList.count;
}

#pragma mark --  cell did selected
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
        if ([delegate respondsToSelector:@selector(appointmentCollectionViewItemDidSelectedWithIndexPath:)]) {
            [delegate appointmentCollectionViewItemDidSelectedWithIndexPath:indexPath];
        }
}
#pragma mark --  reload data
-(void)appointmentCollectionViewReloadDataWithAppointmentList:(NSArray *)appointmentList
{
    [self.contentCollectionView reloadData];
}

@end
