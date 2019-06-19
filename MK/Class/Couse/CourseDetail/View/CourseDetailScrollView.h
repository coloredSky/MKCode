//
//  CourseDetailScrollView.h
//  MK
//
//  Created by 周洋 on 2019/3/22.
//  Copyright © 2019年 周洋. All rights reserved.
//


@class MKCourseDetailModel;
@class MKLessonModel;
@class MKOfflineCourseDetail;

#import <UIKit/UIKit.h>
#import "CourseDetailManager.h"


NS_ASSUME_NONNULL_BEGIN

/**
 装载课程详情的scroll
 */
@protocol CourseDetailScrollViewDelegate;

@interface CourseDetailScrollView : UIView
@property (nonatomic, assign) id<CourseDetailScrollViewDelegate>delegate;
@property (nonatomic, assign) CourseSituationType courseType;
//数据刷新
-(void)courseDetailScrollViewReloadDataWithMKCourseDetailModel:(MKCourseDetailModel *)courseDetailModel offlineCourseDetailModel:(MKOfflineCourseDetail *)offlineCourseDetailModel;
//使scrollView翻页
-(void)scrollToIndex:(NSInteger )index;
@end


@protocol CourseDetailScrollViewDelegate <NSObject>
@optional
//监测滑动位置
-(void)CourseDetailScrollViewScrollOffsetY:(float )offsetY;
//监测滑动e页数
-(void)CourseDetailScrollViewScrollToIndex:(NSInteger )index;
//cell 课程点击
-(void)courseDidSelectedWithIndexPath:(NSIndexPath *)indexPath andLessonModel:(MKLessonModel *)lessonModel;
@end

NS_ASSUME_NONNULL_END
