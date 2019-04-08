//
//  BillDetailPayTimeCell.m
//  MK
//
//  Created by 周洋 on 2019/4/8.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "BillDetailPayTimeCell.h"
@interface BillDetailPayTimeCell()
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *rightContentLab;

@end
@implementation BillDetailPayTimeCell

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [_leftTitleLab setFont:K_Font_Text_Normal_Max textColor:K_Text_grayColor withBackGroundColor:nil];
    _leftTitleLab.text = @"交费日期";
    [_rightContentLab setFont:K_Font_Text_Normal_Max textColor:K_Text_BlackColor withBackGroundColor:nil];
    _rightContentLab.textAlignment = NSTextAlignmentRight;
    _rightContentLab.numberOfLines = 0;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftTitleLab.frame = CGRectMake(K_Padding_LeftPadding, KScaleHeight(28)-KScaleHeight(10), KScaleWidth(100), KScaleHeight(20));
    CGSize size = [self.rightContentLab.text getStrSizeWithSize:CGSizeMake(KScaleWidth(150), 3000) font:self.rightContentLab.font];
    self.rightContentLab.frame = CGRectMake(self.contentView.width-K_Padding_LeftPadding-KScaleWidth(150), self.leftTitleLab.topY, KScaleWidth(150), size.height);
}

-(void)cellRefreshDataWithIndexPath:(NSIndexPath *)indexPath
{
    self.leftTitleLab.text = @"交费日期";
    self.rightContentLab.text = @"2019-01-18 23:49:21\nJPY 300,000\n 支付宝 \n单号9581\n剩余 JPY 215,200\n状态 未确认";
}

@end
