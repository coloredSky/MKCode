//
//  MyBillManager.h
//  MK
//
//  Created by ginluck on 2019/4/26.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyBillManager : NSObject
+(void)callBackMyBillDataWithHudShow:(BOOL)hudShow  CompletionBlock:(void(^)(BOOL isSuccess,NSString *message, LoginModel *model))completionBlock;
@end

NS_ASSUME_NONNULL_END
