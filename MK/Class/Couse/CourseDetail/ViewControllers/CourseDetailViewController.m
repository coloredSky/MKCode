//
//  CourseDetailViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/20.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "CourseDetailViewController.h"
#import <PLVVodSDK/PLVVodSDK.h>
#import "PLVVodSkinPlayerController.h"
//View
#import "CourseDetailTipView.h"
#import "CourseDetailScrollView.h"


@interface CourseDetailViewController ()<CourseDetailScrollViewDelegate,CourseDetailTipViewDelegate>
@property (nullable,nonatomic, strong) UIScrollView *contentScroll;
@property (nonatomic, strong) CourseDetailTipView *courseTipView;
@property (nonatomic, strong) CourseDetailScrollView *detailScroll;
@property (nonatomic, strong) UIView *placeholderView;
@property (nonatomic, strong) PLVVodSkinPlayerController *player;
@end

@implementation CourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Request
    [self startRequest];
//    [self.detailScroll CourseDetailScrollViewReloadData];
}

-(void)startRequest
{
    [CourseDetailManager callBackCourseDetailRequestWithHudShow:YES courseID:self.course_id andCompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message, MKCourseDetailModel * _Nonnull courseDetailModel) {
        if (isSuccess) {
            [self.detailScroll courseDetailScrollViewReloadDataWithMKCourseDetailModel:courseDetailModel];
        }else{
            [MBHUDManager showBriefAlert:message];
        }
    }];
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
        
        _placeholderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleWidth(278))];
        [_contentScroll addSubview:_placeholderView];
        
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
        
        [self setUpVideo];
    }
    return _contentScroll;
}

-(void)setUpVideo
{
    // 初始化播放器
    PLVVodSkinPlayerController *player = [[PLVVodSkinPlayerController alloc] initWithNibName:nil bundle:nil];
    [player addPlayerOnPlaceholderView:self.placeholderView rootViewController:self];
    player.rememberLastPosition = YES;
    player.enableBackgroundPlayback = YES;
    player.reachEndHandler = ^(PLVVodPlayerViewController *player) {
        NSLog(@"%@ finish handler.", player.video.vid);
    };
    self.player = player;
    
    // 有网情况下，也可以调用此接口，只要存在本地视频，都会优先播放本地视频
    __weak typeof(self) weakSelf = self;
    [PLVVodVideo requestVideoWithVid:@"d0b728f5b9977070874be417f3a88e66_d" completion:^(PLVVodVideo *video, NSError *error) {
//        if (!video.available) return;
        weakSelf.player.video = video;
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.title = video.title;
        });
    }];
 
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
#pragma mark --  课程点击
-(void)courseDidSelectedWithIndexPath:(NSIndexPath *)indexPath
{
    [self loginAlterViewShow];
}

@end
