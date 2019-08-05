//
//  ChangeClassQueryViewController.h
//  MK
//
//  Created by 周洋 on 2019/4/3.
//  Copyright © 2019年 周洋. All rights reserved.
//

typedef NS_ENUM(NSUInteger, ChangeClassQueryCheckType) {
    ChangeClassQueryCheckTypeCanEdit,
    ChangeClassQueryCheckTypeNotEdit,
};

#import <UIKit/UIKit.h>
#import "AppointmentManager.h"
@class AppointmentListModel;

NS_ASSUME_NONNULL_BEGIN

/**
 调换班级--查询--等待回复
 */
@interface ChangeClassQueryViewController : MKNavViewController
@property (nonatomic, strong) AppointmentListModel *appointmentModel;
@property (nonatomic, assign) AppointmentDisplayType showType;
@property (nonatomic, assign) ChangeClassQueryCheckType checkType;

@end

NS_ASSUME_NONNULL_END
