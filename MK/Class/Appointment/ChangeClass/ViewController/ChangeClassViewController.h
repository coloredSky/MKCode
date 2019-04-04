//
//  ChangeClassViewController.h
//  MK
//
//  Created by 周洋 on 2019/3/29.
//  Copyright © 2019年 周洋. All rights reserved.
//

typedef NS_ENUM(NSUInteger, ChangeClassOperationType) {
    ChangeClassOperationTypeTypeNew,
    ChangeClassOperationTypeEdit,
};

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 调换班级--申请、编辑
 */
@interface ChangeClassViewController : MKNavViewController
@property (nonatomic, assign) ChangeClassOperationType operationType;
@end

NS_ASSUME_NONNULL_END
