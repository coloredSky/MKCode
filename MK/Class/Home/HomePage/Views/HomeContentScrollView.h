//
//  HomeContentScrollView.h
//  MK
//
//  Created by 周洋 on 2019/3/19.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 首页加载内容视图
 */
@protocol HomeContentScrollViewDelegate <NSObject>

@optional
-(void)homeContentScrollViewScrollToIndex:(NSInteger )index;
@end

@interface HomeContentScrollView : UIView
@property (nonatomic, assign) id<HomeContentScrollViewDelegate> delegate;
/**
 子视图加载
 @param childViewControllers 子视图数组
 @param rootVC 父视图
 */
-(void)AddChildViewWithTitleArr:(NSMutableArray *)childViewControllers andRootViewController:(UIViewController *)rootVC;
/**
 scrollView滚动
 @param index 滚动进度
 */
-(void)scrollToIndex:(NSInteger )index;

@end

NS_ASSUME_NONNULL_END
