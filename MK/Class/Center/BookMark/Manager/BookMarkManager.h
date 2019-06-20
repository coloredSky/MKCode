//
//  BookMarkManager.h
//  MK
//
//  Created by 周洋 on 2019/6/17.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BookMarkModel;

NS_ASSUME_NONNULL_BEGIN

@interface BookMarkManager : NSObject

+(void)callBackUserBookMarkListRequesWithCompletionBlock:(void(^)(BOOL isSuccess, NSArray <BookMarkModel *>*bookMarkList,NSString *message))completionBlock;

@end

NS_ASSUME_NONNULL_END
