//
//  HomePageManager.m
//  MK
//
//  Created by 周洋 on 2019/4/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "HomePageManager.h"
#import "HomeCourseCategoryModel.h"

@implementation HomePageManager

+(void)callBackHomePageCouurseCategoryDataWithHUDShow:(BOOL)hudShow andCompletionBlock:(void(^)(BOOL isSuccess,NSString *message,NSArray <HomeCourseCategoryModel *>*resultList))completionBlock
{
    [MKNetworkManager sendGetRequestWithUrl:K_MK_Home_AllCategoryList_Url hudIsShow:hudShow success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 1) {
            if (completionBlock) {
                NSArray *courseCayegoryList = [NSArray yy_modelArrayWithClass:[HomeCourseCategoryModel class] json:MKResult.dataResponseObject];
                completionBlock(YES, MKResult.message,courseCayegoryList);
            }
        }else{
            if (completionBlock) {
                completionBlock(NO, MKResult.message,[NSArray array]);
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
            completionBlock(NO, [NSString stringWithFormat:@"error code is %ld",statusCode],[NSArray array]);
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
    [MKNetworkManager sendPostRequestWithUrl:K_MK_Home_CourseList_Url parameters:parameters hudIsShow:hudShow success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        
    }];
}
@end
