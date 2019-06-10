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

#import "AppointmentListModel.h"

@interface MeetingQueryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MKBaseScrollView *contentScroll;
@property (nonatomic, strong) AppointmentHeaderView *headerView;
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) NSArray *tipStringArr;
@end

@implementation MeetingQueryViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_YellowColor;
    [self startRequest];
}

-(void)startRequest
{
    [AppointmentManager callBackAllApplyReplyInformationWithParameteApply_type:self.showType apply_id:self.appointmentModel.applyID completionBlock:^(BOOL isSuccess, NSArray<AppointmentListModel *> * _Nonnull ongoingApplyList, NSArray<AppointmentListModel *> * _Nonnull completeApplyList, NSString * _Nonnull message) {
        if (isSuccess) {
            
        }
    }];
}

-(NSArray *)tipStringArr
{
    if (!_tipStringArr) {
        _tipStringArr = @[@"心理咨询",@"大学院美术 施晋昊",@"2019年 2月 4日 14:00",@"2019年 2月 4日 14:00",@"2019年 2月 4日 14:00"];
    }
    return _tipStringArr;
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
        _headerView.titleString = @"等待回复";
        [self.contentScroll addSubview:_headerView];
        _headerView.showType = AppointmentHeaderViewShowTypeEditting;
        __weak typeof(self) weakSelf = self;
        _headerView.operationBlock = ^(AppointmentHeaderViewOperationType operationType) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (operationType == AppointmentHeaderViewOperationTypeEdit) {
                MKMeetingViewController *meetingVC = [MKMeetingViewController new];
                meetingVC.operationType = MeetingOperationTypeEdit;
                [strongSelf.navigationController pushViewController:meetingVC animated:YES];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认取消申请" preferredStyle:UIAlertControllerStyleAlert];
                [strongSelf presentViewController:alert animated:YES completion:nil];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
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
