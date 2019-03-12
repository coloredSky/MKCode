//
//  PopoverView.h
//
//  Created by zhou on 20/08/2016.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    BMPopViewAnimationNone = 0,
    BMPopViewAnimationTransForm ,
    BMPopViewAnimationShowFromBottom,
    BMPopViewAnimationShowFromLeft,
    BMPopViewAnimationShowFromRight,
    BMPopViewAnimationShowBegainTop,
} BMPopViewAnimation;

@class BMPopView;

@protocol BMPopViewDelegate <NSObject>

@optional

- (void)popViewDidDismiss:(BMPopView *)popView;

@end

@interface BMPopView : UIView<UIGestureRecognizerDelegate>
{
    
    BMPopViewAnimation _animation;
}

@property (nonatomic, retain) UIView *contentView;

@property (nonatomic, assign) id<BMPopViewDelegate> delegate;
// 自定义contentView 的frame  (位置)
@property (nonatomic, assign) BOOL customFrame;

@property (nonatomic) UIEdgeInsets offset;

// 是否全屏
@property (nonatomic,assign)BOOL isFullScreen;

// 点击灰色区域是否消失
@property (nonatomic,assign)BOOL canDisMiss;

@property (nonatomic,assign)CGRect boxFrame;


@property (nonatomic,assign)BOOL isCustomBgFrame;
@property (nonatomic,assign)CGRect bgFrame;

@property (nonatomic,retain)UIColor *bgColor;

+(BMPopView *)shareInstance;

+ (BMPopView *)showWithContentView:(UIView *)cView delegate:(id<BMPopViewDelegate>)delegate;

- (void)showWithContentView:(UIView *)cView delegate:(id<BMPopViewDelegate>)delegate;
- (void)showWithContentView:(UIView *)cView;

+ (BMPopView *)showWithContentView:(UIView *)cView withAnimation:(BMPopViewAnimation)myAnimation delegate:(id<BMPopViewDelegate>)delegate;

- (void)showWithContentView:(UIView *)cView withAnimation:(BMPopViewAnimation)myAnimation delegate:(id<BMPopViewDelegate>)delegate;

- (void)showWithContentView:(UIView *)cView withAnimation:(BMPopViewAnimation)myAnimation;


- (void)dismiss;


@end
