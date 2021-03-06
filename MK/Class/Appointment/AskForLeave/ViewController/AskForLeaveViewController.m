//
//  AskForLeaveViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/31.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "AskForLeaveViewController.h"
//View
#import "AppointmentHeaderView.h"
#import "AppointmentTapView.h"
#import "MKDropDownMenu.h"
//category
#import "UITextView+WJPlaceholder.h"
#import "ApplyLeaveManager.h"
#import "ApplyLeaveCourseModel.h"
#import "AppointmentDetailModel.h"

@interface AskForLeaveViewController ()<XDSDropDownMenuDelegate, AppointmentTapViewDelegate>
@property (nonatomic, strong) MKBaseScrollView *contentScroll;
@property (nonatomic, strong) AppointmentHeaderView *headerView;
@property (nonatomic, strong) UITextView *reasonTextView;
@property (nonatomic, strong) NSMutableArray *tipStringArr;

//下拉
@property (nonatomic, strong) XDSDropDownMenu *classsDownMenu;//班级
@property (nonatomic, strong) XDSDropDownMenu *courseDownMenu;//休息的课程
@property (nonatomic, strong) NSArray *downMenuArr;//装载下拉控件
@property (nonatomic, strong) NSMutableArray *tapViewArr;//装载点击控件
@property (nonatomic, strong) NSArray *courseList;//数据
@property (nonatomic, strong) NSMutableArray *courseNameArr;//请假的班级名字
@property (nonatomic, strong) ApplyLeaveCourseModel *selectedCourseModel;//
@property (nonatomic, strong) ApplyLeaveLessonModel *selectedLessonModel;//
@end

@implementation AskForLeaveViewController

-(instancetype)init
{
    if (self = [super init]) {
        self.courseNameArr = [NSMutableArray array];
        self.tapViewArr = [NSMutableArray arrayWithCapacity:2];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_YellowColor;
    [self creatSubVuew];
    [self startRequest];
}

-(void)startRequest
{
    [MBHUDManager showLoading];
    [ApplyLeaveManager callBackApplyLeaveCourseListWithParameter:@"1" completionBlock:^(BOOL isSuccess, NSArray<ApplyLeaveCourseModel *> * _Nonnull courseList, NSString * _Nonnull message) {
        [MBHUDManager hideAlert];
        if (isSuccess) {
            self.courseList = courseList;
            for (ApplyLeaveCourseModel *model in courseList) {
                if (self.operationType == AskForLeaveOperationTypeEdit) {
                    if ([model.class_id integerValue] == [self.detailModel.class_id integerValue]) {
                        self.selectedCourseModel = model;
                        for (ApplyLeaveLessonModel *lessonModel in model.lessonList) {
                            if ([lessonModel.lesson_id integerValue] == [self.detailModel.lesson_id integerValue]) {
                                self.selectedLessonModel = lessonModel;
                            }
                        }
                    }
                }
                [self.courseNameArr addObject:model.class_name];
            }
        }
    }];
}

-(void)creatSubVuew
{
    self.downMenuArr = @[self.classsDownMenu,self.courseDownMenu];
    [self.view addSubview:self.contentScroll];
    [self.contentScroll addSubview:self.headerView];
    [self.contentScroll addSubview:self.reasonTextView];
}

#pragma mark --  lazy

-(NSMutableArray *)tipStringArr
{
    if (!_tipStringArr) {
        if (self.operationType == AskForLeaveOperationTypeNew) {
            _tipStringArr = @[@"选择要休息的班级",@"选择要休息的课程"].mutableCopy;
        }else{
            _tipStringArr = [NSMutableArray arrayWithCapacity:2];
            [_tipStringArr addObject:self.detailModel.class_name];
            [_tipStringArr addObject:self.detailModel.lesson_name];
        }
    }
    return _tipStringArr;
}

-(XDSDropDownMenu *)classsDownMenu
{
    if (!_classsDownMenu) {
        _classsDownMenu = [[XDSDropDownMenu alloc]init];
        _classsDownMenu.delegate = self;
    }
    return _classsDownMenu;
}

-(XDSDropDownMenu *)courseDownMenu
{
    if (!_courseDownMenu) {
        _courseDownMenu = [[XDSDropDownMenu alloc]init];
        _courseDownMenu.delegate = self;
    }
    return _courseDownMenu;
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
        titleLab.text = @"请假课程";
        
        for (int i=0; i < self.tipStringArr.count; i++) {
            AppointmentTapView *tapView = [AppointmentTapView new];
            [self.contentScroll addSubview:tapView];
            [self.tapViewArr addObject:tapView];
            tapView.delegate = self;
            tapView.tag = i+1;
            CGFloat tapViewY = tapViewY = titleLab.bottomY+ KScaleHeight(13)+(KScaleHeight(33+15)*i);
            tapView.frame =  CGRectMake(K_Padding_Home_LeftPadding, tapViewY, KScreenWidth-K_Padding_Home_LeftPadding*2, KScaleHeight(33));
            tapView.textString = self.tipStringArr[i];
            
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
        _headerView = [[AppointmentHeaderView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleHeight(86)+K_NaviHeight)];;
        if (self.operationType == AskForLeaveOperationTypeNew) {
            _headerView.titleString = @"请假申请";
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
        if (self.operationType == AskForLeaveOperationTypeEdit) {
            _reasonTextView.text = self.detailModel.detail;
        }
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
        //初始化选择菜单
        if (self.courseNameArr.count == 0) {
            [MBHUDManager showBriefAlert:@"您还没有需要请假的课程！"];
            return;
        }
        [self showDropDownMenuWithView:tapView withTapViewFrame:tapView.frame downMenu:self.classsDownMenu titleArr:self.courseNameArr];
    }else{
            //更改后的班级
            if (self.selectedCourseModel == nil) {
                 [MBHUDManager showBriefAlert:@"请先选择需要请假的班级！"];
                return;
            }
            if (self.selectedCourseModel.lessonNameList.count  == 0) {
                [MBHUDManager showBriefAlert:@"您目前没有需要请假的课程！"];
                return;
            }
            [self showDropDownMenuWithView:tapView withTapViewFrame:tapView.frame downMenu:self.courseDownMenu titleArr:self.selectedCourseModel.lessonNameList];
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
        //    [downMenue showDropDownMenuWithViewFrame:tapView.frame arrayOfTitle:titleArr];
        //添加到主视图上
        [self.view addSubview:downMenue];
    }else{
        [downMenue  hideDropDownMenuWithBtnFrame:tapView.frame];
    }
}

#pragma mark --  下拉表点击
-(void)dropDownMenu:(XDSDropDownMenu *)downMenuView didSelectedWithIndex:(NSInteger )index
{
    if (downMenuView == self.classsDownMenu) {
        ApplyLeaveCourseModel *courseModel = self.courseList[index];
        if (self.selectedCourseModel == courseModel) {
            return;
        }
        AppointmentTapView *tapView = self.tapViewArr[0];
        tapView.textString = self.courseNameArr[index];
        self.selectedCourseModel = courseModel;
        
         AppointmentTapView *lessonTapView = self.tapViewArr[1];
        lessonTapView.textString = @"选择要休息的课程";
        self.selectedLessonModel = nil;
    }else{
        if (self.selectedCourseModel == nil) {
            [MBHUDManager showBriefAlert:@"请先选择要休息的班级！！"];
            return;
        }
        ApplyLeaveLessonModel *lessonModel = self.selectedCourseModel.lessonList[index];
        if (self.selectedLessonModel == lessonModel) {
            return;
        }
        AppointmentTapView *tapView = self.tapViewArr[1];
        tapView.textString = self.selectedCourseModel.lessonNameList[index];
        self.selectedLessonModel  = lessonModel;
    }
}


#pragma mark --  提交
-(void)submitTarget:(UIButton *)sender
{
    if ([NSString isEmptyWithStr:self.reasonTextView.text]) {
        [MBHUDManager showBriefAlert:@"请填写您请假的理由！"];
        return;
    }
    if (!self.selectedCourseModel) {
        [MBHUDManager showBriefAlert:@"请选择您要请假的班级！"];
        return;
    }
    if (!self.selectedLessonModel) {
        if (self.operationType == AskForLeaveOperationTypeNew) {
            [MBHUDManager showBriefAlert:@"请选择您要请假的课程！"];
        }else{
            [MBHUDManager showBriefAlert:@"请重新选择您要请假的课程！"];
        }
        return;
    }
    [self.reasonTextView endEditing:YES];
    if (self.operationType == AskForLeaveOperationTypeNew) {
        [self requestAddAskForLeave];
    }else{
        [self requestUpdateAskForLeave];
    }

}

-(void)requestAddAskForLeave
{
    [MBHUDManager showLoading];
    [ApplyLeaveManager callBackAddApplyLeaveWithParameterClass_id:self.selectedCourseModel.class_id lesson_id:self.selectedLessonModel.lesson_id detail:self.reasonTextView.text completionBlock:^(BOOL isSuccess, NSString * _Nonnull message) {
        [MBHUDManager hideAlert];
        if (isSuccess) {
            if (self.operationType == AskForLeaveOperationTypeNew) {
                [MBHUDManager showBriefAlert:@"申请请假成功！"];
            }else{
                [MBHUDManager showBriefAlert:@"修改请假申请成功！"];
            }
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter]postNotificationName:kMKApplyAskForLeaveListRefreshNotifcationKey object:nil];
        }else{
            if (![NSString isEmptyWithStr:message]) {
                [MBHUDManager showBriefAlert:message];
            }else{
                [MBHUDManager showBriefAlert:@"请假失败！"];
            }
        }
    }];
}

-(void)requestUpdateAskForLeave
{
    [MBHUDManager showLoading];
    [ApplyLeaveManager callBackEditApplyLeaveWithParameterApply_id:self.detailModel.applyID class_id:self.selectedCourseModel.class_id lesson_id:self.selectedLessonModel.lesson_id detail:self.reasonTextView.text completionBlock:^(BOOL isSuccess, NSString * _Nonnull message) {
        [MBHUDManager hideAlert];
        if (isSuccess) {
            if (self.operationType == AskForLeaveOperationTypeNew) {
                [MBHUDManager showBriefAlert:@"申请请假成功！"];
            }else{
                [MBHUDManager showBriefAlert:@"修改请假申请成功！"];
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter]postNotificationName:kMKApplyAskForLeaveListRefreshNotifcationKey object:nil];
        }else{
            if (![NSString isEmptyWithStr:message]) {
                [MBHUDManager showBriefAlert:message];
            }else{
                [MBHUDManager showBriefAlert:@"编辑失败！"];
            }
        }
    }];
}
@end
