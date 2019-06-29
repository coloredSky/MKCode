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

@protocol SchoolListViewControllerDelegate <NSObject>

-(void)schoolListViewClickWithIndex:(NSInteger )index schoolListViewShowType:(SchoolListViewShowType )showType;

@end

@interface SchoolListViewController : MKNavViewController
@property (nonatomic, copy)void(^schoolValueSelectedBlock)(NSInteger index,SchoolListViewShowType showType);

@property (nonatomic, assign) id<SchoolListViewControllerDelegate> delegate;

//@property(nonatomic,strong)PersonModel * originalModel;
@property (nonatomic, strong) NSArray *universityList;//学校
@property (nonatomic, strong) NSArray *facultyList;//学部
@property (nonatomic, strong) NSArray *disciplineList;//学科
@property (nonatomic, assign) SchoolListViewShowType showType;


@end

NS_ASSUME_NONNULL_END
