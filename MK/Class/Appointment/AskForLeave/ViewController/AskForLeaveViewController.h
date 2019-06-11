//
//  AskForLeaveViewController.h
//  MK
//
//  Created by 周洋 on 2019/3/31.
//  Copyright © 2019年 周洋. All rights reserved.
//

typedef NS_ENUM(NSUInteger, AskForLeaveOperationType) {
    AskForLeaveOperationTypeNew,
    AskForLeaveOperationTypeEdit,
};

@class AppointmentDetailModel;
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 请假申请
 */
@interface AskForLeaveViewController : MKNavViewController
@property (nonatomic, assign) AskForLeaveOperationType operationType;
@property (nonatomic, strong) AppointmentDetailModel *detailModel;
@end

NS_ASSUME_NONNULL_END
