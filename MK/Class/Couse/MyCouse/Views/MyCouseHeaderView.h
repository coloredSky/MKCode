//
//  MyCouseHeaderView.h
//  MK
//
//  Created by ginluck on 2019/3/18.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKCourseListModel;

NS_ASSUME_NONNULL_BEGIN

@protocol MyCouseHeaderViewDelegate <NSObject>

@required
-(void)userCouseHeaderViewVideoPlay;
@end

/**
 正在观看的视频--headerView
 */
@interface MyCouseHeaderView : UIView

@property (nonatomic, assign) id<MyCouseHeaderViewDelegate> delegate;

-(void)userCourseHeaderViewRefreshDataWithMKCourseListModel:(nullable MKCourseListModel *)courseListModel;

@end

NS_ASSUME_NONNULL_END
