//
//  MKCalendarsManager.h
//  MK
//
//  Created by 周洋 on 2019/7/1.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>
@class MKOfflineCourseDetail;
@class EKAlarm;

NS_ASSUME_NONNULL_BEGIN


@interface MKCalendarsModel : NSObject
@property (nonatomic, copy) NSString *title;//标题
@property (nonatomic, copy) NSString *location;//内容
@property (nonatomic, strong) NSDate *startDate;//开始时间
@property (nonatomic, strong) NSDate *endDate;//结束时间
@property (nonatomic, assign) BOOL allDay;//是否全天

@end

@interface MKCalendarsManager : NSObject
MKBorrowShareSingleton_H(instance);

-(void)createRemindCalendarsWithMKOfflineCourseDetailModel:(MKOfflineCourseDetail *)offlineCourseModel;

@end



NS_ASSUME_NONNULL_END
