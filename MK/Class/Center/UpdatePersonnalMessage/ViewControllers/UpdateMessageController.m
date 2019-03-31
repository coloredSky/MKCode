//
//  UpdateMessageController.m
//  MK
//
//  Created by ginluck on 2019/3/30.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "UpdateMessageController.h"
#import "BasicInfoController.h"
#import "LagAndSchController.h"
#import "PropertyController.h"
#import "LagAbilityController.h"
#import "JapanDateVController.h"
#import "ValSchController.h"
//view
#import "TitleScrollView.h"
#import "HomeContentScrollView.h"

@interface UpdateMessageController ()<TitleScrollViewDelegate,HomeContentScrollViewDelegate>
@property (nonatomic, strong) TitleScrollView *titleView;//标题scroll
@property (nonatomic, strong) HomeContentScrollView *contentScroll;//内容scroll
@property (nonatomic, weak)IBOutlet UIView *midView;
@property (nonatomic, strong) NSArray *titleArr;//标题数组
@property (nonatomic, strong) NSArray *childVCs;//视图数组
@end

@implementation UpdateMessageController

#pragma mark --- instancetype method
-(instancetype)init
{
    if (self = [super init]) {
        self.titleArr = @[@"基本信息",@"语言学校",@"属性",@"外语能力",@"赴日日期",@"志愿学校"];
        self.childVCs = @[[BasicInfoController new],[LagAndSchController new],[PropertyController new],[LagAbilityController new],[JapanDateVController new],[ValSchController new]];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatUICompoents];
}
-(void)creatUICompoents
{
    self.view.backgroundColor =K_BG_WhiteColor;
    [self.midView addSubview:self.titleView];
    [self.view addSubview:self.contentScroll];
}
#pragma mark-lazy
-(TitleScrollView * )titleView
{
    if (!_titleView) {
        _titleView = [[TitleScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
        self.midView.backgroundColor = [UIColor blueColor];
        _titleView.backgroundColor = [UIColor redColor];
        _titleView.delegate = self;
        [_titleView reloadDataWithTitleArr:self.titleArr.mutableCopy];
    }
    return _titleView;
}
-(HomeContentScrollView *)contentScroll
{
    if (!_contentScroll) {
        _contentScroll = [[HomeContentScrollView alloc]initWithFrame:CGRectMake(0, 190+K_NaviHeight, KScreenWidth, KScreenHeight-(190+K_NaviHeight))];
        _contentScroll.delegate = self;
    [_contentScroll AddChildViewWithTitleArr:self.childVCs.mutableCopy andRootViewController:self];
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
