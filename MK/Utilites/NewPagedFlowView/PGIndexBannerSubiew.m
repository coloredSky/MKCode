//
//  PGIndexBannerSubiew.m
//  NewPagedFlowViewDemo
//
//  Created by Mars on 16/6/18.
//  Copyright © 2016年 Mars. All rights reserved.
//  Designed By PageGuo,
//  QQ:799573715
//  github:https://github.com/PageGuo/NewPagedFlowView

#import "PGIndexBannerSubiew.h"
@interface PGIndexBannerSubiew()
@property (nonatomic, strong) UIView *contentView;
@end
@implementation PGIndexBannerSubiew


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.shadowColor = K_Text_DeepGrayColor.CGColor;
        self.layer.shadowRadius = 3.0f;
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.layer.shadowOpacity = .5;
        
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.mainImageView];
        [self.contentView addSubview:self.coverView];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleCellTapAction:)];
        [self addGestureRecognizer:singleTap];
    }
    
    return self;
}

- (void)singleCellTapAction:(UIGestureRecognizer *)gesture {
    if (self.didSelectCellBlock) {
        self.didSelectCellBlock(self.tag, self);
    }
}

- (void)setSubviewsWithSuperViewBounds:(CGRect)superViewBounds {
    
    if (CGRectEqualToRect(self.mainImageView.frame, superViewBounds)) {
        return;
    }
    self.contentView.frame = superViewBounds;
    self.mainImageView.frame = superViewBounds;
    self.coverView.frame = superViewBounds;
}

-(UIView *)contentView
{
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.cornerRadius = KScaleWidth(10);
    }
    return _contentView;
}
- (UIImageView *)mainImageView {
    
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] init];
        _mainImageView.userInteractionEnabled = YES;
    }
    return _mainImageView;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = [UIColor blackColor];
    }
    return _coverView;
}

@end
