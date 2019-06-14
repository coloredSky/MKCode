//
//  DropDownCell.m
//  MK
//
//  Created by 周洋 on 2019/5/29.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "DropDownCell.h"
@interface DropDownCell()
@property (weak, nonatomic) IBOutlet UIImageView *lineIma;
@end
@implementation DropDownCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = K_BG_blackColor;
    [_titleLab setFont:K_Font_Text_Normal textColor:K_Text_WhiteColor withBackGroundColor:nil];
    _lineIma.backgroundColor = K_Line_lineColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
