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
//manager
#import "HomePageManager.h"
#import "VersionUpdateManager.h"
//model
#import "HomeCourseCategoryModel.h"

@interface HomePageViewController ()<TitleScrollViewDelegate,HomeContentScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *titleArr;//标题数组
@property (nonatomic, strong) NSMutableArray <UIViewController *>*childVCs;//视图数组
@property (nonatomic, strong) UIView *topView;//顶部View
@property (nonatomic, strong) TitleScrollView *titleView;//标题scroll
@property (nonatomic, strong) HomeContentScrollView *contentScroll;//内容scroll
//数据
@property (nonatomic, strong) NSArray <HomeCourseCategoryModel *>*courseCategoryList;//课程类型list

//更新
@property (nonatomic, strong) VersionUpdateManager *updateManager;
@end

@implementation HomePageViewController

#pragma mark --- instancetype method
-(instancetype)init
{
    if (self = [super init]) {
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
    [self startRequestWithHUDShow:YES];
    [self.updateManager checkUpXHBorrowAppVersionUpdateWhenFoundNewsVersion];
}
-(void)startRequestWithHUDShow:(BOOL )hudShow
{
    [MBHUDManager showLoading];
    [HomePageManager callBackHomePageCouurseListDataWithHUDShow:NO categoryID:@"100" pageOffset:1 pageLimit:1 andCompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message,NSArray<HomeCourseCategoryModel *> * _Nonnull courseCategoryList, NSArray<MKBannerModel *> * _Nonnull bannerList, NSArray<HomePublicCourseModel *> * _Nonnull publicCourseList, NSArray<MKCourseListModel *> * _Nonnull recommentCourseList) {
        [MBHUDManager hideAlert];
        if (courseCategoryList == nil || courseCategoryList.count == 0) {
            self.placeholderView.hidden = NO;
            self.placeholderView.displayType = MKPlaceWorderViewDisplayTypeNoNetworking;
        }else{
            self.placeholderView.hidden = YES;
        }
        if (isSuccess) {
            self.courseCategoryList = courseCategoryList;
            NSMutableArray *titleArr = [NSMutableArray arrayWithCapacity:courseCategoryList.count];
            for (HomeCourseCategoryModel *model in courseCategoryList) {
                [titleArr addObject:model.categoryName];
            }
            self.titleArr = titleArr;
            [self.titleView reloadDataWithTitleArr:self.titleArr];
            if (self.courseCategoryList.count > 0) {
                for (int i=0; i < self.courseCategoryList.count; i++) {
                    HomeCourseCategoryModel *model = self.courseCategoryList[i];
                    if (i == 0) {
                        HomeRecommendViewController *recommendVC =  [HomeRecommendViewController new];
                        recommendVC.categoryID = model.categoryID;
                        [self.childVCs addObject:recommendVC];
                    }else{
                        HomeCommonViewController *commonVC = [HomeCommonViewController new];
                        commonVC.categoryID = model.categoryID;
                        [self.childVCs addObject:commonVC];
                    }
                }
            }
            [self.contentScroll AddChildViewWithTitleArr:self.childVCs andRootViewController:self];
        }else{
            [MBHUDManager showBriefAlert:@"数据请求失败!"];
        }
    }];
}

-(void)laoutTopView
{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleHeight(91)+KScaleHeight(20))];
    _topView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:.1];
    [self.view addSubview:_topView];
    _titleView = [[TitleScrollView alloc]initWithFrame:CGRectMake(0, _topView.height-KScaleWidth(36+20), _topView.width, KScaleWidth(36))];
    _titleView.delegate = self;
    [_topView addSubview:_titleView];
}

#pragma mark --  lazy
-(VersionUpdateManager *)updateManager
{
    if (!_updateManager) {
        _updateManager = [VersionUpdateManager new];
    }
    return _updateManager;
}

-(NSMutableArray <UIViewController *>*)childVCs
{
    if (!_childVCs) {
        _childVCs = [NSMutableArray array];
    }
    return _childVCs;
}

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
    [self childVCRefreshDataWithIndex:index];
    [self.contentScroll scrollToIndex:index];
}
#pragma mark --  contentScroll-delegate
-(void)homeContentScrollViewScrollToIndex:(NSInteger )index
{
    [self childVCRefreshDataWithIndex:index];
    [self.titleView titleScrollViewScrollToIndex:index];
}

-(void)childVCRefreshDataWithIndex:(NSInteger )index
{
    if (index == 0) {
        HomeRecommendViewController *recommendVC = (HomeRecommendViewController *)self.childVCs[index];
        [recommendVC homeRecommendfreshCourseListData];
    }else{
        HomeCommonViewController *commonVC = (HomeCommonViewController *)self.childVCs[index];
        [commonVC homeCommonrefreshCourseListDataWithTitle:self.titleArr[index]];
    }
}

-(void)placeholderViewClickWithDisplayType:(MKPlaceWorderViewDisplayType )placeholderDisplayType
{
    [self startRequestWithHUDShow:YES];
}
@end
