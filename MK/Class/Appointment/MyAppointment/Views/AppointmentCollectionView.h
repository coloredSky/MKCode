//
//  AppointmentCollectionView.h
//  MK
//
//  Created by 周洋 on 2019/3/20.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppointmentManager.h"
@class AppointmentListModel;

NS_ASSUME_NONNULL_BEGIN

@protocol AppointmentCollectionViewDelegate <NSObject>
@optional
-(void)appointmentCollectionViewItemDidSelectedWithIndexPath:(NSIndexPath *)indexPath;
@end
/**
 已完成的预约cell
 */
@interface AppointmentCollectionView : UIView
@property (nonatomic, assign) AppointmentDisplayType dispayType;
@property (nonatomic, assign) id<AppointmentCollectionViewDelegate>delegate;
-(void)appointmentCollectionViewReloadDataWithAppointmentList:(NSArray *)appointmentList;
@end

NS_ASSUME_NONNULL_END
