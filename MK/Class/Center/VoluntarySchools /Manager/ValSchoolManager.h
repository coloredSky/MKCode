//
//  ValSchoolManager.h
//  MK
//
//  Created by ginluck on 2019/6/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ValSchoolManager : NSObject
+(void)callBackUpdateValSchoolWithHudShow:(BOOL)hudShow discipline_id_1:(NSString *)discipline_id_1 discipline_id_2:(NSString *)discipline_id_2 discipline_id_3:(NSString *)discipline_id_3  CompletionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;
@end

NS_ASSUME_NONNULL_END
