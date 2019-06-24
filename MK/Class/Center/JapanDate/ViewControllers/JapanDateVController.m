//
//  JapanDateVController.m
//  MK
//
//  Created by ginluck on 2019/3/30.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "JapanDateVController.h"
#import "LYSDatePickerController.h"//时间控件
#import "JapanDateManager.h"

@interface JapanDateVController ()<LYSDatePickerSelectDelegate>
@property(nonatomic,weak)IBOutlet UIButton  * timeBtn;
@property(nonatomic,strong)userInfo * userInfoModel;//用户信息
@end

@implementation JapanDateVController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =K_BG_WhiteColor;
    [self.timeBtn  setTitle:self.originalModel.userInfo.arrive_jp forState:UIControlStateNormal];
}
-(IBAction)btnClick:(UIButton * )sender
{
    if (sender.tag ==0)
    {
        [LYSDatePickerController alertDatePickerInWindowRootVCWithType:(LYSDatePickerTypeDay) selectDate:[NSDate date]];
        [LYSDatePickerController customPickerDelegate:self];
    }else{
        //保存
        if ([NSString isEmptyWithStr:self.userInfoModel.arrive_jp]) {
            [MBHUDManager showBriefAlert:@"请选择赴日日期！"];
            return;
        }
        if (self.userInfoModel.arrive_jp == self.originalModel.userInfo.arrive_jp) {
            [MBHUDManager showBriefAlert:@"请修改赴日日期后保存！"];
            return;
        }
        [JapanDateManager callBackUpdateJapanDateWithArrive_jp:self.userInfoModel.arrive_jp mobile:self.originalModel.userInfo.mobile mobile_jp:self.originalModel.userInfo.mobile_jp completionBlock:^(BOOL isSuccess, NSString * _Nonnull message) {
            if (isSuccess) {
                [MBHUDManager showBriefAlert:@"修改成功！"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                if (![NSString isEmptyWithStr:message]) {
                    [MBHUDManager showBriefAlert:message];
                }
            }
        }];
    }
}

-(void)setOriginalModel:(PersonModel *)originalModel
{
    _originalModel = originalModel;
    self.userInfoModel = [originalModel.userInfo copy];
}

#pragma mark --  pickerViewController-Delegate
- (void)pickerViewController:(LYSDatePickerController *)pickerVC didSelectDate:(NSDate *)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    [self.timeBtn setTitle:[NSString stringFromDate:date formate:dateFormat] forState:UIControlStateNormal];
    self.userInfoModel.arrive_jp = [NSString stringFromDate:date formate:dateFormat];
}

@end
