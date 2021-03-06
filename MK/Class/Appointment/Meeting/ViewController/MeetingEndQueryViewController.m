//
//  MeetingEndQueryViewController.m
//  MK
//
//  Created by 周洋 on 2019/4/1.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MeetingEndQueryViewController.h"
//View
#import "AppointmentHeaderView.h"
#import "AppointmentTapView.h"
#import "AppointmentTeacherReplyCell.h"
#import "AppointmentListModel.h"
#import "AppoinementReplyModel.h"

#import "AppointmentManager.h"


@interface MeetingEndQueryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MKBaseScrollView *contentScroll;
@property (nonatomic, strong) AppointmentHeaderView *headerView;
@property (nonatomic, strong) MKBaseTableView *contentTable;
@property (nonatomic, strong) NSMutableArray *tapViewArr;
@property (nonatomic, strong) NSArray *tipStringArr;
@property (nonatomic, strong) NSArray *applyList;

@end

@implementation MeetingEndQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_YellowColor;
    self.contentScroll.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    self.headerView.frame = CGRectMake(0, 0, KScreenWidth, KScaleHeight(86)+K_NaviHeight);
    [self reloadData];
    [self startRequest];
}

-(void)startRequest
{
    //得到回复列表
    [AppointmentManager callBackAllApplyAppointmentReplyListWithParameteApply_type:AppointmentDisplayTypeMeeting apply_id:self.appointmentModel.applyID completionBlock:^(BOOL isSuccess, NSArray<AppoinementReplyModel *> * _Nonnull applyList, NSString * _Nonnull message) {
        if (isSuccess) {
            self.applyList = applyList;
            [self.contentTable reloadData];
        }
    }];
}

-(void)reloadData
{
    AppointmentTapView *typeTapView = self.tapViewArr[0];
    typeTapView.textString = self.appointmentModel.type;
    AppointmentTapView *teacherTapView = self.tapViewArr[1];
    teacherTapView.textString = self.appointmentModel.staff_name;
    AppointmentTapView *timeTapView = self.tapViewArr[2];
    timeTapView.textString = [NSString timeTransformWithDate:self.appointmentModel.selected_time WithFormModel:@"YY-MM-dd HH:mm:ss" toModel:@"YY年MM月dd日 HH:mm"];
    
    AppointmentTapView *addressTapView = self.tapViewArr[3];
    NSString *addressString = self.appointmentModel.address;
    CGSize addressSize = [addressString getStrSizeWithSize:CGSizeMake(KScreenWidth-K_Padding_Home_LeftPadding*2, KScaleHeight(33)) font:MKFont(13)];
    CGFloat addressHeight = KScaleHeight(33);
    if (addressSize.height +10 > KScaleHeight(33)) {
        addressHeight = addressSize.height +16;
        addressTapView.height = addressHeight;
    }
    addressTapView.textString = self.appointmentModel.address;
}

-(NSArray *)tipStringArr
{
    if (!_tipStringArr) {
        _tipStringArr = @[@"",@"",@"",@""];
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

-(MKBaseScrollView *)contentScroll
{
    if (!_contentScroll) {
        _contentScroll = [MKBaseScrollView new];
        [self.view addSubview:_contentScroll];
        _contentScroll.backgroundColor = K_BG_YellowColor;
        //
        for (int i=0; i < self.tipStringArr.count; i++) {
            AppointmentTapView *tapView = [AppointmentTapView new];
            [self.contentScroll addSubview:tapView];
            [self.tapViewArr addObject:tapView];
            CGFloat tapViewY = 0;
            tapViewY = KScaleHeight(86)+K_NaviHeight+KScaleHeight(35)+(KScaleHeight(33+15)*i);
            tapView.normalColor = K_Text_YellowColor;
            tapView.frame =  CGRectMake(K_Padding_Home_LeftPadding, tapViewY, KScreenWidth-K_Padding_Home_LeftPadding*2, KScaleHeight(33));
            tapView.textString = self.tipStringArr[i];
            
            
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
//        _headerView.titleString = @"预约查询";
        _headerView.titleString = self.appointmentModel.status_msg;
        [self.contentScroll addSubview:_headerView];
    }
    return _headerView;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

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
