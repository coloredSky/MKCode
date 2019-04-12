//
//  UITextView+WJPlaceholder.m
//  UITextViewPlaceDemo
//
//  Created by JianJian-Mac on 17/3/17.
//  Copyright © 2017年 Mecare. All rights reserved.
//

static char *labelKey = "placeholderKey";
static char *needAdjust = "needAdjust";
static char *changeLocation = "location";

#import "UITextView+WJPlaceholder.h"
#import <objc/runtime.h>

@implementation UITextView (WJPlaceholder)

//category need manual synthesis
//@dynamic placeholdFont;

+ (void)load
{
  method_exchangeImplementations(class_getInstanceMethod(self.class,NSSelectorFromString(@"dealloc") ),
                                class_getInstanceMethod(self.class, NSSelectorFromString(@"swizzledDealloc")));
}

+(void)swizzledDealloc
{
    //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self swizzledDealloc];
}

/**
 *  设置placeholderLabel
 *
 *  @return label
 */
- (UILabel *)placeholdLabel
{
    UILabel *label = objc_getAssociatedObject(self, labelKey);
    if (!label) {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label.textColor = [self.class defaultColor];
        objc_setAssociatedObject(self, labelKey, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        //添加通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabel) name:UITextViewTextDidChangeNotification object:nil];
        //监听font的变化
        [self addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
    }
    return label;
}

/**
 *  设置默认颜色
 *
 *  @return color
 */
+ (UIColor *)defaultColor
{
    static UIColor *color = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
       UITextField *textField = [[UITextField alloc] init];
       textField.placeholder = @" ";
       color = [textField valueForKeyPath:@"_placeholderLabel.textColor"];
    });
    return color;
}

#pragma mark - set get methods
- (void)setPlaceholder:(NSString *)placeholder
{
    self.placeholdLabel.text = placeholder;
    [self updateLabel];
}

- (NSString *)placeholder
{
    return self.placeholdLabel.text;
}

-(void)setPlaceholdFont:(UIFont *)placeholdFont
{
    self.placeholdLabel.font = placeholdFont;
    [self updateLabel];
}
-(UIFont *)placeholdFont
{
    return K_Font_Text_Normal;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    self.placeholdLabel.textColor = placeholderColor;
    [self updateLabel];
}

- (UIColor *)placeholderColor
{
    return self.placeholdLabel.textColor;
}

- (void)setAttributePlaceholder:(NSAttributedString *)attributePlaceholder
{
    self.placeholdLabel.attributedText = attributePlaceholder;
    [self updateLabel];
}

- (NSAttributedString *)attributePlaceholder
{
    return self.placeholdLabel.attributedText;
}

- (void)setLocation:(CGPoint)location
{
    objc_setAssociatedObject(self, changeLocation,NSStringFromCGPoint(location), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateLabel];
}

-(CGPoint)location
{
    return CGPointFromString(objc_getAssociatedObject(self, changeLocation));
}

//是否需要调整字体
- (BOOL)needAdjustFont
{
    return [objc_getAssociatedObject(self, needAdjust) boolValue ];
}

- (void)setNeedAdjustFont:(BOOL)needAdjustFont
{
    objc_setAssociatedObject(self, needAdjust, @(needAdjustFont), OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - observer font KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"font"])
    {
        self.needAdjustFont = YES;
         [self updateLabel];
    }
}
/**
 *  更新label信息
 */
- (void)updateLabel
{
    if (self.text.length) {
        [self.placeholdLabel removeFromSuperview];
        return;
    }
    //显示label
    [self insertSubview:self.placeholdLabel atIndex:0];
    
    //是否需要更新字体（NO 采用默认字体大小）
    if (self.needAdjustFont) {
        self.placeholdLabel.font = self.font;
        self.needAdjustFont = NO;
    }

   CGFloat  lineFragmentPadding =  self.textContainer.lineFragmentPadding;  //边距
   UIEdgeInsets contentInset = self.textContainerInset;

    //设置label frame
    CGFloat labelX = lineFragmentPadding + contentInset.left;
    CGFloat labelY = contentInset.top;
    if (self.location.x != 0 || self.location.y != 0) {
        if (self.location.x < 0 || self.location.x > CGRectGetWidth(self.bounds) - lineFragmentPadding - contentInset.right || self.location.y< 0) {
            // 不做处理
        }else{
            labelX += self.location.x;
            labelY += self.location.y;
        }
    }
    CGFloat labelW = CGRectGetWidth(self.bounds)  - contentInset.right - labelX;
    CGFloat labelH = [self.placeholdLabel sizeThatFits:CGSizeMake(labelW, MAXFLOAT)].height;
    self.placeholdLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
}

@end
