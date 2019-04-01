//
//  ChangeClassViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/29.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "ChangeClassViewController.h"
//View
#import "AppointmentHeaderView.h"
#import "AppointmentTapView.h"


@interface ChangeClassViewController ()
@property (nonatomic, strong) UIScrollView *contentScroll;
@property (nonatomic, strong) AppointmentHeaderView *headerView;

@end

@implementation ChangeClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_YellowColor;
}

-(UIScrollView *)contentScroll
{
    if (!_contentScroll) {
        _contentScroll = [UIScrollView new];
        [self.view addSubview:_contentScroll];
        _contentScroll.backgroundColor = K_BG_YellowColor;
    
        for (int i=0; i < 5; i++) {
            AppointmentTapView *tapView = [[AppointmentTapView alloc]initWithFrame:CGRectMake(0, self.headerView.bottomY+KScaleHeight(35)+(KScaleHeight(33+15)*i), self.contentScroll.width, KScaleHeight(33))];
            [self.contentScroll addSubview:tapView];
        }
    }
    return  _contentScroll;
}
-(AppointmentHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [AppointmentHeaderView new];
        _headerView.titleString = @"新建预约";
        [self.contentScroll addSubview:_headerView];
    }
    return _headerView;
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.contentScroll.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    self.headerView.frame = CGRectMake(0, 0, KScreenWidth, KScaleHeight(86)+K_NaviHeight);
}
@end
