//
//  UserCourseListManager.h
//  MK
//
//  Created by 周洋 on 2019/4/10.
//  Copyright © 2019年 周洋. All rights reserved.
//

typedef NS_ENUM(NSUInteger, UserCourseListViewShowType) {
    UserCourseListViewShowTypeOnline,
    UserCourseListViewShowTypeOfflineUnderWay,
    UserCourseListViewShowTypeOfflineNotStart,
    UserCourseListViewShowTypeOfflineHaveEnd
};

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserCourseListManager : NSObject

@end

NS_ASSUME_NONNULL_END
