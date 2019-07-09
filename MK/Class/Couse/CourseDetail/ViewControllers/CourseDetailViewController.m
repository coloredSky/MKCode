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
#import "LoginActionController.h"
#import "PLVMarquee.h"
//View
#import "CourseDetailTipView.h"
#import "MKCourseDetailModel.h"
#import "MKOfflineCourseDetail.h"
//model
#import "MKCourseDetailModel.h"
#import "PLVTimer.h"
//manager
#import "MKCalendarsManager.h"



@interface CourseDetailViewController ()<CourseDetailScrollViewDelegate,CourseDetailTipViewDelegate>
@property (nullable,nonatomic, strong) UIScrollView *contentScroll;
@property (nonatomic, strong) CourseDetailTipView *courseTipView;
@property (nonatomic, strong) CourseDetailScrollView *detailScroll;
@property (nonatomic, strong) UIView *placeholderView;
@property (nonatomic, strong) UIImageView *courseIma;
@property (nonatomic, strong) PLVVodSkinPlayerController *player;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) MKCourseDetailModel *onlineCourseDetailModel;
@property (nonatomic, strong) MKOfflineCourseDetail * _Nonnull offlineCourseDetailModel;

/// 播放刷新定时器
@property (nonatomic, strong) PLVTimer *playbackTimer;
@end

@implementation CourseDetailViewController

- (void)dealloc {
    [self.playbackTimer cancel];
    self.playbackTimer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.player pause];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.player.playbackState == PLVVodPlaybackStatePaused) {
        [self.player play];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //Request
    [self startRequest];
    [self addNoti];
//    [self.detailScroll CourseDetailScrollViewReloadData];
}

-(void)addNoti
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginTarget:) name:kMKLoginInNotifcationKey object:nil];
}

-(void)startRequest
{
    if (self.courseType == CourseSituationTypeOnline) {
        [self requestOnlineCourseDetail];
    }else{
        [self requestOfflineCourseDetail];
    }
}

-(void)requestOfflineCourseDetail
{
    [CourseDetailManager callBackOfflineCourseDetailRequestWithCourseID:self.course_id andCompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message, MKOfflineCourseDetail * _Nonnull courseDetailModel) {
        if (isSuccess) {
            [self.detailScroll courseDetailScrollViewReloadDataWithMKCourseDetailModel:nil offlineCourseDetailModel:courseDetailModel];
            self.offlineCourseDetailModel = courseDetailModel;
            [self.courseIma sd_setImageWithURL:[NSURL URLWithString:courseDetailModel.course_img] placeholderImage:nil];
        }else{
            [MBHUDManager showBriefAlert:message];
        }
    }];
}

-(void)requestOnlineCourseDetail
{
    [CourseDetailManager callBackCourseDetailRequestWithHudShow:YES courseID:self.course_id andCompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message, MKCourseDetailModel * _Nonnull courseDetailModel) {
        if (isSuccess) {
            self.onlineCourseDetailModel = courseDetailModel;
            if (self.autoPlay) {
                for (MKLessonModel *lessonModel in courseDetailModel.lessonList) {
                    if ([lessonModel.lessonID integerValue] == [self.lessonID integerValue]) {
                        lessonModel.isSelected = YES;
                        [self setUpVideoWithVideoID:lessonModel.video_id lessonID:lessonModel.lessonID];
                        break;
                    }
                }
            }
            [self.detailScroll courseDetailScrollViewReloadDataWithMKCourseDetailModel:courseDetailModel offlineCourseDetailModel:nil];
            [self.courseIma sd_setImageWithURL:[NSURL URLWithString:courseDetailModel.courseInfoDetail.courseImage] placeholderImage:K_MKPlaceholderImage4_3];
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
        
        _courseIma = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScaleWidth(278))];
        [_contentScroll addSubview:_courseIma];
        _courseIma.image = K_MKPlaceholderImage4_3;
        
        UIImageView *bgIma = [[UIImageView alloc]initWithFrame:CGRectMake(_courseIma.leftX, _courseIma.topY, _courseIma.width, _courseIma.height)];
        [_contentScroll addSubview:bgIma];
        bgIma.backgroundColor = [UIColor colorWithWhite:.2 alpha:.4];
        UIImageView *playIcon = [[UIImageView alloc]initWithFrame:CGRectMake(_courseIma.centerX-KScaleWidth(50), _courseIma.centerY-KScaleWidth(30), KScaleWidth(100), KScaleWidth(100))];
        [_contentScroll addSubview:playIcon];
        playIcon.image = KImageNamed(@"courseDetail_playIcon");
        playIcon.userInteractionEnabled = YES;
        [playIcon addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(videoPlayerTarget:)]];
        if (self.courseType == CourseSituationTypeOffline) {
            playIcon.hidden = YES;
        }
    }
    return _contentScroll;
}

-(UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _placeholderView.width, _placeholderView.height)];
        [self.view addSubview:_maskView];
        _maskView.backgroundColor = [UIColor colorWithWhite:.5 alpha:.5];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(_maskView.centerX-100, _maskView.centerY-20, 200, 40)];
        [_maskView addSubview:label];
        [label setFont:MKFont(20) textColor:K_Text_RedColor withBackGroundColor:nil];
        label.text = @"请购买课程后观看";
        label.textAlignment = NSTextAlignmentCenter;
        _maskView.hidden = YES;
    }
    return _maskView;
}

-(PLVVodSkinPlayerController *)player
{
    if (!_player) {
        // 初始化播放器
        PLVVodSkinPlayerController *player = [[PLVVodSkinPlayerController alloc] initWithNibName:nil bundle:nil];
        player.rememberLastPosition = YES;
        player.enableBackgroundPlayback = NO;
        player.marquee.content = [NSString getAppName];
        player.reachEndHandler = ^(PLVVodPlayerViewController *player) {
        };
//        __weak typeof(self) weakSelf = self;
//        self.playbackTimer = [PLVTimer repeatWithInterval:1 repeatBlock:^{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                __strong typeof(weakSelf) strongSelf = weakSelf;
//                if (player.currentPlaybackTime >= 10) {
//                    [player pause];
//                    strongSelf.maskView.hidden = NO;
//                }
//            });
//        }];
        _player = player;
    }
    return _player;
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
-(void)courseDidSelectedWithIndexPath:(NSIndexPath *)indexPath andLessonModel:(MKLessonModel *)lessonModel
{
    if (lessonModel.video_status) {
        //能够播放
        [self setUpVideoWithVideoID:lessonModel.video_id lessonID:lessonModel.lessonID];
    }else{
        //不能播放，先判断登录状态
        if (![[UserManager shareInstance]isLogin]) {
//            [self loginAlterViewShow];
            [MBHUDManager showBriefAlert:@"您还未登录，请先登录！"];
            LoginActionController *loginVC = [LoginActionController new];
            [self.navigationController pushViewController:loginVC animated:YES];
            return;
        }
        //已经登录，判断是否购买课程
        [self courseBuyAlterViewShow];
    }
}

-(void)courseBuyAlterViewShow
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还未购买该课程，现在就去购买？" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //跳转
        if (@available(iOS 10.0,*)){
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:kMKCourseBuyUrl]]){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kMKCourseBuyUrl] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@(false)} completionHandler:nil];
            }
        }else{
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:kMKCourseBuyUrl]]){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kMKCourseBuyUrl]];
            }
        }
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancleAction];
    [alert addAction:sureAction];
}

#pragma mark --  线下课程添加日历提醒
-(void)offlineCourseAddCalendar
{
    if (![[UserManager shareInstance]isLogin]) {
        [self loginAlterViewShow];
        return;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确认为该课程添加日历提醒？" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[MKCalendarsManager sharedinstance] createRemindCalendarsWithMKOfflineCourseDetailModel:self.offlineCourseDetailModel];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style :UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancleAction];
    [alert addAction:sureAction];
}


-(void)setUpVideoWithVideoID:(NSString *)videoID lessonID:(NSString *)lessonID
{
    MKLog(@"%@",self.player);
//    self.player.rememberLastPosition = YES;
        [self.player addPlayerOnPlaceholderView:self.placeholderView rootViewController:self];
    // 有网情况下，也可以调用此接口，只要存在本地视频，都会优先播放本地视频
    __weak typeof(self) weakSelf = self;
    [PLVVodVideo requestVideoWithVid:videoID completion:^(PLVVodVideo *video, NSError *error) {
        if (!video.available){
            NSString *errorMessage = video.error.userInfo[@"NSHelpAnchor"];
            if (![NSString isEmptyWithStr:errorMessage]) {
                [MBHUDManager showBriefAlert:errorMessage];
            }
            return;
        }
        [CourseDetailManager callBackRecordLessonPlayRequestWithVideo_id:lessonID andCompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message) {
            if (isSuccess) {
                [[NSNotificationCenter defaultCenter]postNotificationName:kMKUserCourseListRefreshNotifcationKey object:nil];
            }
        }];
        weakSelf.player.video = video;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            weakSelf.title = video.title;
//        });
    }];
}

#pragma mark --  播放按钮点击
-(void)videoPlayerTarget:(UITapGestureRecognizer *)tap
{
    if (self.onlineCourseDetailModel.lessonList.count > 0) {
        MKLessonModel *lessonModel = self.onlineCourseDetailModel.lessonList[0];
        if (lessonModel.video_status) {
            lessonModel.isSelected = YES;
            [self setUpVideoWithVideoID:lessonModel.video_id lessonID:lessonModel.lessonID];
            [self.detailScroll courseDetailScrollViewReloadDataWithMKCourseDetailModel:self.onlineCourseDetailModel offlineCourseDetailModel:nil];
        }else{
            if (![[UserManager shareInstance]isLogin]) {
                [self loginAlterViewShow];
                return;
            }
            [self courseBuyAlterViewShow];
        }
    }else{
        [MBHUDManager showBriefAlert:@"没有可以播放的课程！"];
    }
}

-(void)loginTarget:(NSNotification *)noti
{
    [self startRequest];
}

#pragma mark --  屏幕旋转
- (BOOL)shouldAutorotate{
    if (self.player.playbackState == PLVVodPlaybackStatePlaying || self.player.playbackState == PLVVodPlaybackStatePaused) {
      return YES;
    }
    return NO;
}

//返回支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end
