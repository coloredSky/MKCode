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
@class AppointmentDetailModel;
@class AppoinementReplyModel;
@class AppointmentShowModel;

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppointmentManager : NSObject

/**
 得到列表--请假-换班-相谈
 
 @param applyType 1预约 ，2请假 ，3换班
 @param completionBlock 回调
 */
+(void)callBackAllApplyListWithParameteApply_type:(NSInteger )applyType completionBlock:(void(^)(BOOL isSuccess, NSArray <AppointmentShowModel *>*apponitmentList , NSString *message))completionBlock;


/**
 得到各类的申请的回复列表

 @param applyType 申请类型
 @param apply_id 申请ID
 @param completionBlock 回调
 */
+(void)callBackAllApplyAppointmentReplyListWithParameteApply_type:(NSInteger )applyType apply_id:(NSString *)apply_id completionBlock:(void(^)(BOOL isSuccess,NSArray <AppoinementReplyModel *> *applyList, NSString *message))completionBlock;


/**
 得到各类申请的详情

 @param applyType 申请类型
 @param apply_id 申请ID
 @param completionBlock 回调
 */
+(void)callBackAllApplyDetailWithParameteApply_type:(NSInteger )applyType apply_id:(NSString *)apply_id completionBlock:(void(^)(BOOL isSuccess,AppointmentDetailModel *detailmodel, NSString *message))completionBlock;

@end

NS_ASSUME_NONNULL_END
