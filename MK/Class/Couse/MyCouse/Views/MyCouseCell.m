//
//  MyCouseCell.m
//  MK
//
//  Created by ginluck on 2019/3/18.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MyCouseCell.h"
@interface MyCouseCell()
@property (weak, nonatomic) IBOutlet UIImageView *courseImage;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLab;
@property (weak, nonatomic) IBOutlet UILabel *courseDetailLab;
@property (weak, nonatomic) IBOutlet UILabel *courseStatusLab;
@property (weak, nonatomic) IBOutlet UIImageView *lineIma;

//layout
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeightConstritraints;

@end
@implementation MyCouseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_courseNameLab setFont:MKBoldFont(14) textColor:K_Text_BlackColor withBackGroundColor:nil];
    [_courseDetailLab setFont:K_Font_Text_Min_Max textColor:K_Text_grayColor withBackGroundColor:nil];
    [_courseStatusLab setFont:K_Font_Text_Normal_Max textColor:K_Text_grayColor withBackGroundColor:nil];
    _lineIma.backgroundColor = K_Line_lineColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.lineHeightConstritraints.constant = K_Line_lineWidth;
}

-(void)cellRefreshDataWithIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        self.lineIma.hidden = YES;
    }else{
        self.lineIma.hidden = NO;
    }
    self.courseImage.image = [UIImage imageNamed:@"home_course"];
    self.courseNameLab.text = @"日语基础";
    self.courseDetailLab.text = @"大阪大学博士";
    self.courseStatusLab.text = @"99%";
}
@end
