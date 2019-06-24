//
//  SchoolListViewController.h
//  MK
//
//  Created by 周洋 on 2019/6/23.
//  Copyright © 2019 周洋. All rights reserved.
//

/**
 显示type
 - SchoolListViewShowTypeUniversity: 学校
 - SchoolListViewShowTypeFaculty: 学部
 - SchoolListViewShowTypeDiscipline: 学科
 */
typedef NS_ENUM(NSUInteger, SchoolListViewShowType) {
    SchoolListViewShowTypeUniversity,
    SchoolListViewShowTypeFaculty,
    SchoolListViewShowTypeDiscipline,
};

#import "PersonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SchoolListViewController : MKNavViewController
@property (nonatomic, copy)void(^schoolValueSelectedBlock)(NSInteger index,SchoolListViewShowType showType);

@property(nonatomic,strong)PersonModel * originalModel;
@property (nonatomic, assign) SchoolListViewShowType showType;


@end

NS_ASSUME_NONNULL_END
