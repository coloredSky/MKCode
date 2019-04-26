//
//  HomeCourseCollectionViewCell.h
//  MK
//
//  Created by 周洋 on 2019/3/19.
//  Copyright © 2019年 周洋. All rights reserved.
//

@class HomePublicCourseModel;
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeCourseCollectionViewCell : UICollectionViewCell
-(void)cellRefreshDataWithModel:(HomePublicCourseModel *)model;
@end

NS_ASSUME_NONNULL_END
