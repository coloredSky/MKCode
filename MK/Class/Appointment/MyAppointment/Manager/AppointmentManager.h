//
//  AppointmentManager.h
//  MK
//
//  Created by 周洋 on 2019/4/15.
//  Copyright © 2019年 周洋. All rights reserved.
//

/**
 申请展示类型
 - AppointmentDisplayTypeChangeClass: 换班
 - AppointmentDisplayTypeAskForLeave: 请假
 - AppointmentDisplayTypeMeeting: 预约相谈
 */
typedef NS_ENUM(NSUInteger, AppointmentDisplayType) {
    AppointmentDisplayTypeChangeClass,
    AppointmentDisplayTypeAskForLeave,
    AppointmentDisplayTypeMeeting,
};

@class AppointmentListModel;
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppointmentManager : NSObject

/**
 得到列表--请假-换班-相谈
 
 @param applyType 1预约 ，2请假 ，3换班
 @param completionBlock 回调
 */
+(void)callBackAllApplyListWithParameteApply_type:(NSInteger )applyType completionBlock:(void(^)(BOOL isSuccess,NSArray <AppointmentListModel *>*ongoingApplyList, NSArray <AppointmentListModel *> *completeApplyList,NSString *message))completionBlock;

+(void)callBackAllApplyReplyInformationWithParameteApply_type:(NSInteger )applyType apply_id:(NSString *)apply_id completionBlock:(void(^)(BOOL isSuccess,NSArray <AppointmentListModel *>*ongoingApplyList, NSArray <AppointmentListModel *> *completeApplyList,NSString *message))completionBlock;

@end

NS_ASSUME_NONNULL_END
