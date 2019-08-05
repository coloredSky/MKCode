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
@class MKSchoolListSelectedModel;

NS_ASSUME_NONNULL_BEGIN

@protocol SchoolListViewControllerDelegate <NSObject>
@optional
-(void)schoolListViewClickWithMKSchoolListSelectedModel:(MKSchoolListSelectedModel * )schoolModel schoolListViewShowType:(SchoolListViewShowType )showType;

@end

@interface SchoolListViewController : MKNavViewController
@property (nonatomic, copy)void(^schoolValueSelectedBlock)(MKSchoolListSelectedModel *schoolModel,SchoolListViewShowType showType);

@property (nonatomic, assign) id<SchoolListViewControllerDelegate> delegate;

@property(nonatomic,copy)NSString *study_category;
@property(nonatomic,copy)NSString *university_id;
@property(nonatomic,copy)NSString *faculty_id;

//@property(nonatomic,strong)PersonModel * originalModel;
@property (nonatomic, assign) SchoolListViewShowType showType;


@end

@interface MKSchoolListSelectedModel : NSObject
@property(nonatomic,copy)NSString *selectedname;
@property(nonatomic,copy)NSString *selectedID;
@end

NS_ASSUME_NONNULL_END
