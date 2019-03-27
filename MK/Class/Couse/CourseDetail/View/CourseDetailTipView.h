//
//  CourseDetailTipView.h
//  MK
//
//  Created by 周洋 on 2019/3/22.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CourseDetailTipViewDelegate <NSObject>
@optional
-(void)CourseDetailTipViewClickBtnWithSelectedIndex:(NSInteger )index;
@end
/**
 课程详情中的左右滑标识View
 */
@interface CourseDetailTipView : UIView
@property (nonatomic, assign) id<CourseDetailTipViewDelegate> delegate;
//button选中
-(void)courseButtonSeletedWithIndex:(NSInteger )index;
@end

NS_ASSUME_NONNULL_END
