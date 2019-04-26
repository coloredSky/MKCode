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
#import "HomePublicCourseModel.h"
#import "MKBannerModel.h"

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

+(void)callBackHomePageCouurseListDataWithHUDShow:(BOOL)hudShow categoryID:(NSString *)categoryID pageOffset:(NSInteger )pageOffset pageLimit:(NSInteger )pageLimit andCompletionBlock:(void(^)(BOOL isSuccess,NSString *message,NSArray <MKBannerModel *>*bannerList,NSArray <HomePublicCourseModel *>*publicCourseList,NSArray <MKCourseListModel *>*recommentCourseList))completionBlock;
{
    if ([NSString isEmptyWithStr:categoryID]) {
        return;
    }
    if (pageOffset != 1) {
        hudShow = NO;
    }
    NSDictionary *parameters = @{@"language" : @"zh-cn",
                                                @"category_id" : categoryID,
                                                @"offset" : [NSString stringWithFormat:@"%ld",pageOffset],
                                                @"limit" : [NSString stringWithFormat:@"%ld",pageLimit]
                                 };
    [MKNetworkManager sendGetRequestWithUrl:K_MK_Home_CourseList_Url parameters:parameters hudIsShow:YES success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                NSArray *bannerArr = [NSArray yy_modelArrayWithClass:[MKBannerModel class] json:MKResult.dataResponseObject[@"bannerList"]];
                NSArray *publicCourseArr =  [NSArray yy_modelArrayWithClass:[HomePublicCourseModel class] json:MKResult.dataResponseObject[@"liveList"]];
                NSArray *courseArr = [NSArray yy_modelArrayWithClass:[MKCourseListModel class] json:MKResult.dataResponseObject[@"courseList"]];
                completionBlock(YES, MKResult.message,bannerArr,publicCourseArr,courseArr);
            }
        }else{
            if (completionBlock) {
                completionBlock(NO, MKResult.message,nil,nil,nil);
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
            completionBlock(NO, [NSString stringWithFormat:@"error code is %ld",statusCode],nil,nil,nil);
        }
    }];
}
@end
