//
//  MKPlaceholderView.m
//  MK
//
//  Created by 周洋 on 2019/4/22.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKPlaceholderView.h"
@interface MKPlaceholderView()
@property (nonatomic, strong) NSArray *titleStringArr;//标签
@property (nonatomic, strong) NSArray *noDataImagArr;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *noDataIma;
@property (nonatomic, strong) UIView *noDataView;
@end
@implementation MKPlaceholderView
@synthesize delegate;

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(placeholderViewTapTarget:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark --  lazy
-(NSArray *)titleStringArr
{
    if (!_titleStringArr) {
        _titleStringArr = @[@"暂无数据",@"没网络啦！请点击重新加载！",@"还没有预约课程？先去看看感兴趣的课程吧！",@"先去看看感兴趣的课程吧！",];
    }
    return _titleStringArr;
}
-(NSArray *)noDataImagArr
{
    if (!_noDataImagArr) {
        _noDataImagArr = @[@"course_list_nodata",@"nonetworking",@"orderlist_nodata",@"bookmark_nodata",];
    }
    return _noDataImagArr;
}
-(UIView *)noDataView
{
    if (!_noDataView) {
        _noDataView = [UIView new];
        _noDataView.backgroundColor = K_BG_deepGrayColor;
        [self addSubview:_noDataView];
    }
    return _noDataView;
}
-(UIImageView *)noDataIma
{
    if (!_noDataIma) {
        _noDataIma = [UIImageView new];
        [self.noDataView addSubview:_noDataIma];
//        _noDataIma.image = [UIImage imageNamed:self.noDataImagArr[self.displayType]];
    }
    return _noDataIma;
}
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [UILabel new];
        [self.noDataView addSubview:_titleLab];
        [_titleLab setFont:K_Font_Text_Normal textColor:K_Text_BlackColor withBackGroundColor:nil];
        _titleLab.textAlignment = NSTextAlignmentCenter;
//        _titleLab.text = self.titleStringArr[self.displayType];
    }
    return _titleLab;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"-----%@",NSStringFromCGRect(self.frame));
    self.noDataView.frame = CGRectMake(0, 0, self.width, self.height);
    self.noDataIma.frame = CGRectMake(self.noDataView.width/2-KScaleWidth(67), self.noDataView.height/2-KScaleWidth(67)-KScaleHeight(60), KScaleWidth(134), KScaleWidth(134));
    self.titleLab.frame = CGRectMake(0, self.noDataIma.bottomY+KScaleHeight(5), self.noDataView.width, KScaleHeight(20));
}

-(void)setDisplayType:(MKPlaceWorderViewDisplayType)displayType
{
    _displayType = displayType;
    self.titleLab.text = self.titleStringArr[displayType];
    self.noDataIma.image = [UIImage imageNamed:self.noDataImagArr[displayType]];
}


#pragma mark --  EVENT
-(void)placeholderViewTapTarget:(UITapGestureRecognizer *)tap
{
    if ([delegate respondsToSelector:@selector(placeholderViewClickWithDisplayType:)]) {
        [delegate placeholderViewClickWithDisplayType:self.displayType];
    }
}
@end
