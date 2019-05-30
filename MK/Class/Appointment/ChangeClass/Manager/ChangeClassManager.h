//
//  ChangeClassManager.h
//  MK
//
//  Created by 周洋 on 2019/5/30.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ChangeClassCouseModel;

NS_ASSUME_NONNULL_BEGIN

@interface ChangeClassManager : NSObject

+(void)callBackChangeClassCourseListRequestWithCompletionBlock:(void(^)(BOOL isSuccess,NSArray <ChangeClassCouseModel *>*courseList,NSString *message))completionBlock;

@end

NS_ASSUME_NONNULL_END
