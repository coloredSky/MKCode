//
//  ValSchoolManager.h
//  MK
//
//  Created by ginluck on 2019/6/17.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ValSchoolManager : NSObject

+(void)callBackUpdateValSchoolUniversity_id_1:(NSString *)university_id_1 faculty_id_1:(NSString *)faculty_id_1 discipline_id_1:(NSString *)discipline_id_1 university_id_2:(NSString *)university_id_2 faculty_id_2:(NSString *)faculty_id_2 discipline_id_2:(NSString *)discipline_id_2 university_id_3:(NSString *)university_id_3 faculty_id_3:(NSString *)faculty_id_3 discipline_id_3:(NSString *)discipline_id_3 mobile:(NSString *)mobile completionBlock:(void(^)(BOOL isSuccess,NSString *message))completionBlock;

@end

NS_ASSUME_NONNULL_END
