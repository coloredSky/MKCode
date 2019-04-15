//
//  MyOnlineCourseListView.m
//  MK
//
//  Created by 周洋 on 2019/4/10.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MyOnlineCourseListView.h"
#import "MyCourseOnlineListCollectionViewCell.h"
#import "MyOnlineCourseListFlowLayout.h"
#import "MyOfflineCourseListFlowLayout.h"
@interface MyOnlineCourseListView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *courseListCollection;
@property (nonatomic, strong) NSMutableArray *courseListArr;
@end
@implementation MyOnlineCourseListView
@synthesize delegate;
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

#pragma mark --  lazy
-(UICollectionView *)courseListCollection
{
    UICollectionViewFlowLayout *defaultFlowLauout;
    if (!_courseListCollection) {
        if (self.listViewShowType == UserCourseListViewShowTypeOnline) {
            defaultFlowLauout = [[MyOnlineCourseListFlowLayout alloc]init];
        }else{
            defaultFlowLauout = [[MyOfflineCourseListFlowLayout alloc]init];
        }
        _courseListCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:defaultFlowLauout];
        [self addSubview:_courseListCollection];
        _courseListCollection.backgroundColor = K_BG_WhiteColor;
        _courseListCollection.showsVerticalScrollIndicator = NO;
        _courseListCollection.showsHorizontalScrollIndicator = NO;
        _courseListCollection.delegate = self;
        _courseListCollection.dataSource = self;
        [_courseListCollection registerNib:[UINib nibWithNibName:@"MyCourseOnlineListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MyCourseOnlineListCollectionViewCell"];
    }
    return _courseListCollection;
}
-(NSMutableArray *)courseListArr
{
    if (!_courseListArr) {
        _courseListArr = [NSMutableArray array];
        if (self.listViewShowType == UserCourseListViewShowTypeOnline) {
            _courseListArr = @[@"",@"",@"",@"",@"",@"",@"",@""].mutableCopy;
        }else if (self.listViewShowType == UserCourseListViewShowTypeOfflineUnderWay) {
            _courseListArr = @[@"",@"",@"",@"",@"",@"",@"",@""].mutableCopy;
        }else if (self.listViewShowType == UserCourseListViewShowTypeOfflineNotStart) {
            _courseListArr = @[@"",@"",@"",@"",@"",@"",@"",@""].mutableCopy;
        }
    }
    return _courseListArr;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.courseListArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCourseOnlineListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCourseOnlineListCollectionViewCell" forIndexPath:indexPath];
    [cell cellRefreshDataWithIndexPath:indexPath withShowType:self.listViewShowType];
    return cell;
}

-(void)onlineCourseListViewRefreshDataWithContentArr:(NSMutableArray *)courseList
{
    [self.courseListCollection reloadData];
}

#pragma mark --  EVENT
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([delegate respondsToSelector:@selector(myOnlineCourseListViewDidSelectedCourseWithIndexPath: andUserCourseListViewShowType:)]) {
        [delegate myOnlineCourseListViewDidSelectedCourseWithIndexPath:indexPath andUserCourseListViewShowType:self.listViewShowType];
    }
}
@end
