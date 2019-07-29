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
@property (nonatomic, strong) NSMutableArray *dataList;


@end

@implementation MKUserJoinCourseView

-(void)awakeFromNib
{
    [super awakeFromNib];
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
//    return self.dataList.count;
    return 3;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    UIView *reusingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 40)];
    UILabel *contentLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, reusingView.width-40, reusingView.height)];
    [reusingView addSubview:contentLab];
    [contentLab setFont:MKFont(20) textColor:K_Text_BlackColor withBackGroundColor:nil];
    contentLab.textAlignment = NSTextAlignmentCenter;
    contentLab.text = @"2019年7月班";
    return reusingView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}

#pragma mark --  EVENT

- (IBAction)courseClassSelected:(UIButton *)sender {
    [[BMPopView shareInstance]dismiss];
}
- (IBAction)cancleTarget:(UIButton *)sender {
    [[BMPopView shareInstance]dismiss];
}
- (IBAction)submitTarget:(UIButton *)sender {
    [[BMPopView shareInstance]dismiss];
}


@end
