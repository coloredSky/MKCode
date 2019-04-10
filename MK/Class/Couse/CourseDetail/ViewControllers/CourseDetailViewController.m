//
//  CourseDetailViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/20.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "CourseDetailViewController.h"
#import "CourseDetailTipView.h"
#import "CourseDetailScrollView.h"

@interface CourseDetailViewController ()<CourseDetailScrollViewDelegate,CourseDetailTipViewDelegate>
@property (nullable,nonatomic, strong) UIScrollView *contentScroll;
@property (nonatomic, strong) CourseDetailTipView *courseTipView;
@property (nonatomic, strong) CourseDetailScrollView *detailScroll;
@end

@implementation CourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.detailScroll CourseDetailScrollViewReloadData];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.contentScroll.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    self.courseTipView.frame = CGRectMake(0, KScaleWidth(278), KScreenWidth, 60);
    self.detailScroll.frame = CGRectMake(0, self.courseTipView.bottomY, KScreenWidth, KScreenHeight-self.courseTipView.bottomY);
}
#pragma mark --  lazy
-(UIScrollView *)contentScroll
{
    if (!_contentScroll) {
        _contentScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        if (@available(ios 11.0,*)) {
            _contentScroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [self.view addSubview:_contentScroll];
        
        UIImageView *playView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleWidth(278))];
        playView.image = [UIImage imageNamed:@"playIma"];
        [_contentScroll addSubview:playView];
        playView.backgroundColor = K_BG_YellowColor;
        
        UIImageView *bgIma = [[UIImageView alloc]initWithFrame:CGRectMake(playView.leftX, playView.topY, playView.width, playView.height)];
        [_contentScroll addSubview:bgIma];
        bgIma.backgroundColor = [UIColor colorWithWhite:.2 alpha:.4];
        
        UIImageView *playIcon = [[UIImageView alloc]initWithFrame:CGRectMake(playView.centerX-KScaleWidth(50), playView.centerY-KScaleWidth(30), KScaleWidth(100), KScaleWidth(100))];
        [_contentScroll addSubview:playIcon];
        playIcon.image = KImageNamed(@"courseDetail_playIcon");
        
    }
    return _contentScroll;
}

-(CourseDetailTipView *)courseTipView
{
    if (!_courseTipView) {
        _courseTipView = [[CourseDetailTipView alloc]initWithFrame:CGRectMake(0, KScaleWidth(278), KScreenWidth, 60)];
        _courseTipView.delegate = self;
        [self.contentScroll addSubview:_courseTipView];
    }
    return _courseTipView;
}

-(CourseDetailScrollView *)detailScroll
{
    if (!_detailScroll) {
        _detailScroll = [[CourseDetailScrollView alloc]initWithFrame:CGRectMake(0, self.courseTipView.bottomY, KScreenWidth, KScreenHeight-self.courseTipView.bottomY)];
        _detailScroll.delegate = self;
        _detailScroll.courseType = self.courseType;
//        NSInteger type = arc4random()%2;
//        if (type == 0) {
//            _detailScroll.courseType = CourseSituationTypeOffline;
//        }else{
//            _detailScroll.courseType = CourseSituationTypeOnline;
//        }
        [self.contentScroll addSubview:_detailScroll];
    }
    return _detailScroll;
}

-(void)CourseDetailScrollViewScrollOffsetY:(float )offsetY
{
//    if (offsetY >= self.courseTipView.topY) {
//        [self.contentScroll setContentOffset:CGPointMake(0, self.courseTipView.topY)];
//    }else{
//        [self.contentScroll setContentOffset:CGPointMake(0, offsetY)];
//    }
}
#pragma mark --  tip标头点击
-(void)CourseDetailTipViewClickBtnWithSelectedIndex:(NSInteger )index
{
    [self.detailScroll scrollToIndex:index];
}
#pragma mark --  内容scroll 滑动
-(void)CourseDetailScrollViewScrollToIndex:(NSInteger)index
{
    [self.courseTipView courseButtonSeletedWithIndex:index];
}

@end
