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
}
-(void)startRequestWithHUDShow:(BOOL )hudShow
{
    
    [HomePageManager callBackHomePageCouurseCategoryDataWithHUDShow:YES andCompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message, NSArray<HomeCourseCategoryModel *> * _Nonnull resultList, NSMutableArray<NSString *> * _Nonnull titleArr) {
        if (isSuccess) {
            self.courseCategoryList = resultList;
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
        }
    }];
}

-(void)laoutTopView
{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleHeight(91)+KScaleHeight(20))];
    [self.view addSubview:_topView];
    _titleView = [[TitleScrollView alloc]initWithFrame:CGRectMake(0, _topView.height-KScaleWidth(36+20), _topView.width, KScaleWidth(36))];
    _titleView.delegate = self;
    [_topView addSubview:_titleView];
}

#pragma mark --  lazy
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
    [self.contentScroll scrollToIndex:index];
}
#pragma mark --  contentScroll-delegate
-(void)homeContentScrollViewScrollToIndex:(NSInteger )index
{
    [self.titleView titleScrollViewScrollToIndex:index];
}
@end
