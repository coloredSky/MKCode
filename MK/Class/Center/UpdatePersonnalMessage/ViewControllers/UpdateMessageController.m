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
#import "LagAbilityController.h"
#import "JapanDateVController.h"
#import "ValSchController.h"
//view
#import "TitleScrollView.h"
#import "HomeContentScrollView.h"
//manager
#import <SDWebImage/UIButton+WebCache.h>
#import "GetPersonnalInfoManager.h"
//model
#import "PersonModel.h"


@interface UpdateMessageController ()<TitleScrollViewDelegate,HomeContentScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *headerIma;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLab;
@property (weak, nonatomic) IBOutlet UILabel *emailLab;

@property (nonatomic, strong) TitleScrollView *titleView;//标题scroll
@property (nonatomic, strong) HomeContentScrollView *contentScroll;//内容scroll
@property (nonatomic, weak)IBOutlet UIView *midView;
@property (nonatomic, strong) NSArray *titleArr;//标题数组
@property (nonatomic, strong) NSArray *childVCs;//视图数组

@property(nonatomic,strong)PersonModel * model;
@end

@implementation UpdateMessageController

#pragma mark --- instancetype method
-(instancetype)init
{
    if (self = [super init]) {
        self.titleArr = @[@"基本信息",@"语言学校",@"外语能力",@"赴日日期",@"志愿学校"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatUICompoents];
    [self startRequest];
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
        _titleView = [[TitleScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40) withItemPadding:34];
        _titleView.delegate = self;
        _titleView.showType =TitleScrollViewShowUpdatePersonInfor;
        [_titleView reloadDataWithTitleArr:self.titleArr.mutableCopy];
    }
    return _titleView; 
}

-(HomeContentScrollView *)contentScroll
{
    if (!_contentScroll) {
        _contentScroll = [[HomeContentScrollView alloc]initWithFrame:CGRectMake(0, 200+K_NaviHeight, KScreenWidth, KScreenHeight-(190+K_NaviHeight))];
        _contentScroll.delegate = self;
//    [_contentScroll AddChildViewWithTitleArr:self.childVCs.mutableCopy andRootViewController:self];
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


#pragma mark -request
-(void)startRequest
{
    [MBHUDManager showLoading ];
    [GetPersonnalInfoManager callBackGetPerMessageWithHudShow:YES CompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message, PersonModel * _Nonnull model) {
        [MBHUDManager hideAlert];
        if (isSuccess  ==YES)
        {
            self.model =model;
            [self.headerIma sd_setImageWithURL:[NSURL URLWithString:model.userInfo.avatar] forState:UIControlStateNormal placeholderImage:K_MKPlaceholderImage1_1];
            self.nickNameLab.text = model.userInfo.nickname;
            self.emailLab.text = model.userInfo.email;
            [self setVCDataSource];
        }
        else
        {
            [MBHUDManager showBriefAlert:message];
        }
    }];
}


-(void)setVCDataSource
{
    BasicInfoController * basicInfoVC =[BasicInfoController new];
    LagAndSchController * languageScrollVC =[LagAndSchController new];
    LagAbilityController *  languageVC =[LagAbilityController new];
    JapanDateVController * jpArriveDateVC =[JapanDateVController new];
    ValSchController * universityVC =[ValSchController new];
    
    basicInfoVC.originalModel =self.model;
    languageScrollVC.originalModel =self.model;
    languageVC.originalModel =self.model;
    jpArriveDateVC.originalModel =self.model;
    universityVC.originalModel =self.model ;
    self.childVCs  =@[basicInfoVC,languageScrollVC,languageVC,jpArriveDateVC,universityVC];
    [self.contentScroll AddChildViewWithTitleArr:self.childVCs.mutableCopy andRootViewController:self];
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
