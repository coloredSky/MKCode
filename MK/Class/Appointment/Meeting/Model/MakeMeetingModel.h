//
//  MakeMeetingModel.h
//  MK
//
//  Created by 周洋 on 2019/5/30.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MakeMeetingModel : NSObject

@property (nonatomic, assign) NSInteger purposeType;
@property (nonatomic, copy) NSString *purposeString;
@property (nonatomic, copy) NSString *teacherName;
@property (nonatomic, copy) NSString *meetingTime1;
@property (nonatomic, copy) NSString *meetingTime2;
@property (nonatomic, copy) NSString *meetingTime3;

@property (nonatomic, strong) NSArray *time1List;
@property (nonatomic, strong) NSArray *time2List;
@property (nonatomic, strong) NSArray *time3List;
@property (nonatomic, strong) NSArray <NSString *>*purposeStringList;
@property (nonatomic, strong) NSArray <NSDictionary *>*purposeList;

@end

NS_ASSUME_NONNULL_END
