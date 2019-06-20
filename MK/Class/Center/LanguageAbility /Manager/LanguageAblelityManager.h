//
//  LanguageAblelityManager.h
//  MK
//
//  Created by ginluck on 2019/6/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LanguageAblelityManager : NSObject
+(void)callBackUpdateLanguageAblelityWithHudShow:(BOOL)hudShow toeic:(NSString *)toeic toefl:(NSString *)toefl jlpt:(NSString *)jlpt  CompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;  
@end

NS_ASSUME_NONNULL_END
