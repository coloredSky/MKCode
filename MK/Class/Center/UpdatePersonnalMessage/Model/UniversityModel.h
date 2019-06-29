//
//  UniversityModel.h
//  MK
//
//  Created by 周洋 on 2019/6/27.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UniversityModel : NSObject


@property(nonatomic,strong)NSString * university_name;
@property(nonatomic,strong)NSString * university_id;
@property(nonatomic,strong)NSString * faculty_name;
@property(nonatomic,strong)NSString * faculty_id;
@property(nonatomic,strong)NSString * discipline_name;
@property(nonatomic,strong)NSString * discipline_id;

@end

NS_ASSUME_NONNULL_END
