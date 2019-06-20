//
//  MyBillManager.h
//  MK
//
//  Created by ginluck on 2019/4/26.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserBillListModel;

NS_ASSUME_NONNULL_BEGIN

@interface MyBillManager : NSObject


/**
 获取订单列表
 @param completionBlock 回调
 */
+(void)callBackMyBillDataWithCompletionBlock:(void(^)(BOOL isSuccess,NSArray <UserBillListModel *> *billList,NSString *message))completionBlock;

@end

NS_ASSUME_NONNULL_END
