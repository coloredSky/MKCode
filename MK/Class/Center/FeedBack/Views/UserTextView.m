//
//  UserTextView.m
//  FWRACProject
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 he. All rights reserved.
//

#import "UserTextView.h"

@interface UserTextView ()<UITextViewDelegate>

@property (nonatomic, strong) UIColor *userTextColor;

@end


@implementation UserTextView

@synthesize placeholder = _placeholder;
@synthesize placeholderColor = _placeholderColor;

- (void)awakeFromNib{
    [super awakeFromNib];
    self.delegate = self;
}

- (instancetype)init{
    if (self = [super init]) {
        self.delegate = self;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.delegate = self;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder placeholderColor:(UIColor *)placeholderColor contentTextColor:(UIColor *)contentTextColor{
    if (self = [super initWithFrame:frame]) {
        _placeholder = placeholder;
        _placeholderColor = placeholderColor;
        _contentTextColor = contentTextColor;
        self.text = _placeholder;
        self.textColor = _placeholderColor;
        self.delegate = self;
    }
    return self;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = self.placeholder;
        textView.textColor = self.placeholderColor;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:self.placeholder]){
        textView.text = @"";
        textView.textColor = self.contentTextColor;
    }
}

- (NSString *)placeholder{
    if (!_placeholder) {
        _placeholder = @"请输入";
    }
    return _placeholder;
}

- (UIColor *)placeholderColor{
    if (!_placeholderColor) {
        _placeholderColor = [UIColor lightGrayColor];
    }
    return _placeholderColor;
}

- (UIColor *)contentTextColor{
    if (!_contentTextColor) {
        _contentTextColor = [UIColor blackColor];
    }
    return _contentTextColor;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    self.textColor = placeholderColor;
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.text = placeholder;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
