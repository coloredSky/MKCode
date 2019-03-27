//
//  CourseDetailScrollView.h
//  MK
//
//  Created by 周洋 on 2019/3/22.
//  Copyright © 2019年 周洋. All rights reserved.
//

/**
 课程状态

 - CourseSituationTypeUnkown: 未知
 - CourseSituationTypeOnline: 线上
 - CourseSituationTypeOffline: 线下
 */
typedef NS_ENUM(NSUInteger, CourseSituationType) {
    CourseSituationTypeUnkown,
    CourseSituationTypeOnline,
    CourseSituationTypeOffline,
};

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CourseDetailScrollViewDelegate;

@interface CourseDetailScrollView : UIView
@property (nonatomic, strong) id<CourseDetailScrollViewDelegate>delegate;
@property (nonatomic, assign) CourseSituationType courseType;
//数据刷新
-(void)CourseDetailScrollViewReloadData;
//使scrollView翻页
-(void)scrollToIndex:(NSInteger )index;
@end

@protocol CourseDetailScrollViewDelegate <NSObject>
@optional
//监测滑动位置
-(void)CourseDetailScrollViewScrollOffsetY:(float )offsetY;
//监测滑动e页数
-(void)CourseDetailScrollViewScrollToIndex:(NSInteger )index;
@end

NS_ASSUME_NONNULL_END
