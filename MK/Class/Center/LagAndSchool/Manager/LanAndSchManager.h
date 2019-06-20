//
//  LanAndSchManager.h
//  MK
//
//  Created by ginluck on 2019/6/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LanAndSchManager : NSObject
+(void)callBackUpdateLanguageAndSchoolWithHudShow:(BOOL)hudShow jp_school_id:(NSString *)jp_school_id jp_school_time:(NSString *)jp_school_time CompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;
@end

NS_ASSUME_NONNULL_END
