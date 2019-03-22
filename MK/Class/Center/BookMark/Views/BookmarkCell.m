//
//  BookmarkCell.m
//  MK
//
//  Created by ginluck on 2019/3/22.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "BookmarkCell.h"
@interface BookmarkCell()
@property(nonatomic,weak)IBOutlet UIImageView * courseImage;
@property(nonatomic,weak)IBOutlet UILabel * courseName;
@property(nonatomic,weak)IBOutlet UILabel * coursePlace;
@property(nonatomic,weak)IBOutlet UILabel * coursePage;
@end
@implementation BookmarkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_courseName setFont:MKBoldFont(12) textColor:K_Text_BlackColor withBackGroundColor:nil];
    [_coursePlace setFont:MKFont(10) textColor:K_Text_grayColor withBackGroundColor:nil];
    [_coursePage setFont:MKFont(9) textColor:K_Text_grayColor withBackGroundColor:nil];
}
-(void)cellRefreshData
{
    self.courseImage.image = KImageNamed(@"home_course");
    self.courseName.text = @"日本美术大学面试指南";
    self.coursePlace.text = @"每刻美术学院";
    self.coursePage.text =@"24";
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
