//
//  XHRefreshHeader.m
//  XHBorrow
//
//  Created by 周洋 on 2018/10/17.
//  Copyright © 2018年 caoyong. All rights reserved.
//

#import "XHRefreshHeader.h"
@interface XHRefreshHeader()
@property(nonatomic,strong)UIView *animatiedView;
@property(nonatomic,strong)UIImageView *animatiedIma;
@property(nonatomic,strong)UIImageView *logoIma;
@property(nonatomic,strong)UILabel *stateLab;

@property(nonatomic,strong)CAShapeLayer* animationLayer;

@property(nonatomic,assign)BOOL finish;
@end
@implementation XHRefreshHeader
- (CAShapeLayer *)animationLayer {
    if (!_animationLayer) {
        _animationLayer = [CAShapeLayer layer];
        _animationLayer.fillColor = [UIColor clearColor].CGColor;
        _animationLayer.strokeColor = K_BG_YellowColor.CGColor;
        _animationLayer.lineWidth = 2.5;
        _animationLayer.lineCap = kCALineCapRound;
    }
    return _animationLayer;
}
-(UIView *)animatiedView
{
    if (!_animatiedView)
    {
        _animatiedView = [UIView new];
        _animatiedView.backgroundColor = K_BG_deepGrayColor;
    }
    return _animatiedView;
}
-(UIImageView *)animatiedIma
{
    if (!_animatiedIma)
    {
        _animatiedIma = [UIImageView new];
    }
    return _animatiedIma;
}
-(UIImageView *)logoIma
{
    if (!_logoIma)
    {
        _logoIma = [UIImageView new];
        _logoIma.image = [UIImage imageNamed:@"common_safe"];
    }
    return _logoIma;
}
-(UILabel *)stateLab
{
    if (!_stateLab)
    {
        _stateLab = [UILabel new];
        _stateLab.font = [UIFont systemFontOfSize:14];
        UIColor *textColor = K_Text_grayColor;
        [_stateLab setFont:[UIFont systemFontOfSize:14] textColor:textColor withBackGroundColor:nil];
        _stateLab.textAlignment = NSTextAlignmentCenter;
        _stateLab.text = @"值得信赖的平台";
    }
    return _stateLab;
}

- (void)prepare
{
    [super prepare];
}

- (void)placeSubviews
{
    [super placeSubviews];
    self.animatiedView.bounds = CGRectMake(0, 0, self.mj_w, self.mj_h);
    self.animatiedView.center = CGPointMake(self.mj_w*0.5, self.mj_h *0.5);
    [self addSubview:self.animatiedView];
    self.stateLab.frame = CGRectMake(_animatiedView.width/2-KScaleWidth(150)/2+30, _animatiedView.height/2-10, KScaleWidth(150), 20);
    [_animatiedView addSubview:_stateLab];
    
    self.animatiedIma.frame = CGRectMake(_stateLab.leftX-8-26, _stateLab.centerY-13, 26, 26);
    [self.animatiedView addSubview:self.animatiedIma];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_animatiedIma.width/2, _animatiedIma.height/2) radius:_animatiedIma.width/2 startAngle:M_PI/8 endAngle:M_PI*2 clockwise:YES];
    self.animationLayer.path = path.CGPath;
    self.animationLayer.anchorPoint = CGPointMake(0.5, 0.5);
    self.animationLayer.position=CGPointMake(_animatiedIma.width/2,_animatiedIma.height/2);
    self.animationLayer.bounds = CGRectMake(0, 0, self.animatiedIma.width, self.animatiedIma.height);
    [self.animatiedIma.layer addSublayer:_animationLayer];
    
    self.logoIma.frame = CGRectMake(_animatiedIma.centerX-5, _animatiedIma.centerY-5, 10, 10);
    [self.animatiedView addSubview:_logoIma];
}

- (void)setState:(MJRefreshState)state
{
    [super setState:state];
    if (state == MJRefreshStateIdle)
    { //刷新完成
        [self stopAnimation];
    }
    else if (state == MJRefreshStatePulling)
    {
        self.finish = YES;
        self.animationLayer.strokeEnd = 1;
    }
    else if (state == MJRefreshStateRefreshing)
    {
        [self startAnimation];
    }
}
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    if (_finish == NO)
    {
        self.animationLayer.strokeEnd = self.pullingPercent;
    }
}
-(void)startAnimation
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.duration = .5;
    anim.toValue = @(M_PI *2);
    anim.repeatCount = MAXFLOAT;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.animationLayer addAnimation:anim forKey:nil];
}
-(void)stopAnimation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        _finish = NO;
        [self.animationLayer  removeAllAnimations];
    });
}

@end
