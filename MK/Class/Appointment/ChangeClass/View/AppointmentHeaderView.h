//
//  AppointmentHeaderView.h
//  MK
//
//  Created by 周洋 on 2019/3/31.
//  Copyright © 2019年 周洋. All rights reserved.
//

typedef NS_ENUM(NSUInteger, AppointmentHeaderViewShowType) {
    AppointmentHeaderViewShowTypeNormal,
    AppointmentHeaderViewShowTypeEditting
};

typedef NS_ENUM(NSUInteger, AppointmentHeaderViewOperationType) {
    AppointmentHeaderViewOperationTypeEdit,
    AppointmentHeaderViewOperationTypeDelete
};

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface AppointmentHeaderView : UIView
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, assign) AppointmentHeaderViewShowType showType;
@property (nonatomic, copy) void(^operationBlock)(AppointmentHeaderViewOperationType operationType);
@end

NS_ASSUME_NONNULL_END
