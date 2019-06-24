//
//  UserCourseModel.h
//  MK
//
//  Created by 周洋 on 2019/6/24.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MKCourseListModel;


NS_ASSUME_NONNULL_BEGIN

@interface UserCourseModel : NSObject

@property (nonatomic, copy) NSString *title;//biaoti
@property (nonatomic, copy) NSString *message;//副标题
@property (nonatomic, assign) BOOL isOnline;//是否线上
@property (nonatomic, assign) BOOL isOfflineFirst;//是否线下课程显示的第一区
@property (nonatomic, strong) NSArray<MKCourseListModel *> *courseList;

@end

NS_ASSUME_NONNULL_END
