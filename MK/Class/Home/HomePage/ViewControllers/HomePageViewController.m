//
//  HomePageViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/11.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "HomePageViewController.h"
//VC
#import "HomeRecommendViewController.h"
#import "HomeCommonViewController.h"
//View
#import "TitleScrollView.h"
#import "HomeContentScrollView.h"

@interface HomePageViewController ()<TitleScrollViewDelegate,HomeContentScrollViewDelegate>
@property (nonatomic, strong) NSArray *titleArr;//标题数组
@property (nonatomic, strong) NSArray *childVCs;//视图数组
@property (nonatomic, strong) UIView *topView;//顶部View
@property (nonatomic, strong) TitleScrollView *titleView;//标题scroll
@property (nonatomic, strong) HomeContentScrollView *contentScroll;//内容scroll
@end

@implementation HomePageViewController

#pragma mark --- instancetype method
-(instancetype)init
{
    if (self = [super init]) {
        self.titleArr = @[@"推荐",@"语言",@"学部",@"大学院",@"美术"];
        self.childVCs = @[[HomeRecommendViewController new],[HomeCommonViewController new],[HomeCommonViewController new],[HomeCommonViewController new],[HomeCommonViewController new],[HomeCommonViewController new]];
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
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleHeight(91)+KScaleHeight(20))];
    [self.view addSubview:_topView];
    _titleView = [[TitleScrollView alloc]initWithFrame:CGRectMake(0, _topView.height-KScaleWidth(36+20), _topView.width, KScaleWidth(36))];
    _titleView.delegate = self;
    [_topView addSubview:_titleView];
    [_titleView reloadDataWithTitleArr:self.titleArr.mutableCopy];
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
@end
