//
//  AppointmentCell.h
//  MK
//
//  Created by 周洋 on 2019/3/20.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKBaseTableViewCell.h"
#import "AppointmentManager.h"
@class AppointmentListModel;

NS_ASSUME_NONNULL_BEGIN

/**
 未完成的预约cell
 */
@interface AppointmentCell : MKBaseTableViewCell

-(void)cellRefreshDataWithDisplayType:(AppointmentDisplayType )displayType andAppointmentListModel:(AppointmentListModel *)appointmentModel;
@end

NS_ASSUME_NONNULL_END
