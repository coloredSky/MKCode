//
//  DiscoverCourseCategoryView.h
//  MK
//
//  Created by 周洋 on 2019/3/18.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 发现模块中的课程分类 第一区区头
 */
@protocol DiscoverCourseCategoryViewDelegate;
@interface DiscoverCourseCategoryView : UIView
@property (nonatomic, assign) id<DiscoverCourseCategoryViewDelegate>delegate;
-(void)CourseCategoryViewReloadData;
@end

@protocol DiscoverCourseCategoryViewDelegate <NSObject>
@optional
-(void)itemDidSelectedWithIndex:(NSUInteger )index;
@end
NS_ASSUME_NONNULL_END
