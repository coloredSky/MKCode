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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *dateTitleLab;

@end

@implementation JapanDateVController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =K_BG_WhiteColor;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 6.0f;
    self.bgViewHeightConstraint.constant = KScaleHeight(36);
        [self.dateTitleLab setFont:MKFont(12) textColor:K_Text_grayColor withBackGroundColor:nil];
    [self.timeBtn  setTitle:self.originalModel.userInfo.arrive_jp forState:UIControlStateNormal];
    [self.timeBtn setNormalTitle:@"" font:MKFont(14) titleColor:K_Text_BlackColor];
}

-(void)viewWillLayoutSubviews
{
    
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
        [MBHUDManager showLoading];
        [JapanDateManager callBackUpdateJapanDateWithArrive_jp:self.userInfoModel.arrive_jp mobile:self.originalModel.userInfo.mobile mobile_jp:self.originalModel.userInfo.mobile_jp completionBlock:^(BOOL isSuccess, NSString * _Nonnull message) {
            [MBHUDManager hideAlert];
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
