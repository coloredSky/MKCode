//
//  MKUserJoinCourseView.m
//  MK
//
//  Created by 周洋 on 2019/7/29.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "MKUserJoinCourseView.h"
#import "BMPopView.h"

@interface MKUserJoinCourseView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *courseBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *coursePicker;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (nonatomic, strong) NSArray <NSString *>*dataList;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation MKUserJoinCourseView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.selectedIndex = -1;
    self.coursePicker.delegate = self;
    self.coursePicker.dataSource = self;
    self.topView.backgroundColor = UIColorFromAlphaRGB_0x(0xC6C6C6, .6);
    self.bottomView.backgroundColor = K_BG_YellowColor;
    self.coursePicker.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
    [self.courseBtn setNormalTitle:@"选择班级" font:MKFont(16) titleColor:UIColorFromAlphaRGB_0x(0xFDF303, 1)];
    [self.cancleBtn setNormalTitle:@"取消" font:MKFont(16) titleColor:UIColorFromAlphaRGB_0x(0xFDF303, 1)];
    [self.submitBtn setNormalTitle:@"提交" font:MKFont(18) titleColor:K_Text_BlackColor];
    
}

#pragma mark --  dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataList.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor colorWithWhite:.7 alpha:1];
        }
    }
    
    UIView *reusingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 40)];
    UILabel *contentLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, reusingView.width-40, reusingView.height)];
    [reusingView addSubview:contentLab];
    [contentLab setFont:MKFont(20) textColor:K_Text_BlackColor withBackGroundColor:nil];
    contentLab.textAlignment = NSTextAlignmentCenter;
    contentLab.text = self.dataList[row];
    return reusingView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedIndex = row;
}

#pragma mark --  EVENT
- (IBAction)cancleTarget:(UIButton *)sender {
    [[BMPopView shareInstance]dismiss];
}

- (IBAction)courseClassSelected:(UIButton *)sender {
    if (self.selectedIndex == -1) {
        [MBHUDManager showBriefAlert:@"当前暂时没有可供选择的班级！"];
        return;
    }
    if (self.userJoinClassBlock) {
        self.userJoinClassBlock(self.selectedIndex);
    }
//    [[BMPopView shareInstance]dismiss];
}

- (IBAction)submitTarget:(UIButton *)sender {
    if (self.selectedIndex == -1) {
        [MBHUDManager showBriefAlert:@"当前暂时没有可供选择的班级！"];
        return;
    }
    if (self.userJoinClassBlock) {
        self.userJoinClassBlock(self.selectedIndex);
    }
//    [[BMPopView shareInstance]dismiss];
}

-(void)userJoinCourseViewReloadDataWithClassList:(NSArray <NSString *>*)classList
{
    self.dataList = classList;
    if (classList.count > 0) {
        self.selectedIndex = 0;
        [self.coursePicker reloadAllComponents];
    }
}

@end
