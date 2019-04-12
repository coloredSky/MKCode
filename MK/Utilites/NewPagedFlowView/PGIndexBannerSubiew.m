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
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIView *contentView;
@end
@implementation PGIndexBannerSubiew


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.shadowView.layer.shadowColor = K_Text_DeepGrayColor.CGColor;
        self.shadowView.layer.shadowRadius = 3.0f;
        self.shadowView.layer.shadowOffset = CGSizeMake(1, 1);
        self.shadowView.layer.shadowOpacity = .5;
        
        [self addSubview:self.shadowView];
        [self.shadowView addSubview:self.contentView];
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
    self.shadowView.frame = CGRectMake(5, 5, superViewBounds.size.width-10, superViewBounds.size.height-10);
    self.contentView.frame = CGRectMake(0, 0, self.shadowView.width, self.shadowView.height);
    self.mainImageView.frame = CGRectMake(0, 0, self.shadowView.width, self.shadowView.height);
    self.coverView.frame = CGRectMake(0, 0, self.shadowView.width, self.shadowView.height);
}

-(UIView *)shadowView
{
    if (!_shadowView) {
        _shadowView = [UIView new];
        _shadowView.backgroundColor = [UIColor clearColor];
    }
    return _shadowView;
}

-(UIView *)contentView
{
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor clearColor];
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
