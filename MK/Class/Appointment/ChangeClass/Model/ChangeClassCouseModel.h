//
//  ChangeClassCouseModel.h
//  MK
//
//  Created by 周洋 on 2019/5/30.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangeClassCouseModel : NSObject

@property (nonatomic, copy) NSString *class_name;
@property (nonatomic, copy) NSString *course_id;
@property (nonatomic, copy) NSString *period;
@property (nonatomic, copy) NSString *course_name;
@property (nonatomic, strong) NSArray *same_period_class;
@property (nonatomic, copy) NSString *changeID;
@property (nonatomic, strong) NSMutableArray *changeClassList;//可以更换的班级
@property (nonatomic, strong) NSMutableArray *changeClassStringList;//可以更换的班级名字

@end

NS_ASSUME_NONNULL_END
