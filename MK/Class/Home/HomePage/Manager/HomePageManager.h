//
//  HomePageManager.h
//  MK
//
//  Created by 周洋 on 2019/4/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

@class HomeCourseCategoryModel;
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageManager : NSObject

+(void)callBackHomePageCouurseCategoryDataWithCompletionBlock:(void(^)(BOOL isSuccess,NSString *message,NSArray <HomeCourseCategoryModel *>*resultList))completionBlock;
@end

NS_ASSUME_NONNULL_END
