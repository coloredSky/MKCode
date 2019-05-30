//
//  AppointmentTapView.m
//  MK
//
//  Created by 周洋 on 2019/3/31.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "AppointmentTapView.h"
#import "AppDelegate.h"

@interface AppointmentTapView()
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UITextField *contentTF;
@property (nonatomic, strong) UIButton *clickBtn;

//@property (nonatomic, assign) BOOL isSelected;

@end
@implementation AppointmentTapView
@synthesize delegate;

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createSubView];
    }
    return self;
}
-(instancetype)init
{
    if (self = [super init]) {
        [self createSubView];
    }
    return self;
}
-(void)createSubView
{
    _shadowView = [UIView new];
    [self addSubview:_shadowView];
    self.shadowView.backgroundColor = [UIColor clearColor];
    self.shadowView.layer.shadowColor = K_Text_DeepGrayColor.CGColor;
    self.shadowView.layer.shadowRadius = KScaleHeight(3);
    self.shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    self.shadowView.layer.shadowOpacity = .5;
    
    _whiteView = [UIView new];
    [self.shadowView addSubview:_whiteView];
    _whiteView.backgroundColor = K_BG_blackColor;
    _whiteView.layer.masksToBounds = YES;
    _whiteView.layer.cornerRadius = KScaleHeight(6);
    
    _contentTF = [UITextField new];
    [self.whiteView addSubview:_contentTF];
    _contentTF.font = K_Font_Text_Normal_little;
    _contentTF.textColor = K_Text_WhiteColor;
    _contentTF.backgroundColor = [UIColor clearColor];
    _contentTF.userInteractionEnabled = NO;
    
    _clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.whiteView addSubview:_clickBtn];
    [_clickBtn addTarget:self action:@selector(clickBtnTarget:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.shadowView.frame = CGRectMake(0, 0, self.width, self.height);
    self.whiteView.frame = CGRectMake(0, 0, self.shadowView.width, self.shadowView.height);
    self.contentTF.frame = CGRectMake(K_Padding_LeftPadding, 0, self.whiteView.width-K_Padding_LeftPadding*2, self.whiteView.height);
    self.clickBtn.frame = CGRectMake(0, 0, self.whiteView.width, self.whiteView.height);
}

-(void)setCanEditing:(BOOL)canEditing
{
    self.contentTF.userInteractionEnabled = canEditing;
    self.clickBtn.hidden = canEditing;
}
-(void)setPlaceholderString:(NSString *)placeholderString
{
    self.contentTF.placeholder = placeholderString;
    [self.contentTF setValue:K_Text_grayColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.contentTF setValue:K_Font_Text_Normal_little forKeyPath:@"_placeholderLabel.font"];
}
-(void)setTextString:(NSString *)textString
{
    self.contentTF.text = textString;
}
-(NSString *)textString
{
    return self.contentTF.text;
}
-(void)setNormalColor:(UIColor *)normalColor
{
    self.contentTF.textColor = normalColor;
}

-(void)clickBtnTarget:(UIButton *)sender
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window endEditing:YES];
    if ([delegate respondsToSelector:@selector(appointmentTapViewTapClickWithView:)]) {
        [delegate appointmentTapViewTapClickWithView:self];
    }
}
@end
