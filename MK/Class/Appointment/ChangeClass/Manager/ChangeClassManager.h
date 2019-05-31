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


+(void)callBackChangeClassRequestWithParameterClass_id:(NSString *)class_id new_class_id:(NSString *)new_class_id reason:(NSString *)reason  CompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;

@end

NS_ASSUME_NONNULL_END
