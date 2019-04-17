//
//  HomePageManager.h
//  MK
//
//  Created by 周洋 on 2019/4/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

@class HomeCourseCategoryModel;
@class MKCourseListModel;

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageManager : NSObject


/**
 首页所有课程分类

 @param completionBlock 回调
 */
+(void)callBackHomePageCouurseCategoryDataWithHUDShow:(BOOL)hudShow andCompletionBlock:(void(^)(BOOL isSuccess,NSString *message,NSArray <HomeCourseCategoryModel *>*resultList))completionBlock;

+(void)callBackHomePageCouurseListDataWithHUDShow:(BOOL)hudShow categoryID:(NSString *)categoryID andCompletionBlock:(void(^)(BOOL isSuccess,NSString *message,NSMutableArray <MKCourseListModel *>*resultList))completionBlock;

@end

NS_ASSUME_NONNULL_END
