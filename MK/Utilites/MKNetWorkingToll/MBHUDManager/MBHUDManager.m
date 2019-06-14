//
//  MBHUDManager.m
//  XHBorrow
//
//  Created by caoyong on 2018/10/26.
//  Copyright © 2018年 caoyong. All rights reserved.
//

#import "MBHUDManager.h"
#import <MBProgressHUD.h>

#define kDefaultRect     CGRectMake(0, 0, KScreenWidth, KScreenHeight)
#define kDefaultView [[UIApplication sharedApplication] keyWindow]
/* 默认网络提示，可在这统一修改 */
static NSString *const kLoadingMessage = @"加载中";

/* 默认简短提示语显示的时间，在这统一修改 */
static CGFloat const   kShowTime  = 2.0f;

/* 手势是否可用，默认yes，轻触屏幕提示框隐藏 */
static BOOL isAvalibleTouch = YES;

@implementation MBHUDManager
UIView *gloomyView;//深色背景
UIView *prestrainView;//预加载view
BOOL isShowGloomy;//是否显示深色背景
#pragma mark -   类初始化
+ (void)initialize {
    if (self == [MBHUDManager self]) {
        //该方法只会走一次
        [self customView];
    }
}
#pragma mark - 初始化gloomyView
+(void)customView {
    gloomyView = [[GloomyView alloc] initWithFrame:kDefaultRect];
    gloomyView.backgroundColor = UIColorFromRGB_A(0, 0, 0, 0.5);
    gloomyView.hidden = YES;
    isShowGloomy = NO;
}
+ (void)showGloomy:(BOOL)isShow {
    isShowGloomy = isShow;
}
#pragma mark - 简短提示语
+ (void) showBriefAlert:(NSString *) message inView:(UIView * __nullable) view {
    [self showBriefAlert:message time:kShowTime inView:view isHerizotal:NO];
}
+ (void)showBriefAlert:(NSString *)message time:(NSInteger)showTime inView:(UIView *)view {
    [self showBriefAlert:message time:showTime inView:view isHerizotal:YES];
}
+ (void)showBriefAlert:(NSString *)message time:(NSInteger)showTime inView:(UIView *)view isHerizotal:(BOOL)isHerizontal {
    if ([self isEmptyWithStr:message]) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view ?:kDefaultView animated:YES];
        hud.detailsLabel.text = message;
        hud.detailsLabel.font = [UIFont systemFontOfSize:16];
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.mode = MBProgressHUDModeText;
        hud.margin = 10.f;
        //HUD.yOffset = 200;
        
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:showTime];
        if (isHerizontal) {
            hud.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
    });
}
#pragma mark - 长时间的提示语
+ (void) showPermanentMessage:(NSString *)message inView:(UIView *__nullable) view{
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:gloomyView animated:YES];
        hud.label.text = message;
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.mode = MBProgressHUDModeCustomView;
        hud.removeFromSuperViewOnHide = YES;
        hud.mode = MBProgressHUDModeText;
        [gloomyView addSubview:hud];
        [self showClearGloomyView];
        [hud showAnimated:YES];
    });
}
#pragma mark - 网络加载提示用
+ (void) showLoadingInView:(UIView *__nullable) view{
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:gloomyView];
       hud.label.text = kLoadingMessage;
       hud.label.font = MKFont(13.f);
        hud.removeFromSuperViewOnHide = YES;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        if (isShowGloomy) {
            [self showBlackGloomyView];
        }else {
            [self showClearGloomyView];
        }
        [gloomyView addSubview:hud];
        [hud showAnimated:YES];
    });
    
}
+ (void)showWaitingWithTitle:(NSString *)title inView:(UIView *__nullable)view {
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:gloomyView];
        hud.frame = CGRectMake(0, 0, 100, 100);
        hud.label.text = title;
        hud.label.font = MKFont(13.f);
        hud.removeFromSuperViewOnHide = YES;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        if (isShowGloomy) {
            [self showBlackGloomyView];
        }else {
            [self showClearGloomyView];
        }
        [gloomyView addSubview:hud];
        [hud showAnimated:YES];
    });
}
+(void)showAlertWithCustomImage:(NSString *)imageName title:(NSString *)title inView:(UIView *__nullable)view{
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view ?:kDefaultView animated:YES];
        UIImageView *littleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
        littleView.image = [UIImage imageNamed:imageName];
        hud.customView = littleView;
        hud.removeFromSuperViewOnHide = YES;
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.label.text = title;
        hud.mode = MBProgressHUDModeCustomView;
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:kShowTime];
    });
}
#pragma mark - 加载在window上的提示框
+(void)showLoading{
    [self showLoadingInView:nil];
}
+ (void)showWaitingWithTitle:(NSString *)title{
    [self showWaitingWithTitle:title inView:nil];
}
+(void)showBriefAlert:(NSString *)alert{
    [self showBriefAlert:alert inView:nil];
}
+(void)showPermanentAlert:(NSString *)alert{
    [self showPermanentMessage:alert inView:nil];
}
+(void)showAlertWithCustomImage:(NSString *)imageName title:(NSString *)title {
    [self showAlertWithCustomImage:imageName title:title inView:nil];
}
+ (void)showBriefAlert:(NSString *)message time:(NSInteger)showTime {
    [self showBriefAlert:message time:showTime inView:nil isHerizotal:YES];
}
#pragma mark -   GloomyView背景色
+ (void)showBlackGloomyView {
    gloomyView.backgroundColor = UIColorFromRGB_A(0, 0, 0, 0.5);
    [self gloomyConfig];
}
+ (void)showClearGloomyView {
    gloomyView.backgroundColor = UIColorFromRGB_A(1, 1, 1, 0);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self gloomyConfig];
    });
}
#pragma mark -   决定GloomyView add到已给view或者window上
+ (void)gloomyConfig {
    gloomyView.hidden = NO;
    gloomyView.alpha = 1;
    if (prestrainView) {
        [prestrainView addSubview:gloomyView];
    }else {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (![window.subviews containsObject:gloomyView]) {
            [window addSubview:gloomyView];
        }
    }
}
#pragma mark - 隐藏提示框
+(void)hideAlert{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBHUDManager HUDForView:gloomyView];
#if 1
        gloomyView.frame = CGRectZero;
        gloomyView.center = prestrainView ? prestrainView.center: [UIApplication sharedApplication].keyWindow.center;
        gloomyView.alpha = 0;
        [hud removeFromSuperview];
        [gloomyView removeFromSuperview];
#else
        [UIView animateWithDuration:0.5 animations:^{
            gloomyView.frame = CGRectZero;
            gloomyView.center = prestrainView ? prestrainView.center: [UIApplication sharedApplication].keyWindow.center;
            gloomyView.alpha = 0;
            hud.alpha = 0;
        } completion:^(BOOL finished) {
            [hud removeFromSuperview];
        }];
#endif
    });
    
}
#pragma mark -   获取view上的hud
+ (MBProgressHUD *)HUDForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:[MBProgressHUD class]]) {
            return (MBProgressHUD *)subview;
        }
    }
    return nil;
}


+(BOOL)isEmptyWithStr:(NSString *)currentStr
{
    if ([currentStr isEqual:[NSNull class]] || [currentStr isEqual:[NSNull null]] || currentStr == nil || currentStr == NULL)
    {
        return YES;
    }
    else
    {
        if ([currentStr isEqualToString:@""] || [currentStr stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0)
        {
            return YES;
        }
    }
    return NO;
}
@end

@implementation GloomyView
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (isAvalibleTouch) {
//        [MBHUDManager hideAlert];
    }
}


@end
