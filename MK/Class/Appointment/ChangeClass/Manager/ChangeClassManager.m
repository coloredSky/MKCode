//
//  ChangeClassManager.m
//  MK
//
//  Created by 周洋 on 2019/5/30.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "ChangeClassManager.h"
#import "ChangeClassCouseModel.h"

@implementation ChangeClassManager

+(void)callBackChangeClassCourseListRequestWithCompletionBlock:(void(^)(BOOL isSuccess,NSArray <ChangeClassCouseModel *>*courseList,NSString *message))completionBlock
{
    [MKNetworkManager sendGetRequestWithUrl:K_MK_ChangeClass_CourseList_Url parameters:nil hudIsShow:NO success:^(MKResponseResult *MKResult, BOOL isCacheObject) {
        if (MKResult.responseCode == 0) {
            if (completionBlock) {
                NSArray *courseList = [NSArray yy_modelArrayWithClass:[ChangeClassCouseModel class] json:MKResult.dataResponseObject];
                completionBlock(YES,courseList, MKResult.message);
            }
        }else{
            if (completionBlock) {
                completionBlock(NO,nil,MKResult.message);
            }
        }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        if (completionBlock) {
            completionBlock(NO,nil,error.userInfo[NSLocalizedDescriptionKey]);
        }
    }];
}
@end
