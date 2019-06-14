//
//  GetPersonnalInfoManager.h
//  MK
//
//  Created by ginluck on 2019/6/13.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GetPersonnalInfoManager : NSObject
+(void)callBackGetPerMessageWithHudShow:(BOOL)hudShow  CompletionBlock:(void(^)(BOOL isSuccess,NSString *message,PersonModel * model))completionBlock;
@end

NS_ASSUME_NONNULL_END
