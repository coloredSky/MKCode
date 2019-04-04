//
//  MKMeetingViewController.h
//  MK
//
//  Created by 周洋 on 2019/3/31.
//  Copyright © 2019年 周洋. All rights reserved.
//

typedef NS_ENUM(NSUInteger, MeetingOperationType) {
    MeetingOperationTypeNew,
    MeetingOperationTypeEdit,
};

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 新建预约
 */
@interface MKMeetingViewController : MKNavViewController
@property (nonatomic, assign) MeetingOperationType operationType;
@end

NS_ASSUME_NONNULL_END
