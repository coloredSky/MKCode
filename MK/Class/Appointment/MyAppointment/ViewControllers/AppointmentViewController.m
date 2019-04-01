//
//  AppointmentViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/11.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "AppointmentViewController.h"
#import "AppointmentChildViewController.h"
#import "MessageViewController.h"
#import "AskForLeaveViewController.h"
#import "ChangeClassViewController.h"
#import "MKMeetingViewController.h"
//View
#import "TitleScrollView.h"
#import "HomeContentScrollView.h"
#import "BMPopView.h"
#import "AppointmentPopView.h"

@interface AppointmentViewController ()<TitleScrollViewDelegate,HomeContentScrollViewDelegate,BMPopViewDelegate,AppointmentPopViewDelegate>
@property (nonatomic, strong) NSArray *titleArr;//标题数组
@property (nonatomic, strong) NSMutableArray *childVCs;//视图数组
@property (nonatomic, strong) UIView *topView;//顶部View
@property (nonatomic, strong) TitleScrollView *titleView;//标题scroll
@property (nonatomic, strong) HomeContentScrollView *contentScroll;//内容scroll
@property (nonatomic, strong) UIButton *appointmentBtn;//预约按钮
@end

@implementation AppointmentViewController
#pragma mark --- instancetype method
-(instancetype)init
{
    if (self = [super init]) {
        self.titleArr = @[@"换班",@"请假",@"预约"];
        for (int i=0; i<3; i++) {
            AppointmentChildViewController *childVC = [AppointmentChildViewController new];
            childVC.dispayType = i;
            [self.childVCs addObject:childVC];
        }
    }
    return self;
}

#pragma mark --- destruct method
-(void)dealloc
{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_deepGrayColor;
    //navView
    [self laoutTopView];
    //加载子视图
    [self.contentScroll AddChildViewWithTitleArr:self.childVCs andRootViewController:self];
    [self.appointmentBtn addTarget:self action:@selector(appointmentBtnTarget:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)laoutTopView
{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, K_NaviHeight+KScaleHeight(20))];
    [self.view addSubview:_topView];
    _topView.backgroundColor = K_BG_WhiteColor;
    _titleView = [[TitleScrollView alloc]initWithFrame:CGRectMake(0, _topView.height-KScaleHeight(35+10), _topView.width, KScaleHeight(35)) withItemPadding:37];
    _titleView.delegate = self;
    [_topView addSubview:_titleView];
    [_titleView reloadDataWithTitleArr:self.titleArr.mutableCopy];
    
    UIImageView *lineIma = [[UIImageView alloc]initWithFrame:CGRectMake(K_Padding_Home_LeftPadding, self.topView.height-K_Line_lineWidth, self.topView.width-K_Padding_Home_LeftPadding*2, K_Line_lineWidth)];
    [self.topView addSubview:lineIma];
    lineIma.backgroundColor = K_Line_lineColor;
    
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.topView addSubview:messageBtn];
    messageBtn.frame = CGRectMake(self.topView.width-K_Padding_Home_LeftPadding-22, self.topView.height-K_Padding_Home_LeftPadding-22, 22, 22);
    [messageBtn setImage:KImageNamed(@"appointment_message") forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(messageTarget:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark --  lazy
-(HomeContentScrollView *)contentScroll
{
    if (!_contentScroll) {
        _contentScroll = [[HomeContentScrollView alloc]initWithFrame:CGRectMake(0, self.topView.bottomY, self.view.width, KScreenHeight-self.topView.height-K_TabbarHeight)];
        _contentScroll.delegate = self;
        [self.view addSubview:_contentScroll];
    }
    return _contentScroll;
}
-(UIButton *)appointmentBtn
{
    if (!_appointmentBtn) {
        
        _appointmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_appointmentBtn];
        [_appointmentBtn setImage:KImageNamed(@"appointment_btn") forState:UIControlStateNormal];
        _appointmentBtn.frame = CGRectMake(KScreenWidth-KScaleWidth(12)-KScaleWidth(66), KScreenHeight-K_TabbarHeight-KScaleHeight(18)-KScaleWidth(66), KScaleWidth(66), KScaleWidth(66));
    }
    return _appointmentBtn;
}
-(NSMutableArray *)childVCs
{
    if (!_childVCs) {
        _childVCs = [NSMutableArray arrayWithCapacity:3];
    }
    return _childVCs;
}

#pragma mark --  EVENT
#pragma mark --  titleScroll-Delegate
-(void)titleScrollView:(TitleScrollView *)titleView didSelectedIndex:(NSInteger)index
{
    [self.contentScroll scrollToIndex:index];
}
#pragma mark --  contentScroll-delegate
-(void)homeContentScrollViewScrollToIndex:(NSInteger )index
{
    [self.titleView titleScrollViewScrollToIndex:index];
}
#pragma mark --  预约按钮
-(void)appointmentBtnTarget:(UIButton *)sender
{
    AppointmentPopView *appointmentView = [[AppointmentPopView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    appointmentView.delegate = self;
    BMPopView *popToll = [BMPopView shareInstance];
    popToll.canDisMiss = YES;
    popToll.delegate = self;
    [popToll showWithContentView:appointmentView withAnimation:BMPopViewAnimationNone];
}

#pragma mark --  消息中心
-(void)messageTarget:(UIButton *)sender
{
    MessageViewController *messageVC = [MessageViewController new];
    [self.navigationController pushViewController:messageVC animated:YES];
}
#pragma mark --  预约按钮点击
-(void)AppointmentPopViewClickWithAppointmentType:(AppointmentOperationType )appointmentType
{
    [[BMPopView shareInstance] dismiss];
    if (appointmentType == AppointmentOperationTypeCancle) {
        //cancle
    }else if (appointmentType == AppointmentOperationTypeMeeting){
        //预约相谈
        MKMeetingViewController *meetingVC = [MKMeetingViewController new];
        [self.navigationController pushViewController:meetingVC animated:YES];
    }else if (appointmentType == AppointmentOperationTypeAskForLeave){
        //预约请假
        AskForLeaveViewController *askForLeaveVC = [AskForLeaveViewController new];
        [self.navigationController pushViewController:askForLeaveVC animated:YES];
    }else if (appointmentType == AppointmentOperationTypeChangeClass){
        //预约换班
        ChangeClassViewController *classChangeVC = [ChangeClassViewController new];
        [self.navigationController pushViewController:classChangeVC animated:YES];
    }
}
@end
