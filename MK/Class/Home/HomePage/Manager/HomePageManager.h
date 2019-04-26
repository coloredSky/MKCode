//
//  HomePageManager.h
//  MK
//
//  Created by 周洋 on 2019/4/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

@class HomeCourseCategoryModel;
@class MKCourseListModel;
@class MKBannerModel;
@class HomePublicCourseModel;

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageManager : NSObject


/**
 首页所有课程分类

 @param completionBlock 回调
 */
+(void)callBackHomePageCouurseCategoryDataWithHUDShow:(BOOL)hudShow andCompletionBlock:(void(^)(BOOL isSuccess,NSString *message,NSArray <HomeCourseCategoryModel *>*resultList, NSMutableArray <NSString *>*titleArr))completionBlock;

+(void)callBackHomePageCouurseListDataWithHUDShow:(BOOL)hudShow categoryID:(NSString *)categoryID pageOffset:(NSInteger )pageOffset pageLimit:(NSInteger )pageLimit andCompletionBlock:(void(^)(BOOL isSuccess,NSString *message,NSArray <MKBannerModel *>*bannerList,NSArray <HomePublicCourseModel *>*publicCourseList,NSArray <MKCourseListModel *>*recommentCourseList))completionBlock;

@end

NS_ASSUME_NONNULL_END
