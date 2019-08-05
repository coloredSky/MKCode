//
//  ValSchoolHeaderView.h
//  MK
//
//  Created by zhouyang on 2019/8/3.
//  Copyright © 2019年 周洋. All rights reserved.
//


/**
 选中的type

 - ValSchoolHeaderViewShowTypeDivision: 学部
 - ValSchoolHeaderViewShowTypeCollege: 大学院
 */
typedef NS_ENUM(NSUInteger, ValSchoolHeaderViewShowType) {
    ValSchoolHeaderViewShowTypeDivision,
    ValSchoolHeaderViewShowTypeCollege,
};

/**
 操作的type

 - ValSchoolHeaderViewOperationTypeDivision: 学部被选中
 - ValSchoolHeaderViewOperationTypeCollege: 大学院被选中
 */
typedef NS_ENUM(NSUInteger, ValSchoolHeaderViewOperationType) {
    ValSchoolHeaderViewOperationTypeDivision,
    ValSchoolHeaderViewOperationTypeCollege,
};

#import <UIKit/UIKit.h>

@interface ValSchoolHeaderView : UIView

@property(nonatomic,copy)void(^schoolHeaderViewBlock)(ValSchoolHeaderViewOperationType operationType);

-(void)valSchoolHeaderViewReloadDataWithTitle:(NSString *)title headerViewShowType:(ValSchoolHeaderViewShowType )type;

@end
