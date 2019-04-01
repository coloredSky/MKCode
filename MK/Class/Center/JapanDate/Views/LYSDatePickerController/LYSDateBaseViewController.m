//
//  LYSDateBaseViewController.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDateBaseViewController.h"

NSString *const LYSDatePickerWillAppearNotifition = @"LYSDatePickerWillAppearNotifition";
NSString *const LYSDatePickerDidAppearNotifition = @"LYSDatePickerDidAppearNotifition";
NSString *const LYSDatePickerWillDisAppearNotifition = @"LYSDatePickerWillDisAppearNotifition";
NSString *const LYSDatePickerDidDisAppearNotifition = @"LYSDatePickerDidDisAppearNotifition";

NSString *const LYSDatePickerDidCancelNotifition = @"LYSDatePickerDidCancelNotifition";
NSString *const LYSDatePickerDidSelectDateNotifition = @"LYSDatePickerDidSelectDateNotifition";

@interface LYSDateBaseViewController ()

@end

static id datePicker = nil;

@implementation LYSDateBaseViewController

+ (instancetype)shareInstance
{
    if (!datePicker) {
        datePicker = [[[self class] alloc] init];
    }
    return datePicker;
}

+ (void)shareRelease
{
    datePicker = nil;
}

- (void)commitDatePicker
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LYSDatePickerDidSelectDateNotifition
                                                        object:nil
                                                      userInfo:@{@"date":self.date}];
//    if (self.didSelectDatePicker)
//    {
//        if ([self dateTimeyearTime:[UIUtils dateFromString:[UIUtils stringFromDate:[NSDate date] formate:@"yyyy年MM月dd日HH:mm"] formate:@"yyyy年MM月dd日HH:mm"] endTime:self.date]==1) {
//            ShowMessage(@"超出服务时间范围，请重新选择！");
//        }else
//        {
//           self.didSelectDatePicker(self.date);
//        }
//        
//    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerViewController:didSelectDate:)])
    {
        [self.delegate pickerViewController:(LYSDatePickerController *)self didSelectDate:self.date];
    }
    
}
-(int)dateTimeyearTime:(NSDate *)startTime endTime:(NSDate *)endTime
{
    NSTimeInterval start = [startTime timeIntervalSince1970]*1;
    NSTimeInterval end = [endTime timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    int day = (int)value / (24 *3600);
    int isFiveYear;
    if (day >=365*5) {
        isFiveYear=1;
    }else
    {
        isFiveYear=0;
    }
    return isFiveYear;
}
- (void)cancelDatePicker {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerViewControllerDidCancel:)]) {
        [self.delegate pickerViewControllerDidCancel:(LYSDatePickerController *)self];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:LYSDatePickerDidCancelNotifition object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
