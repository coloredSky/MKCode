//
//  FeedBackManager.h
//  MK
//
//  Created by ginluck on 2019/6/13.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeedBackManager : NSObject
+(void)callBackFeedBackWithHudShow:(BOOL)hudShow feedType:(NSString *)type feedDetail:(NSString *)detail CompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;
@end

NS_ASSUME_NONNULL_END
