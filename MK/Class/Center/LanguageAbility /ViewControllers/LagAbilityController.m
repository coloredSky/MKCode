//
//  LagAbilityController.m
//  MK
//
//  Created by ginluck on 2019/3/30.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "LagAbilityController.h"
#import "UserInfoEditView.h"
#import "LanguageAblelityManager.h"

@interface LagAbilityController ()<XDSDropDownMenuDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) NSArray *titleArr;//左标题
@property (nonatomic, strong) XDSDropDownMenu *jpLauguageAbilityMenu;//日语下拉控件
@property (nonatomic, strong) NSArray *downMenuArr;//装载下拉控件的数组
@property (nonatomic, strong) NSMutableArray <NSString *>*menuStringList;//日语能力下拉显示

@property (nonatomic, strong) UserInfoEditView *toeicEditView;
@property (nonatomic, strong) UserInfoEditView *toeflEditView;
@property (nonatomic, strong) UserInfoEditView *jpEditView;

@property(nonatomic,strong)userInfo * userInfoModel;//用户信息
@end

@implementation LagAbilityController

-(instancetype)init
{
    if (self = [super init]) {
        self.titleArr = @[@"TOEIC",@"TOEFL",@"日语能力"];
        self.menuStringList = [NSMutableArray arrayWithCapacity:5];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =K_BG_WhiteColor;
    [self configSubViews];
}

-(void)configSubViews
{
    self.downMenuArr = @[self.jpLauguageAbilityMenu];
    for (NSInteger i=0; i<self.titleArr.count; i++) {
        UserInfoEditView *editView = [[UserInfoEditView alloc]initWithFrame:CGRectMake(K_Padding_LeftPadding, KScaleHeight(25)+(KScaleHeight(33+10)*i), self.view.width-K_Padding_LeftPadding*2, KScaleHeight(33))];
        [self.view addSubview:editView];
        @weakObject(self);
        editView.UserInfoEditViewContenTextChangeBlock = ^(UITextField * _Nonnull contentTF, NSString * _Nonnull contentString) {
            @strongObject(self);
            if (contentTF == self.toeicEditView.contentTF) {
                self.userInfoModel.toeic = contentString;
            }else if (contentTF == self.toeflEditView.contentTF){
                self.userInfoModel.toefl = contentString;
            }
        };
        if (i == 0) {
            self.toeicEditView = editView;
            editView.contentString = self.originalModel.userInfo.toeic;
        }else if (i == 1){
            editView.contentString = self.originalModel.userInfo.toeic;
            self.toeflEditView = editView;
        }else{
            self.jpEditView = editView;
            editView.contentString = self.originalModel.userInfo.jlpt;
            editView.contentTF.delegate = self;
            self.submitBtn.topY = editView.bottomY + 50;
        }
        editView.titleString = self.titleArr[i];
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


-(void)setOriginalModel:(PersonModel *)originalModel
{
    if (!originalModel.userInfo) {
        return;
    }
    _originalModel = originalModel;
    self.userInfoModel = [originalModel.userInfo copy];
    for (JapaneseLanguageAbilityList * japaneseAbilityModel in _originalModel.japaneseLanguageAbilityList) {
        [self.menuStringList addObject:japaneseAbilityModel.name];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
}

-(XDSDropDownMenu *)jpLauguageAbilityMenu
{
    if (!_jpLauguageAbilityMenu) {
        _jpLauguageAbilityMenu = [[XDSDropDownMenu alloc]init];
        _jpLauguageAbilityMenu.delegate = self;
        _jpLauguageAbilityMenu.menuShowType = XDSDropDownMenuShowTypeUserInforEdit;
    }
    return _jpLauguageAbilityMenu;
}

#pragma mark --  EVENT
#pragma mark --  下拉表出现
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self showDropDownMenuWithView:self.jpEditView withTapViewFrame:self.jpEditView.frame downMenu:self.jpLauguageAbilityMenu titleArr:self.menuStringList];
    return NO;
}

-(void)showDropDownMenuWithView:(UIView *)tapView withTapViewFrame:(CGRect )tapViewFrame downMenu:(XDSDropDownMenu *)downMenue titleArr:(NSArray *)titleArr
{
    for (int i=0; i<self.downMenuArr.count; i++) {
        XDSDropDownMenu *menu = self.downMenuArr[i];
//        AppointmentTapView *clickView = self.tapViewArr[i];
        if (menu != downMenue) {
            [menu hideDropDownMenuWithBtnFrame:tapView.frame];
        }
    }
    if (downMenue.isShow ==NO) {
        [downMenue showDropDownMenu:tapView withTapViewFrame:tapView.frame arrayOfTitle:titleArr arrayOfImage:nil animationDirection:@"down"];
        //    [downMenue showDropDownMenuWithViewFrame:tapView.frame arrayOfTitle:titleArr];
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
    if (downMenuView == self.jpLauguageAbilityMenu) {
        JapaneseLanguageAbilityList *japaneseModel = self.originalModel.japaneseLanguageAbilityList[index];
        self.userInfoModel.jlpt = japaneseModel.name;
        self.jpEditView.contentString = japaneseModel.name;
    }
}

#pragma mark --  提交
-(void)submitBtnTarget:(UIButton *)sender
{
    if (self.userInfoModel.toeic == self.originalModel.userInfo.toeic &&
        self.userInfoModel.toefl == self.originalModel.userInfo.toefl &&
        self.userInfoModel.jlpt == self.originalModel.userInfo.jlpt) {
        [MBHUDManager showBriefAlert:@"请修改后保存！"];
        return;
    }
    if ([NSString isEmptyWithStr:self.toeicEditView.contentTF.text]){
        [MBHUDManager showBriefAlert:@"请输入TOEIC分数"];
        return;
    }
    if ([NSString isEmptyWithStr:self.toeflEditView.contentTF.text]){
        [MBHUDManager showBriefAlert:@"请输入TOEFL分数"];
        return;
    }
    if ([NSString isEmptyWithStr:self.jpEditView.contentTF.text]) {
        [MBHUDManager showBriefAlert:@"请输入日语等级"];
        return;
    }
    [MBHUDManager showLoading];
    [LanguageAblelityManager callBackUpdateLanguageAblelityWithToeic:self.toeicEditView.contentTF.text toefl:self.toeicEditView.contentTF.text jlpt:self.jpEditView.contentTF.text mobile:self.userInfoModel.mobile mobile_jp:self.userInfoModel.mobile_jp CompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message) {
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
