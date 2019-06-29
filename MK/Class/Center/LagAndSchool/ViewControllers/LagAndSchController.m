//
//  LagAndSchController.m
//  MK
//
//  Created by ginluck on 2019/3/30.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "LagAndSchController.h"
//#import "ValuePickerView.h"
#import "UserInfoEditView.h"
#import "LanguageSchoolList.h"
#import "LanAndSchManager.h"

@interface LagAndSchController ()<UITextFieldDelegate,XDSDropDownMenuDelegate>

@property (nonatomic, strong) NSArray *titleArr;//左标题
@property (nonatomic, strong) XDSDropDownMenu *schoolMenu;//学校下拉控件
@property (nonatomic, strong) XDSDropDownMenu *schoolTimeMenu;//学校时间下拉控件
@property (nonatomic, strong) NSArray *downMenuArr;//装载下拉控件的数组
@property (nonatomic, strong) NSMutableArray *tapViewArr;//装载点击的数组

@property (nonatomic, strong) NSMutableArray <NSString *>*schoolStringList;//学校下拉显示
@property (nonatomic, strong) NSMutableArray <NSString *>*schoolTimeStringList;//学校时间下拉显示
@property (nonatomic, strong) UserInfoEditView *schoolEditView;
@property (nonatomic, strong) UserInfoEditView *schoolTimeEditView;
@property(nonatomic,strong)userInfo * userInfoModel;//用户信息
@property (nonatomic, strong) LanguageSchoolList *selectedLanguageSchoolModel;
@property (nonatomic, strong) UIButton *submitBtn;
@end

@implementation LagAndSchController

-(instancetype)init
{
    if (self = [super init]) {
        self.titleArr = @[@"学校名称",@"时间",];
        self.schoolStringList = [NSMutableArray array];
        self.schoolTimeStringList = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =K_BG_WhiteColor;
    
    self.downMenuArr = @[self.schoolMenu,self.schoolTimeMenu];
    [self configSubViews];
}

-(void)configSubViews
{
    for (int i=0; i<self.titleArr.count; i++) {
        UserInfoEditView *editView;
        if (i == 0) {
            editView = [[UserInfoEditView alloc]initWithFrame:CGRectMake(K_Padding_LeftPadding, KScaleHeight(25)+(KScaleHeight(33+10)*i), self.view.width-K_Padding_LeftPadding*2, KScaleHeight(33))];
            editView.contentString = self.selectedLanguageSchoolModel.name;
        }else{
          editView  = [[UserInfoEditView alloc]initWithFrame:CGRectMake(K_Padding_LeftPadding, KScaleHeight(25)+(KScaleHeight(33+10)*i), 200, KScaleHeight(33))];
          editView.dropDownIma.hidden = NO;
            editView.contentString = self.userInfoModel.jp_school_time;
        }
        editView.contentTF.delegate = self;
        [self.view addSubview:editView];
        [self.tapViewArr addObject:editView];
//        @weakObject(self);
        editView.UserInfoEditViewContenTextChangeBlock = ^(UITextField * _Nonnull contentTF, NSString * _Nonnull contentString) {
//            @strongObject(self);
        };
        if (i == 0) {
            self.schoolEditView = editView;
        }else{
            self.schoolTimeEditView = editView;
            self.submitBtn.topY = editView.bottomY + 50;
        }
        editView.titleString = self.titleArr[i];
    }
}

-(void)setOriginalModel:(PersonModel *)originalModel
{
    if (!originalModel.userInfo) {
        return;
    }
    _originalModel = originalModel;
    self.userInfoModel = [originalModel.userInfo copy];
    for (LanguageSchoolList * languageSchoolModel in _originalModel.languageSchoolList) {
        [self.schoolStringList addObject:languageSchoolModel.name];
        if ([self.originalModel.userInfo.jp_school_id integerValue] == [languageSchoolModel.schoolID integerValue]) {
            self.selectedLanguageSchoolModel = languageSchoolModel;
        }
    }
    for (LanguageSchoolTimeList *schoolTimeModel in _originalModel.languageSchoolTimeList) {
        [self.schoolTimeStringList addObject:schoolTimeModel.name];
    }
}

-(UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_submitBtn];
        _submitBtn.backgroundColor = K_BG_YellowColor;
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 10.0f;
        _submitBtn.frame =CGRectMake(K_Padding_Home_LeftPadding, 40, KScreenWidth-K_Padding_Home_LeftPadding*2, (KScreenWidth-K_Padding_Home_LeftPadding*2)/6);
        [_submitBtn setNormalTitle:@"保存" font:MKFont(14) titleColor:K_Text_BlackColor];
        [_submitBtn addTarget:self action:@selector(submitBtnTarget:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

-(XDSDropDownMenu *)schoolMenu
{
    if (!_schoolMenu) {
        _schoolMenu = [[XDSDropDownMenu alloc]init];
        _schoolMenu.delegate = self;
        _schoolMenu.menuShowType = XDSDropDownMenuShowTypeUserInforEdit;
    }
    return _schoolMenu;
}

-(XDSDropDownMenu *)schoolTimeMenu
{
    if (!_schoolTimeMenu) {
        _schoolTimeMenu = [[XDSDropDownMenu alloc]init];
        _schoolTimeMenu.delegate = self;
        _schoolTimeMenu.menuShowType = XDSDropDownMenuShowTypeUserInforEdit;
    }
    return _schoolTimeMenu;
}

#pragma mark --  EVENT
#pragma mark --  下拉表出现
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.schoolEditView.contentTF) {
        [self showDropDownMenuWithView:self.schoolEditView withTapViewFrame:self.schoolEditView.frame downMenu:self.schoolMenu titleArr:self.schoolStringList];
    }else{
        [self showDropDownMenuWithView:self.schoolTimeEditView withTapViewFrame:self.schoolTimeEditView.frame downMenu:self.schoolTimeMenu titleArr:self.schoolTimeStringList];
    }
    return NO;
}

-(void)showDropDownMenuWithView:(UIView *)tapView withTapViewFrame:(CGRect )tapViewFrame downMenu:(XDSDropDownMenu *)downMenue titleArr:(NSArray *)titleArr
{
    for (int i=0; i<self.downMenuArr.count; i++) {
        XDSDropDownMenu *menu = self.downMenuArr[i];
        UserInfoEditView *editView = self.tapViewArr[i];
        if (menu != downMenue) {
            [menu hideDropDownMenuWithBtnFrame:editView.frame];
        }
    }
    if (downMenue.isShow ==NO) {
        [downMenue showDropDownMenu:tapView withTapViewFrame:tapView.frame arrayOfTitle:titleArr arrayOfImage:nil animationDirection:@"down"];
        //添加到主视图上
        [self.view addSubview:downMenue];
    }else{
        [downMenue  hideDropDownMenuWithBtnFrame:tapView.frame];
    }
}

//
#pragma mark --  下拉表点击
-(void)dropDownMenu:(XDSDropDownMenu *)downMenuView didSelectedWithIndex:(NSInteger )index
{
    if (downMenuView == self.schoolMenu) {
        LanguageSchoolList *schoolModel = self.originalModel.languageSchoolList[index];
        self.userInfoModel.jp_school_id = schoolModel.schoolID;
        self.selectedLanguageSchoolModel = schoolModel;
        self.schoolEditView.contentString = schoolModel.name;
    }else{
        self.userInfoModel.jp_school_time = self.schoolTimeStringList[index];
        self.schoolTimeEditView.contentString = self.schoolTimeStringList[index];
    }
}

#pragma mark --  提交
-(void)submitBtnTarget:(UIButton *)sender
{
    if (self.userInfoModel.jp_school_time == self.originalModel.userInfo.jp_school_time &&
        self.userInfoModel.jp_school_id == self.originalModel.userInfo.jp_school_id) {
        [MBHUDManager showBriefAlert:@"请修改后保存！"];
        return;
    }
    if ([NSString isEmptyWithStr:self.selectedLanguageSchoolModel.schoolID]){
        [MBHUDManager showBriefAlert:@"请选择语言学校！"];
        return;
    }
    if ([NSString isEmptyWithStr:self.userInfoModel.jp_school_time]){
        [MBHUDManager showBriefAlert:@"请选择语言学校时间！"];
        return;
    }
    [MBHUDManager showLoading];
    [LanAndSchManager callBackUpdateLanguageAndSchoolWithJp_school_id:self.selectedLanguageSchoolModel.schoolID  jp_school_time:self.userInfoModel.jp_school_time mobile:self.originalModel.userInfo.mobile mobile_jp:self.originalModel.userInfo.mobile_jp completionBlock:^(BOOL isSuccess, NSString * _Nonnull message) {
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

@end
