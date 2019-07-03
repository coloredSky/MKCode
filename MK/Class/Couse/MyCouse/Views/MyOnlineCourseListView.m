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
@property (nonatomic, strong) NSArray *courseListArr;
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
    [cell cellRefreshDataWithIndexPath:indexPath withShowType:self.listViewShowType courseList:self.courseListArr];
    return cell;
}

-(void)onlineCourseListViewRefreshDataWithContentArr:(NSMutableArray *)courseList
{
    self.courseListArr = courseList;
    [self.courseListCollection reloadData];
}

#pragma mark --  EVENT
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([delegate respondsToSelector:@selector(myOnlineCourseListViewDidSelectedCourseWithIndexPath: andUserCourseListViewShowType: withCourseModel:)]) {
        MKCourseListModel *courseModel =  self.courseListArr[indexPath.row];
        [delegate myOnlineCourseListViewDidSelectedCourseWithIndexPath:indexPath andUserCourseListViewShowType:self.listViewShowType withCourseModel:courseModel];
    }
}
@end
