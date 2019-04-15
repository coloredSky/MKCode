//
//  AppointmentChildViewController.h
//  MK
//
//  Created by 周洋 on 2019/3/20.
//  Copyright © 2019年 周洋. All rights reserved.
//



#import "MKBaseViewController.h"
//管理类
#import "AppointmentManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppointmentChildViewController : MKBaseViewController
@property (nonatomic, assign) AppointmentDisplayType dispayType;
@end

NS_ASSUME_NONNULL_END
