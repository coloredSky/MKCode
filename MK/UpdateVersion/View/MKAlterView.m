//
//  MKAlterView.m
//  MK
//
//  Created by 周洋 on 2019/6/28.
//  Copyright © 2019 周洋. All rights reserved.
//

static CGFloat const MKAlterViewLeftPadding = 15;

#import "MKAlterView.h"

@interface MKAlterView()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *messageLab;
//@property (nonatomic, strong) NSMutableArray <UIButton *>*senderTileArr;
@end

@implementation MKAlterView
@synthesize delegate;

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancleButtonTitle:(NSString *)cancleButtonTitle otherButtonTitles:(NSString *)otherButtonTitles
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithWhite:.95 alpha:1];
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = KScaleWidth(18);
        self.layer.shadowColor = K_Text_DeepGrayColor.CGColor;
        self.layer.shadowRadius = 3.0f;
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.layer.shadowOpacity = .5;
        
        CGFloat alterViewWidth = KScaleWidth(270);
        CGFloat messageHeight = [message getStrSizeWithSize:CGSizeMake(alterViewWidth-MKAlterViewLeftPadding*2, 200) font:MKFont(14)].height;
        NSMutableArray *senderTileArr = [NSMutableArray array];

        _titleLab = [UILabel new];
        [self addSubview:_titleLab];
        [_titleLab setFont:MKBoldFont(15) textColor:K_Text_BlackColor withBackGroundColor:nil];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text = title;
        _titleLab.frame = CGRectMake(MKAlterViewLeftPadding, 20, alterViewWidth-MKAlterViewLeftPadding*2, 20);
        
        _messageLab = [UILabel new];
        [self addSubview:_messageLab];
        [_messageLab setFont:MKFont(14) textColor:K_Text_BlackColor withBackGroundColor:nil];
        _messageLab.textAlignment = NSTextAlignmentLeft;
        _messageLab.text = message;
        _messageLab.numberOfLines = 0;
        _messageLab.frame = CGRectMake(_titleLab.leftX, _titleLab.bottomY+5, _titleLab.width, messageHeight);
        
        if (![NSString isEmptyWithStr:cancleButtonTitle]) {
            [senderTileArr addObject:cancleButtonTitle];
        }
        if (![NSString isEmptyWithStr:otherButtonTitles]) {
            [senderTileArr addObject:otherButtonTitles];
        }
        for (NSInteger i=0; i<senderTileArr.count; i++) {
            NSString *senderTitle = senderTileArr[i];
            UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:clickBtn];
            clickBtn.tag = i;
            [clickBtn addTarget:self action:@selector(clickBtnTarget:) forControlEvents:UIControlEventTouchUpInside];
            [clickBtn setNormalTitle:senderTitle font:MKFont(16) titleColor:UIColorFromRGB_A(44, 124, 246, 1)];
            if (senderTileArr.count == 1) {
                clickBtn.frame = CGRectMake(0, _messageLab.bottomY+20, alterViewWidth, 44);
            }else{
                CGFloat clickBtnWidth = alterViewWidth/senderTileArr.count;
                clickBtn.frame = CGRectMake(clickBtnWidth*i, _messageLab.bottomY+20, clickBtnWidth, 44);
            }
            if (i == 0) {
                UIImageView *lineIma = [[UIImageView alloc]initWithFrame:CGRectMake(0, clickBtn.topY, alterViewWidth, K_Line_lineWidth)];
                [self addSubview:lineIma];
                lineIma.backgroundColor = K_Line_lineColor;
            }else{
                UIImageView *lineIma = [[UIImageView alloc]initWithFrame:CGRectMake(clickBtn.leftX-K_Line_lineWidth, clickBtn.topY, K_Line_lineWidth, clickBtn.height)];
                [self addSubview:lineIma];
                lineIma.backgroundColor = K_Line_lineColor;
            }
        }
        
        CGFloat alterViewHeight = 44+20+_messageLab.height+5+_titleLab.height+20;
        self.frame = CGRectMake(KScreenWidth/2-alterViewWidth/2, KScreenHeight/2-(alterViewHeight)/2, alterViewWidth, alterViewHeight);
    
    }
    return self;
}


+(MKAlterView *)alterViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles
{
    return [[self alloc]initWithTitle:title message:message delegate:delegate cancleButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles];
}

-(void)clickBtnTarget:(UIButton *)sender
{
    if ([delegate respondsToSelector:@selector(MKAlterViewButtonClickWithAlterView:index:)]) {
        [delegate MKAlterViewButtonClickWithAlterView:self index:sender.tag];
    }
}

@end
