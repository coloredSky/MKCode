//
//  ChangeClassManager.h
//  MK
//
//  Created by 周洋 on 2019/5/30.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ChangeClassCouseModel;

NS_ASSUME_NONNULL_BEGIN

@interface ChangeClassManager : NSObject


/**
 得到更换班级列表

 @param completionBlock 回调
 */
+(void)callBackChangeClassCourseListRequestWithCompletionBlock:(void(^)(BOOL isSuccess,NSArray <ChangeClassCouseModel *>*courseList,NSArray <NSString *>*courseStringList,NSString *message))completionBlock;


/**
 新增、编辑换班申请

 @param class_id 原班级ID
 @param new_class_id 换班的班级ID
 @param reason 理由
 @param completionBlock 回调
 */
+(void)callBackChangeClassRequestWithParameterClass_id:(NSString *)class_id new_class_id:(NSString *)new_class_id reason:(NSString *)reason apply_id:(NSString *)apply_id  CompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;


/**
 删除换班申请

 @param apply_id a申请ID
 @param completionBlock 回调
 */
+(void)callBackDeleteChangeClassRequestWithParameteApply_id:(NSString *)apply_id  completionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;

@end

NS_ASSUME_NONNULL_END
