//
//  DiscoverManager.h
//  MK
//
//  Created by 周洋 on 2019/5/24.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DiscoverNewsModel;

NS_ASSUME_NONNULL_BEGIN

@interface DiscoverManager : NSObject

+(void)callBackDiscoverNewsListDataWithHUDShow:(BOOL)hudShow type:(NSString *)type pageOffset:(NSInteger )pageOffset pageLimit:(NSInteger )pageLimit andCompletionBlock:(void(^)(BOOL isSuccess,NSString *message,NSArray <DiscoverNewsModel *>*newsList))completionBlock;

@end

NS_ASSUME_NONNULL_END
