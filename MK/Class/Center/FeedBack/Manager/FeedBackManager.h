//
//  FeedBackManager.h
//  MK
//
//  Created by ginluck on 2019/6/13.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FeedBackTypeModel;

NS_ASSUME_NONNULL_BEGIN

@interface FeedBackManager : NSObject


+(void)callBackGetFeedBackTypeWithCompletionBlock:(void(^)(BOOL isSuccess, NSArray <FeedBackTypeModel *> *typeList,NSString *message))completionBlock;

/**
用户反馈


 @param type 反馈类型
 @param detail 内容
 @param completionBlock 回调
 */
+(void)callBackFeedBackWithHudShow:(BOOL)hudShow feedType:(NSInteger )type feedDetail:(NSString *)detail CompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;

@end

NS_ASSUME_NONNULL_END
