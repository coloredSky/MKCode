//
//  HomePageManager.m
//  MK
//
//  Created by 周洋 on 2019/4/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "HomePageManager.h"
#import "HomeCourseCategoryModel.h"
#import "MKCourseListModel.h"

@implementation HomePageManager

+(void)callBackHomePageCouurseCategoryDataWithHUDShow:(BOOL)hudShow andCompletionBlock:(void(^)(BOOL isSuccess,NSString *message,NSArray <HomeCourseCategoryModel *>*resultList, NSMutableArray <NSString *>*titleArr))completionBlock
{
    [MKNetworkManager sendGetRequestWithUrl:K_MK_Home_AllCategoryList_Url parameters:nil hudIsShow:hudShow success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 1) {
            if (completionBlock) {
                NSArray *courseCayegoryList = [NSArray yy_modelArrayWithClass:[HomeCourseCategoryModel class] json:MKResult.dataResponseObject];
                NSMutableArray *titleResultArr = [NSMutableArray arrayWithCapacity:courseCayegoryList.count];
                for (HomeCourseCategoryModel *model in courseCayegoryList) {
                    [titleResultArr addObject:model.categoryName];
                }
                completionBlock(YES, MKResult.message,courseCayegoryList,titleResultArr);
            }
        }else{
            if (completionBlock) {
                completionBlock(NO, MKResult.message,nil,nil);
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
            completionBlock(NO, [NSString stringWithFormat:@"error code is %ld",statusCode],nil,nil);
        }
    }];
}

+(void)callBackHomePageCouurseListDataWithHUDShow:(BOOL)hudShow categoryID:(NSString *)categoryID andCompletionBlock:(void(^)(BOOL isSuccess,NSString *message,NSMutableArray <MKCourseListModel *>*resultList))completionBlock
{
    if ([NSString isEmptyWithStr:categoryID]) {
        return;
    }
    NSDictionary *parameters = @{@"language" : @"zh-cn",
                                               @"category_id" : categoryID
                                 };
    [MKNetworkManager sendGetRequestWithUrl:K_MK_Home_CourseList_Url parameters:parameters hudIsShow:YES success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 1) {
            if (completionBlock) {
                NSMutableArray *courseList = [NSArray yy_modelArrayWithClass:[MKCourseListModel class] json:MKResult.dataResponseObject].mutableCopy;
                completionBlock(YES, MKResult.message,courseList);
            }
        }else{
            if (completionBlock) {
                completionBlock(NO, MKResult.message,nil);
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
            completionBlock(NO, [NSString stringWithFormat:@"error code is %ld",statusCode],nil);
        }
    }];
}
@end
