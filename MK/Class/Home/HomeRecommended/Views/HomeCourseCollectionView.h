//
//  HomeCourseCollectionView.h
//  MK
//
//  Created by 周洋 on 2019/3/19.
//  Copyright © 2019年 周洋. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HomeCourseCollectionViewDelegate <NSObject>
@optional
-(void)homeCourseCollectionViewDidSelectedWithIndexPath:(NSIndexPath *)indexPath;
@end

@interface HomeCourseCollectionView : UIView
@property (nonatomic, assign) id<HomeCourseCollectionViewDelegate> delegate;
-(void)homeCourseCollectionViewReloadDataWithCourseList:(NSMutableArray *)couseList;
@end

NS_ASSUME_NONNULL_END
