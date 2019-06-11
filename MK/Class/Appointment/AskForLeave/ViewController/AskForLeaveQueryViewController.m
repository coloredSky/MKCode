//
//  AskForLeaveQueryViewController.m
//  MK
//
//  Created by 周洋 on 2019/4/3.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "AskForLeaveQueryViewController.h"
#import "AskForLeaveViewController.h"
//View
#import "AppointmentHeaderView.h"
#import "AppointmentTapView.h"
#import "AppointmentTeacherReplyCell.h"
//category
#import "UITextView+WJPlaceholder.h"

#import "AppointmentManager.h"
#import "ApplyLeaveManager.h"
#import "AppointmentDetailModel.h"
#import "AppointmentListModel.h"

@interface AskForLeaveQueryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MKBaseScrollView *contentScroll;
@property (nonatomic, strong) AppointmentHeaderView *headerView;
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) UITextView *reasonTextView;
@property (nonatomic, strong) NSMutableArray *tipStringArr;
@property (nonatomic, strong) AppointmentTapView *classTapView;
@property (nonatomic, strong) AppointmentTapView *lessonTapView;


@property (nonatomic, strong) AppointmentDetailModel *detailModel;
@end

@implementation AskForLeaveQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_YellowColor;
    
    [self creatSubVuew];
    [self startRequest];
}

-(void)startRequest
{
    [MBHUDManager showLoading];
    [AppointmentManager callBackAllApplyDetailWithParameteApply_type:self.showType apply_id:self.appointmentModel.applyID completionBlock:^(BOOL isSuccess, AppointmentDetailModel * _Nonnull detailmodel, NSString * _Nonnull message) {
        [MBHUDManager hideAlert];
        if (isSuccess) {
            [self.tipStringArr removeAllObjects];
            [self.tipStringArr addObject:detailmodel.class_name];
            [self.tipStringArr addObject:detailmodel.lesson_name];
            self.detailModel = detailmodel;
            [self reloadData];
        }
    }];
}

-(void)reloadData
{
    self.classTapView.textString = self.detailModel.class_name;
    self.lessonTapView.textString = self.detailModel.lesson_name;
    self.reasonTextView.text = self.detailModel.detail;
}

-(void)creatSubVuew
{
    [self.view addSubview:self.contentScroll];
    [self.contentScroll addSubview:self.headerView];
    [self.contentScroll addSubview:self.reasonTextView];
}

#pragma mark --  lazy
-(NSArray *)tipStringArr
{
    if (!_tipStringArr) {
        _tipStringArr = @[@"XXX班",@"选择要休息的课程"].mutableCopy;
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
        titleLab.text = @"请假课程";
        
        for (int i=0; i < self.tipStringArr.count; i++) {
            AppointmentTapView *tapView = [AppointmentTapView new];
            CGFloat tapViewY = tapViewY = titleLab.bottomY+ KScaleHeight(13)+(KScaleHeight(33+15)*i);
            tapView.frame =  CGRectMake(K_Padding_Home_LeftPadding, tapViewY, KScreenWidth-K_Padding_Home_LeftPadding*2, KScaleHeight(33));
            tapView.textString = self.tipStringArr[i];
            [self.contentScroll addSubview:tapView];
            if (i == 0) {
                self.classTapView  = tapView;
            }else{
                self.lessonTapView  = tapView;
            }
            //底部消息列表
            if (i == self.tipStringArr.count-1) {
                _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, tapView.bottomY+KScaleHeight(35), KScreenWidth, KScreenHeight-tapView.bottomY-KScaleHeight(35)) style:UITableViewStyleGrouped];
                _contentTable.delegate = self;
                _contentTable.dataSource = self;
                [self.contentScroll addSubview:_contentTable];
                _contentTable.backgroundColor = K_BG_WhiteColor;
                _contentTable.sectionHeaderHeight = 0.001;
                [_contentTable registerNib:[UINib nibWithNibName:@"AppointmentTeacherReplyCell" bundle:nil] forCellReuseIdentifier:@"AppointmentTeacherReplyCell"];
            }
        }
    }
    return  _contentScroll;
}

-(AppointmentHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[AppointmentHeaderView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleHeight(86)+K_NaviHeight)];
        _headerView.titleString = @"等待回复";
        [self.contentScroll addSubview:_headerView];
        _headerView.showType = AppointmentHeaderViewShowTypeEditting;
        __weak typeof(self) weakSelf = self;
        _headerView.operationBlock = ^(AppointmentHeaderViewOperationType operationType) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (operationType == AppointmentHeaderViewOperationTypeEdit) {
                AskForLeaveViewController *askForLeaveVC = [AskForLeaveViewController new];
                askForLeaveVC.operationType = AskForLeaveOperationTypeEdit;
                askForLeaveVC.detailModel = strongSelf.detailModel;
                [strongSelf.navigationController pushViewController:askForLeaveVC animated:YES];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认取消申请" preferredStyle:UIAlertControllerStyleAlert];
                [strongSelf presentViewController:alert animated:YES completion:nil];
                __weak typeof(self) weakSelf = strongSelf;
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    [strongSelf deleteApplyAskForLeave];
                }];
                UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:cancleAction];
                [alert addAction:sureAction];
            }
        };
    }
    return _headerView;
}

-(void)deleteApplyAskForLeave
{
    [ApplyLeaveManager callBackDeleteAskForLeaveRequestWithParameteApply_id:self.appointmentModel.applyID withCompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message) {
        if (isSuccess) {
            [MBHUDManager showBriefAlert:@"删除请假申请成功！"];
            [[NSNotificationCenter defaultCenter]postNotificationName:kMKApplyAskForLeaveListRefreshNotifcationKey object:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self backToPreviousViewController];
            });
        }else{
            if (![NSString isEmptyWithStr:message]) {
                [MBHUDManager showBriefAlert:message];
            }
        }
    }];
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

#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppointmentTeacherReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppointmentTeacherReplyCell" forIndexPath:indexPath];
    [cell cellRefreshData];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KScaleHeight(95);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return KScaleHeight(48);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleHeight(48))];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, headerView.width, headerView.height)];
    [headerView addSubview:titleLab];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [titleLab setFont:K_Font_Text_Min_Max textColor:K_Text_grayColor withBackGroundColor:nil];
    titleLab.text = @"暂无回复";
    return headerView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
#pragma mark - cell did selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
