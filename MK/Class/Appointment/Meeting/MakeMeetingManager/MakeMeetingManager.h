//
//  MakeMeetingManager.h
//  MK
//
//  Created by 周洋 on 2019/5/30.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MakeMeetingManager : NSObject


/**
 得到预约时间

 @param completionBlock 回调
 */
+(void)callBackMeetingTimeListWithCompletionBlock:(void(^)(BOOL isSuccess,NSArray <NSString *>*time1List,NSArray <NSString *>*time2List,NSArray <NSString *>*time3List,NSString *message))completionBlock;


/**
 得到预约相谈目的

 @param completionBlock 回调
 */
+(void)callBackMeetingPurposeListWithCompletionBlock:(void(^)(BOOL isSuccess,NSArray <NSDictionary *>*purposeList,NSArray <NSString *>*purposeStringList,NSString *message))completionBlock;


/**
 预约相谈配置--目的、时间

 @param completionBlock 回调
 */
+(void)callBackMeetingSettingWithCompletionBlock:(void(^)(BOOL isSuccess,NSArray <NSDictionary *>*purposeList,NSArray <NSString *>*purposeStringList, NSArray <NSString *>*timeList,NSString *message))completionBlock;


/**
 新增预约相谈

 @param type 目的类型
 @param staff_name 老师名字
 @param select_time_one 时间1
 @param select_time_two 时间2
 @param select_time_three 时间3
 @param completionBlock 回调
 */
+(void)callBackAddMeetingRequestWithParameterType:(NSInteger )type teacherName:(NSString *)staff_name select_time_one:(NSString *)select_time_one select_time_two:(NSString *)select_time_two select_time_three:(NSString *)select_time_three withCompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;

+(void)callBackUpdateMeetingRequestWithParameterType:(NSInteger )type teacherName:(NSString *)staff_name select_time_one:(NSString *)select_time_one select_time_two:(NSString *)select_time_two select_time_three:(NSString *)select_time_three apply_id:(NSString *)apply_id withCompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;


/**
 删除预约相谈

 @param apply_id 申请ID
 @param completionBlock 回调
 */
+(void)callBackDeleteMeetingRequestWithParameteApply_id:(NSString *)apply_id withCompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;

@end

NS_ASSUME_NONNULL_END
