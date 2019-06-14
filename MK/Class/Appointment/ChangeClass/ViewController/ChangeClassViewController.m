//
//  ChangeClassViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/29.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "ChangeClassViewController.h"
//View
#import "AppointmentHeaderView.h"
#import "AppointmentTapView.h"
//category
#import "UITextView+WJPlaceholder.h"

#import "ChangeClassManager.h"
#import "ChangeClassCouseModel.h"
#import "AppointmentListModel.h"


@interface ChangeClassViewController ()<AppointmentTapViewDelegate,XDSDropDownMenuDelegate>
@property (nonatomic, strong) MKBaseScrollView *contentScroll;
@property (nonatomic, strong) AppointmentHeaderView *headerView;
@property (nonatomic, strong) UITextView *reasonTextView;
@property (nonatomic, strong) NSArray *tipStringArr;
//下拉
@property (nonatomic, strong) XDSDropDownMenu *originalClasssDownMenu;//现有班级
@property (nonatomic, strong) XDSDropDownMenu *otherClasssDownMenu;//更改后的班级
@property (nonatomic, strong) NSArray *downMenuArr;//装载下拉控件
@property (nonatomic, strong) NSMutableArray *tapViewArr;//装载点击控件
//@property (nonatomic, strong) NSArray *originalClassArr;
//@property (nonatomic, strong) NSArray *otherClassArr;
@property (nonatomic, strong) NSArray *originalClassList;//原有课程
@property (nonatomic, strong) NSArray *originalClassStringList;//原有课程名字
@property (nonatomic, strong) ChangeClassCouseModel *selectedOriginalCouseModel;
@property (nonatomic, strong) ChangeClassCouseModel *selectedChangeCouseModel;
@end

@implementation ChangeClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_YellowColor;
    
    [self initData];
    [self creatSubVuew];
    [self startRequest];
    if (self.operationType == ChangeClassOperationTypeEdit) {
        self.reasonTextView.text = self.appointmentModel.reason;
        self.reasonTextView.placeholder = @"理由";
        AppointmentTapView *originalTapView = self.tapViewArr[0];
        originalTapView.textString = self.appointmentModel.class_name;
        AppointmentTapView *otherTapView = self.tapViewArr[1];
        otherTapView.textString = self.appointmentModel.classNewName;
    }
}

-(void)startRequest
{
    [MBHUDManager showLoading];
    [ChangeClassManager callBackChangeClassCourseListRequestWithCompletionBlock:^(BOOL isSuccess, NSArray<ChangeClassCouseModel *> * _Nonnull courseList,NSArray <NSString *>*courseStringList, NSString * _Nonnull message) {
        [MBHUDManager hideAlert];
        if (isSuccess) {
            self.originalClassList = courseList;
            self.originalClassStringList = courseStringList;
            if (self.operationType == ChangeClassOperationTypeEdit) {
                for (ChangeClassCouseModel *classModel in courseList) {
                    if ([classModel.course_id integerValue] == [self.appointmentModel.class_id integerValue]) {
                        self.selectedOriginalCouseModel = classModel;
                    }
                }
                for (ChangeClassCouseModel *classModel in self.selectedOriginalCouseModel.changeClassList) {
                    if ([classModel.course_id integerValue] == [self.appointmentModel.classNewID integerValue]) {
                        self.selectedChangeCouseModel = classModel;
                    }
                }
            }
        }
    }];
}

-(void)initData
{
    self.downMenuArr = @[self.originalClasssDownMenu,self.otherClasssDownMenu];
    self.tapViewArr = [NSMutableArray arrayWithCapacity:2];
}
-(void)creatSubVuew
{
    [self.view addSubview:self.contentScroll];
    [self.contentScroll addSubview:self.headerView];
    [self.contentScroll addSubview:self.reasonTextView];
}

#pragma mark --  lazy
-(XDSDropDownMenu *)originalClasssDownMenu
{
    if (!_originalClasssDownMenu) {
        _originalClasssDownMenu = [[XDSDropDownMenu alloc]init];
        _originalClasssDownMenu.delegate = self;
    }
    return _originalClasssDownMenu;
}
-(XDSDropDownMenu *)otherClasssDownMenu
{
    if (!_otherClasssDownMenu) {
        _otherClasssDownMenu = [[XDSDropDownMenu alloc]init];
        _otherClasssDownMenu.delegate = self;
    }
    return _otherClasssDownMenu;
}
-(NSArray *)tipStringArr
{
    if (!_tipStringArr) {
        _tipStringArr = @[@"选择原有班级",@"选择希望更改的班级"];
    }
    return _tipStringArr;
}
-(MKBaseScrollView *)contentScroll
{
    if (!_contentScroll) {
        _contentScroll = [[MKBaseScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        _contentScroll.backgroundColor = K_BG_YellowColor;
        //
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(K_Padding_Home_LeftPadding, self.reasonTextView.bottomY+KScaleHeight(20), 200, KScaleHeight(20))];
        [self.contentScroll addSubview:titleLab];
        [titleLab setFont:K_Font_Text_Normal textColor:K_Text_grayColor withBackGroundColor:nil];
        titleLab.text = @"选择班级";
        
        for (int i=0; i < self.tipStringArr.count; i++) {
            AppointmentTapView *tapView = [AppointmentTapView new];
            [self.tapViewArr addObject:tapView];
            tapView.delegate = self;
            tapView.tag = i+1;
            CGFloat tapViewY = tapViewY = titleLab.bottomY+ KScaleHeight(13)+(KScaleHeight(33+15)*i);
            tapView.frame =  CGRectMake(K_Padding_Home_LeftPadding, tapViewY, KScreenWidth-K_Padding_Home_LeftPadding*2, KScaleHeight(33));
            tapView.textString = self.tipStringArr[i];
            [self.contentScroll addSubview:tapView];
            //底部按钮
            if (i == self.tipStringArr.count-1) {
                UIButton *submitBtn = [UIButton getBottomBtnWithBtnX:tapView.leftX btnY:tapView.bottomY+KScaleHeight(130) btnTitle:@"发送"];
                [submitBtn addTarget:self action:@selector(submitTarget:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentScroll addSubview:submitBtn];
            }
        }
    }
    return  _contentScroll;
}
-(AppointmentHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[AppointmentHeaderView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleHeight(86)+K_NaviHeight)];
        if (self.operationType == ChangeClassOperationTypeTypeNew) {
            _headerView.titleString = @"申请换班";
        }else{
            _headerView.titleString = @"修改申请";
        }
    }
    return _headerView;
}
-(UITextView *)reasonTextView
{
    if (!_reasonTextView) {
        _reasonTextView = [[UITextView alloc]initWithFrame:CGRectMake(K_Padding_Home_LeftPadding, self.headerView.bottomY+KScaleHeight(30), KScreenWidth-K_Padding_Home_LeftPadding*2, KScaleHeight(122))];
        _reasonTextView.backgroundColor = K_BG_blackColor;
        _reasonTextView.layer.masksToBounds = YES;
        _reasonTextView.layer.cornerRadius = KScaleWidth(8);
        _reasonTextView.textColor = K_Text_WhiteColor;
        _reasonTextView.font = K_Font_Text_Normal;
        _reasonTextView.placeholder = @"理由";
        _reasonTextView.placeholdFont = K_Font_Text_Normal;
        _reasonTextView.placeholderColor = K_Text_DeepGrayColor;
    }
    return _reasonTextView;
}

#pragma mark --  EVENT
#pragma mark --  下拉表出现
-(void)appointmentTapViewTapClickWithView:(AppointmentTapView *)tapView
{
    if (tapView.tag == 1) {//原有班级
        if (self.selectedOriginalCouseModel == nil) {
            [MBHUDManager showBriefAlert:@"您目前没有能选择的班级！！"];
            return;
        }
        //初始化选择菜单
        [self showDropDownMenuWithView:tapView withTapViewFrame:tapView.frame downMenu:self.originalClasssDownMenu titleArr:self.originalClassStringList];
    }else{
        //更改后的班级
        if (self.selectedOriginalCouseModel == nil) {
            [MBHUDManager showBriefAlert:@"请先选择原有班级！！"];
            return;
        }
        if (self.selectedOriginalCouseModel.changeClassStringList.count == 0) {
            [MBHUDManager showBriefAlert:@"目前没有能更换的班级班级！！"];
            return;
        }
        [self showDropDownMenuWithView:tapView withTapViewFrame:tapView.frame downMenu:self.otherClasssDownMenu titleArr:self.selectedOriginalCouseModel.changeClassStringList];
    }
}
#pragma mark --  下拉表点击
-(void)dropDownMenu:(XDSDropDownMenu *)downMenuView didSelectedWithIndex:(NSInteger )index
{
    if (downMenuView == self.originalClasssDownMenu) {
        ChangeClassCouseModel *originalCourseModel =  self.originalClassList[index];
        if (originalCourseModel == self.selectedOriginalCouseModel) {
            return;
        }
        AppointmentTapView *tapView = self.tapViewArr[0];
        tapView.textString = self.originalClassStringList[index];
        self.selectedOriginalCouseModel = originalCourseModel;
        
        AppointmentTapView *changeClassTapView = self.tapViewArr[1];
        changeClassTapView.textString = @"选择希望更改的班级";
        self.selectedChangeCouseModel = nil;
    }else{
        ChangeClassCouseModel *changeCourseModel =  self.selectedOriginalCouseModel.changeClassList[index];
        if (changeCourseModel == self.selectedChangeCouseModel) {
            return;
        }
        AppointmentTapView *tapView = self.tapViewArr[1];
        tapView.textString = self.selectedOriginalCouseModel.changeClassStringList[index];
        self.selectedChangeCouseModel = changeCourseModel;
    }
}

-(void)showDropDownMenuWithView:(AppointmentTapView *)tapView withTapViewFrame:(CGRect )tapViewFrame downMenu:(XDSDropDownMenu *)downMenue titleArr:(NSArray *)titleArr
{
    for (int i=0; i<self.downMenuArr.count; i++) {
        XDSDropDownMenu *menu = self.downMenuArr[i];
        AppointmentTapView *clickView = self.tapViewArr[i];
        if (menu != downMenue) {
            [menu hideDropDownMenuWithBtnFrame:clickView.frame];
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

#pragma mark --  申请换班
-(void)submitTarget:(UIButton *)sender
{
    if ([NSString isEmptyWithStr:self.reasonTextView.text]) {
        [MBHUDManager showBriefAlert:@"请填写换班的理由！！"];
        return;
    }
    if (self.selectedOriginalCouseModel == nil) {
        [MBHUDManager showBriefAlert:@"请选择原有班级！！"];
        return;
    }
    if (self.selectedChangeCouseModel == nil) {
        [MBHUDManager showBriefAlert:@"请选择希望更换的班级！！"];
        return;
    }
    [ChangeClassManager callBackChangeClassRequestWithParameterClass_id:self.selectedOriginalCouseModel.changeID new_class_id:self.selectedChangeCouseModel.changeID reason:self.reasonTextView.text CompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message) {
        if (isSuccess) {
            [MBHUDManager showBriefAlert:@"换班申请成功！！"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            if (![NSString isEmptyWithStr:message]) {
                [MBHUDManager showBriefAlert:message];
            }
        }
    }];
}

@end
