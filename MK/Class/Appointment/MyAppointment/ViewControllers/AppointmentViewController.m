//
//  AppointmentViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/11.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "AppointmentViewController.h"
#import "AppointmentChildViewController.h"
//View
#import "TitleScrollView.h"
#import "HomeContentScrollView.h"


@interface AppointmentViewController ()<TitleScrollViewDelegate,HomeContentScrollViewDelegate>
@property (nonatomic, strong) NSArray *titleArr;//标题数组
@property (nonatomic, strong) NSArray *childVCs;//视图数组
@property (nonatomic, strong) UIView *topView;//顶部View
@property (nonatomic, strong) TitleScrollView *titleView;//标题scroll
@property (nonatomic, strong) HomeContentScrollView *contentScroll;//内容scroll
@end

@implementation AppointmentViewController
#pragma mark --- instancetype method
-(instancetype)init
{
    if (self = [super init]) {
        self.titleArr = @[@"换班",@"请假",@"预约"];
        self.childVCs = @[[AppointmentChildViewController new],[AppointmentChildViewController new],[AppointmentChildViewController new],[AppointmentChildViewController new]];
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
    
    [self.contentScroll AddChildViewWithTitleArr:self.childVCs.mutableCopy andRootViewController:self];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
