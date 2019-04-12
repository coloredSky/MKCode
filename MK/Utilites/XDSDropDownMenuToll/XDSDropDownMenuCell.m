//
//  XDSDropDownMenuCell.m
//  MK
//
//  Created by 周洋 on 2019/4/11.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "XDSDropDownMenuCell.h"
@interface XDSDropDownMenuCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *lineIma;

@end
@implementation XDSDropDownMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = K_BG_blackColor;
    [_titleLab setFont:K_Font_Text_Normal textColor:K_Text_WhiteColor withBackGroundColor:nil];
    _lineIma.backgroundColor = K_Line_lineColor;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLab.frame = CGRectMake(K_Padding_LeftPadding, 0, self.contentView.width-K_Padding_LeftPadding*2, self.contentView.height);
    self.lineIma.frame = CGRectMake(0, self.contentView.height-K_Line_lineWidth, self.contentView.width, K_Line_lineWidth);
}

-(void)cellRefreshDataWithContentString:(NSString *)contentString
{
    self.titleLab.text = contentString;
}

@end
