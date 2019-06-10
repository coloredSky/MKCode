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


/**
 获取文章列表

 @param hudShow 是否loading
 @param page 页码
 @param page_size 条数
 @param completionBlock 回调
 */
+(void)callBackDiscoverNewsListDataWithHUDShow:(BOOL)hudShow  page:(NSInteger )page page_size:(NSInteger )page_size andCompletionBlock:(void(^)(BOOL isSuccess,NSString *message,NSArray <DiscoverNewsModel *>*newsList, NSInteger totalpage))completionBlock;



/**
 得到文章详情

 @param hudShow 是否loading
 @param newsID 新闻ID
 @param completionBlock 回调
 */
+(void)callBackDiscoverNewsDetailDataWithHUDShow:(BOOL)hudShow  newsID:(NSString *)newsID andCompletionBlock:(void(^)(BOOL isSuccess,NSString *message,DiscoverNewsModel *newsDetailModel))completionBlock;

@end

NS_ASSUME_NONNULL_END
