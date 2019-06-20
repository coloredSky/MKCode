//
//  MessageManager.h
//  MK
//
//  Created by 周洋 on 2019/6/19.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MKMessageModel;

NS_ASSUME_NONNULL_BEGIN

@interface MessageManager : NSObject


/**
 消息列表
 
 @param completionBlock 回调
 */
+(void)callBackMessageListDataWithLimit:(NSInteger )limit offset:(NSInteger )offset completionBlock:(void(^)(BOOL isSuccess,NSArray <MKMessageModel *>*messageList,NSString *message))completionBlock;

@end

NS_ASSUME_NONNULL_END
