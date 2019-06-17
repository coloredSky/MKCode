//
//  MeetingQueryViewController.m
//  MK
//
//  Created by 周洋 on 2019/4/1.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MeetingQueryViewController.h"
#import "MKMeetingViewController.h"
//View
#import "AppointmentHeaderView.h"
#import "AppointmentTapView.h"
#import "AppointmentTeacherReplyCell.h"
//model
#import "AppointmentListModel.h"
#import "AppoinementReplyModel.h"
//manager
#import "MakeMeetingManager.h"

@interface MeetingQueryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MKBaseScrollView *contentScroll;
@property (nonatomic, strong) AppointmentHeaderView *headerView;
@property (nonatomic, strong) MKBaseTableView *contentTable;///回复
@property (nonatomic, strong) NSMutableArray *tipStringArr;
@property (nonatomic, strong) NSArray *applyList;//回复列表
@end

@implementation MeetingQueryViewController

-(instancetype)init
{
    if (self = [super init]) {
        _tipStringArr = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_YellowColor;
    [self startRequest];
    [self initDta];
}

-(void)initDta
{
    [self.tipStringArr addObject:self.appointmentModel.type];
    [self.tipStringArr addObject:self.appointmentModel.staff_name];
    [self.tipStringArr addObject:self.appointmentModel.show_time_one];
    [self.tipStringArr addObject:self.appointmentModel.show_time_two];
    [self.tipStringArr addObject:self.appointmentModel.show_time_three];
}

-(void)startRequest
{
    //得到回复列表
    [AppointmentManager callBackAllApplyAppointmentReplyListWithParameteApply_type:self.showType apply_id:self.appointmentModel.applyID completionBlock:^(BOOL isSuccess, NSArray<AppoinementReplyModel *> * _Nonnull applyList, NSString * _Nonnull message) {
        if (isSuccess) {
            self.applyList = applyList;
            [self.contentTable reloadData];
        }
    }];
}


-(MKBaseScrollView *)contentScroll
{
    if (!_contentScroll) {
        _contentScroll = [MKBaseScrollView new];
        [self.view addSubview:_contentScroll];
        _contentScroll.backgroundColor = K_BG_YellowColor;
        //
        for (int i=0; i < self.tipStringArr.count; i++) {
            AppointmentTapView *tapView = [AppointmentTapView new];
            CGFloat tapViewY = 0;
            if (i < 2) {
                tapViewY = KScaleHeight(86)+K_NaviHeight+KScaleHeight(35)+(KScaleHeight(33+15)*i);
            }else{
                tapViewY = KScaleHeight(86)+K_NaviHeight+KScaleHeight(35)+KScaleHeight(20)+(KScaleHeight(33+15)*i);
            }
            tapView.frame =  CGRectMake(K_Padding_Home_LeftPadding, tapViewY, KScreenWidth-K_Padding_Home_LeftPadding*2, KScaleHeight(33));
            tapView.textString = self.tipStringArr[i];
            [self.contentScroll addSubview:tapView];
            
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
        _headerView = [AppointmentHeaderView new];
//        _headerView.titleString = @"等待回复";
        _headerView.titleString = self.appointmentModel.status_msg;
        [self.contentScroll addSubview:_headerView];
        _headerView.showType = AppointmentHeaderViewShowTypeEditting;
        __weak typeof(self) weakSelf = self;
        _headerView.operationBlock = ^(AppointmentHeaderViewOperationType operationType) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (operationType == AppointmentHeaderViewOperationTypeEdit) {
                MKMeetingViewController *meetingVC = [MKMeetingViewController new];
                meetingVC.operationType = MeetingOperationTypeEdit;
                meetingVC.appointmentModel = strongSelf.appointmentModel;
                [strongSelf.navigationController pushViewController:meetingVC animated:YES];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确认删除申请？" preferredStyle:UIAlertControllerStyleAlert];
                [strongSelf presentViewController:alert animated:YES completion:nil];
                __weak typeof(self) weakSelf = strongSelf;
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    [strongSelf deleteApplyMeeting];
                }];
                UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style :UIAlertActionStyleDefault handler:nil];
                [alert addAction:cancleAction];
                [alert addAction:sureAction];
            }
        };
    }
    return _headerView;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.contentScroll.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    self.headerView.frame = CGRectMake(0, 0, KScreenWidth, KScaleHeight(86)+K_NaviHeight);
}

#pragma mark - UITableViewDataSource
#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppointmentTeacherReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppointmentTeacherReplyCell" forIndexPath:indexPath];
    AppoinementReplyModel *replyModel = self.applyList[indexPath.row];
    [cell cellRefreshDataWithAppoinementReplyModel:replyModel];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.applyList.count;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppoinementReplyModel *replyModel = self.applyList[indexPath.row];
    return replyModel.rowHeight;
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
    if (self.applyList.count >0) {
        titleLab.text = @"回复";
    }else{
        titleLab.text = @"暂无回复";
    }
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

#pragma mark --  删除申请
-(void)deleteApplyMeeting
{
    [MBHUDManager showLoading];
    [MakeMeetingManager callBackDeleteMeetingRequestWithParameteApply_id:self.appointmentModel.applyID withCompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message) {
        [MBHUDManager hideAlert];
        if (isSuccess) {
            [MBHUDManager showBriefAlert:@"删除预约相谈成功"];
            [[NSNotificationCenter defaultCenter]postNotificationName:kMKApplyMeetingListRefreshNotifcationKey object:nil];
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

@end
