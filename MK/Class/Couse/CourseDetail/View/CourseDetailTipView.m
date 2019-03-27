//
//  CourseDetailTipView.m
//  MK
//
//  Created by 周洋 on 2019/3/22.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "CourseDetailTipView.h"
@interface CourseDetailTipView()
@property (nonatomic, strong) UIButton *lessonBtn;
@property (nonatomic, strong) UIButton *aboutBtn;
@property (nonatomic, strong) UIImageView *tipIma;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nullable,nonatomic, strong) NSMutableArray <UIButton *>*btnArr;
@end
@implementation CourseDetailTipView
@synthesize delegate;

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _tipIma = [[UIImageView alloc]initWithFrame:CGRectMake(K_Padding_LeftPadding, frame.size.height/2-KScaleWidth(17), KScaleWidth(88), KScaleWidth(34))];
        [self addSubview:_tipIma];
        _tipIma.layer.masksToBounds = YES;
        _tipIma.layer.cornerRadius = KScaleWidth(17);
        _tipIma.userInteractionEnabled = YES;
        _tipIma.backgroundColor = K_BG_blackColor;
        
        _lessonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_lessonBtn];
        _lessonBtn.selected = YES;
        self.selectedBtn = _lessonBtn;
        [_lessonBtn setNormalTitle:@"Lesson" font:MKBoldFont(15) titleColor:K_Text_BlackColor];
        [_lessonBtn setSelectedTitle:@"Lesson" titleColor:K_Text_WhiteColor];
        _lessonBtn.frame = CGRectMake(K_Padding_LeftPadding, frame.size.height/2-KScaleWidth(17), KScaleWidth(88), KScaleWidth(34));
        _lessonBtn.tag = 1;
        [_lessonBtn addTarget:self action:@selector(btnClickTarget:) forControlEvents:UIControlEventTouchUpInside];
        
        _aboutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _aboutBtn.tag = 2;
        [self addSubview:_aboutBtn];
        [_aboutBtn setNormalTitle:@"About" font:MKBoldFont(15) titleColor:K_Text_BlackColor];
        [_aboutBtn setSelectedTitle:@"About" titleColor:K_Text_WhiteColor];
        _aboutBtn.frame = CGRectMake(_lessonBtn.rightX+KScaleWidth(15), _lessonBtn.topY, _lessonBtn.width, _lessonBtn.height);
        [_aboutBtn addTarget:self action:@selector(btnClickTarget:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.btnArr addObject:_lessonBtn];
        [self.btnArr addObject:_aboutBtn];
        
    }
    return self;
}

-(NSMutableArray<UIButton *>*)btnArr
{
    if (!_btnArr) {
        _btnArr = [NSMutableArray arrayWithCapacity:2];
    }
    return _btnArr;
}

#pragma mark --  EVENT
-(void)btnClickTarget:(UIButton *)sender
{
    [self secrollToIndex:sender.tag-1];
    if ([delegate respondsToSelector:@selector(CourseDetailTipViewClickBtnWithSelectedIndex:)]) {
        [delegate CourseDetailTipViewClickBtnWithSelectedIndex:sender.tag-1];
    }
}

-(void)secrollToIndex:(NSInteger )index
{
    if (index < self.btnArr.count && index >= 0) {
        UIButton *sender = self.btnArr[index];
        [self buttonClickWithSender:sender];
    }
}

-(void)buttonClickWithSender:(UIButton *)sender
{
    if (self.selectedBtn == sender) {
        return;
    }
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
    [UIView animateWithDuration:.2 animations:^{
        self.tipIma.frame = CGRectMake(sender.centerX-KScaleWidth(88)/2, sender.centerY-KScaleWidth(34)/2, KScaleWidth(88), KScaleWidth(34));
    }];
}

-(void)courseButtonSeletedWithIndex:(NSInteger )index
{
    if (index < self.btnArr.count) {
    [self secrollToIndex:index];
    }
}
@end
