//
//  SchoolSelectedCell.m
//  MK
//
//  Created by 周洋 on 2019/6/23.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "SchoolSelectedCell.h"

@interface SchoolSelectedCell()

@property (weak, nonatomic) IBOutlet UIImageView *lineIma;

@end

@implementation SchoolSelectedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.contentLab setFont:MKFont(14) textColor:K_Text_grayColor withBackGroundColor:nil];
    self.lineIma.backgroundColor = K_Line_lineColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.lineIma.height = K_Line_lineWidth;
}


@end
