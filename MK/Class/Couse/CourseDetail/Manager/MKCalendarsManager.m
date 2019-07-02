//
//  MKCalendarsManager.m
//  MK
//
//  Created by 周洋 on 2019/7/1.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "MKCalendarsManager.h"
#import <EventKit/EventKit.h>
#import "MKOfflineCourseDetail.h"

@implementation MKCalendarsModel

@end

@interface MKCalendarsManager()

@property (nonatomic, strong) EKEventStore *eventStore;
@property (nonatomic, strong) MKOfflineCourseDetail *offlineCourseModel;
@end

@implementation MKCalendarsManager
MKBorrowShareSingleton_M(instance);

-(EKEventStore *)eventStore
{
    if (!_eventStore) {
        _eventStore = [[EKEventStore alloc]init];
    }
    return _eventStore;
}

-(void)createRemindCalendarsWithMKOfflineCourseDetailModel:(MKOfflineCourseDetail *)offlineCourseModel
{
    if (!offlineCourseModel || !offlineCourseModel.lessons || offlineCourseModel.lessons.count == 0) {
        [MBHUDManager showBriefAlert:@"暂没有需要提醒的课程！"];
        return;
    }
    self.offlineCourseModel = offlineCourseModel;
    [self checkCalendarsAuthorizationType];
}

-(NSArray <MKCalendarsModel *>*)filterReminderModel
{
    NSMutableArray *remindModelArr = [NSMutableArray array];
    for (MKOfflineLesson *lessonModel in self.offlineCourseModel.lessons) {
        if ([lessonModel.is_over integerValue] == 0 && ![NSString isEmptyWithStr:lessonModel.start_time] && [NSDate compareDatefromCurrentDateWithDate:lessonModel.start_time dateFormatter:@"YYYY-MM-dd HH:mm:ss"] == 1) {
            MKCalendarsModel *model = [MKCalendarsModel new];
            [NSString getAppVersion];
            model.title = [NSString stringWithFormat:@"%@上课提醒",[NSString getAppName]];
            model.location = [NSString stringWithFormat:@"%@-%@",self.offlineCourseModel.course_name,lessonModel.name];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *lessonStartDate = [dateFormatter dateFromString:lessonModel.start_time];
            NSDate *lessonEndtDate = [dateFormatter dateFromString:lessonModel.end_time];
            // 提前一个小时开始
            NSDate *startDate = lessonStartDate;
            // 提前一分钟结束
            NSDate *endDate = lessonEndtDate;
            model.startDate = startDate;
            model.endDate = endDate;
            model.allDay = NO;
            [remindModelArr addObject:model];
        }
    }
    return remindModelArr.copy;
}

-(void)checkCalendarsAuthorizationType
{
    EKAuthorizationStatus  eventStatus = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
    if (eventStatus == EKAuthorizationStatusAuthorized) {
        //用户已经授权
        NSArray <MKCalendarsModel *>*calerdarList = [self filterReminderModel];
        if (calerdarList.count == 0) {
            [MBHUDManager showBriefAlert:@"暂没有需要提醒的课程！"];
            return;
        }
        for (MKCalendarsModel *model in calerdarList) {
            [self addCalendarsRemindWithMKCalenderModel:model];
        }
    }else if (eventStatus == EKAuthorizationStatusNotDetermined){
        //用户没有选择是否授权前
        [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                //用户点击了授权
                NSArray <MKCalendarsModel *>*calerdarList = [self filterReminderModel];
                if (calerdarList.count == 0) {
                    [MBHUDManager showBriefAlert:@"暂没有需要提醒的课程！"];
                    return;
                }
                for (MKCalendarsModel *model in calerdarList) {
                    [self addCalendarsRemindWithMKCalenderModel:model];
                }
            }else{
                //用户拒绝授权
                [MBHUDManager showBriefAlert:@"请先在设置中允许APP使用日历！"];
            }
        }];
    }else{
        //用户否认授权
        [MBHUDManager showBriefAlert:@"请先在设置中允许APP使用日历！"];
    }
}

-(void)addCalendarsRemindWithMKCalenderModel:(MKCalendarsModel *)calenderModel
{
    EKEvent *event  = [EKEvent eventWithEventStore:self.eventStore];
    event.title  = calenderModel.title;
    event.location = calenderModel.location;
    event.startDate = calenderModel.startDate;
    event.endDate   = calenderModel.endDate;
    event.allDay = calenderModel.allDay;
    //添加提醒
    EKAlarm *elarm = [EKAlarm alarmWithRelativeOffset:-3600];
    [event addAlarm:elarm];
    
    [event setCalendar:[self.eventStore defaultCalendarForNewEvents]];
    NSError *error;
    [self.eventStore saveEvent:event span:EKSpanThisEvent error:&error];
    if (!error) {
        MKLog(@"添加成功");
        [MBHUDManager showBriefAlert:@"添加提醒成功"];
//        //添加成功后需要保存日历关键字
//        NSString *Identifier = event.eventIdentifier;
//        // 保存在沙盒，避免重复添加等其他判断
//        [[NSUserDefaults standardUserDefaults] setObject:Identifier forKey:@"my_eventIdentifier"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        [MBHUDManager showBriefAlert:@"添加提醒失败"];
     MKLog(@"添加失败");
    }
}

-(void)findTheCalendarsRemindEvent
{
    // 获取上面的这个ID呀。
//    NSString *identifier = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"my_eventIdentifier"]];
//    EKEvent *event = [self.eventStore eventWithIdentifier:identifier];
}
@end
