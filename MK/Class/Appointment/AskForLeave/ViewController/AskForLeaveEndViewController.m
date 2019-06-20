//
//  AskForLeaveEndViewController.m
//  MK
//
//  Created by 周洋 on 2019/4/3.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "AskForLeaveEndViewController.h"
//View
#import "AppointmentHeaderView.h"
#import "AppointmentTapView.h"
#import "AppointmentTeacherReplyCell.h"
#import "AppointmentListModel.h"
#import "AppoinementReplyModel.h"

#import "AppointmentManager.h"

@interface AskForLeaveEndViewController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MKBaseScrollView *contentScroll;
@property (nonatomic, strong) AppointmentHeaderView *headerView;
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) NSMutableArray *tapViewArr;
@property (nonatomic, strong) UITextView *reasonTextView;
@property (nonatomic, strong) NSArray *tipStringArr;
@property (nonatomic, strong) NSArray *applyList;
@end

@implementation AskForLeaveEndViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_YellowColor;
    
    [self creatSubVuew];
    [self reloadData];
    [self startRequest];
}

-(void)startRequest
{
    //得到回复列表
    [AppointmentManager callBackAllApplyAppointmentReplyListWithParameteApply_type:AppointmentDisplayTypeAskForLeave apply_id:self.appointmentModel.applyID completionBlock:^(BOOL isSuccess, NSArray<AppoinementReplyModel *> * _Nonnull applyList, NSString * _Nonnull message) {
        if (isSuccess) {
            self.applyList = applyList;
            [self.contentTable reloadData];
        }
    }];
}

-(void)reloadData
{
    AppointmentTapView *changeClassTapView = self.tapViewArr[0];
    changeClassTapView.textString = self.appointmentModel.class_name;
    AppointmentTapView *originalTapView = self.tapViewArr[1];
    originalTapView.textString = self.appointmentModel.lesson_name;
    self.reasonTextView.text = self.appointmentModel.reason;
}

-(void)creatSubVuew
{
    [self.view addSubview:self.contentScroll];
    [self.contentScroll addSubview:self.headerView];
}

#pragma mark --  lazy

-(NSArray *)tipStringArr
{
    if (!_tipStringArr) {
        _tipStringArr = @[@"",@""];
    }
    return _tipStringArr;
}

-(NSMutableArray *)tapViewArr
{
    if (!_tapViewArr) {
        _tapViewArr = [NSMutableArray arrayWithCapacity:2];
    }
    return _tapViewArr;
}

-(UITextView *)reasonTextView
{
    if (!_reasonTextView) {
        _reasonTextView = [UITextView new];
        [self.contentScroll addSubview:_reasonTextView];
        _reasonTextView.backgroundColor = K_BG_blackColor;
        _reasonTextView.layer.masksToBounds = YES;
        _reasonTextView.layer.cornerRadius = KScaleWidth(8);
        _reasonTextView.textColor = K_Text_WhiteColor;
        _reasonTextView.font = K_Font_Text_Normal;
        _reasonTextView.editable = NO;
    }
    return _reasonTextView;
}

-(MKBaseScrollView *)contentScroll
{
    if (!_contentScroll) {
        _contentScroll = [[MKBaseScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        _contentScroll.backgroundColor = K_BG_YellowColor;
        //请假课程标题
        UILabel *courseTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(K_Padding_Home_LeftPadding, self.headerView.bottomY+KScaleHeight(30), 200, KScaleHeight(20))];
        [self.contentScroll addSubview:courseTitleLab];
        [courseTitleLab setFont:K_Font_Text_Normal textColor:K_Text_grayColor withBackGroundColor:nil];
        courseTitleLab.text = @"请假课程";
        
        for (int i=0; i < self.tipStringArr.count; i++) {
            AppointmentTapView *tapView = [AppointmentTapView new];
            [self.tapViewArr addObject:tapView];
            CGFloat tapViewY = tapViewY = courseTitleLab.bottomY+ KScaleHeight(13)+(KScaleHeight(33+15)*i);
            tapView.normalColor = K_Text_YellowColor;
            tapView.frame =  CGRectMake(K_Padding_Home_LeftPadding, tapViewY, KScreenWidth-K_Padding_Home_LeftPadding*2, KScaleHeight(33));
            tapView.textString = self.tipStringArr[i];
            [self.contentScroll addSubview:tapView];
        }
        //理由
        UILabel *reasonTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(courseTitleLab.leftX, courseTitleLab.bottomY+KScaleHeight(114), 200, KScaleHeight(20))];
        [self.contentScroll addSubview:reasonTitleLab];
        [reasonTitleLab setFont:K_Font_Text_Normal textColor:K_Text_grayColor withBackGroundColor:nil];
        reasonTitleLab.text = @"请假理由";
        //理由
        CGSize size = [self.appointmentModel.reason getStrSizeWithSize:CGSizeMake(_contentScroll.width-K_Padding_Home_LeftPadding*2, 300) font:K_Font_Text_Normal];
        CGFloat height = 33;
        if (size.height+20 > 33) {
            height = size.height+20;
        }
        if (size.height > 80) {
            height = 80;
        }
        self.reasonTextView.frame = CGRectMake(K_Padding_Home_LeftPadding, reasonTitleLab.bottomY+ KScaleHeight(13), KScreenWidth-K_Padding_Home_LeftPadding*2, height);
        //底部消息列表
        _contentTable = [[MKBaseTableView alloc]initWithFrame:CGRectMake(0, self.reasonTextView.bottomY+KScaleHeight(35), KScreenWidth, KScreenHeight-self.reasonTextView.bottomY-KScaleHeight(35)) style:UITableViewStyleGrouped];
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
        [self.contentScroll addSubview:_contentTable];
        _contentTable.backgroundColor = K_BG_WhiteColor;
        _contentTable.sectionHeaderHeight = 0.001;
        [_contentTable registerNib:[UINib nibWithNibName:@"AppointmentTeacherReplyCell" bundle:nil] forCellReuseIdentifier:@"AppointmentTeacherReplyCell"];
    }
    return  _contentScroll;
}
-(AppointmentHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[AppointmentHeaderView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleHeight(86)+K_NaviHeight)];
        _headerView.titleString = @"等待回复";
        [self.contentScroll addSubview:_headerView];
    }
    return _headerView;
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

@end
