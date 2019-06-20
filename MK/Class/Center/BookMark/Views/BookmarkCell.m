//
//  BookmarkCell.m
//  MK
//
//  Created by ginluck on 2019/3/22.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "BookmarkCell.h"
#import "BookMarkModel.h"

@interface BookmarkCell()
@property(nonatomic,weak)IBOutlet UIImageView * courseImage;
@property(nonatomic,weak)IBOutlet UILabel * courseName;
@property(nonatomic,weak)IBOutlet UILabel * coursePlace;
@property(nonatomic,weak)IBOutlet UILabel * coursePage;
@property (weak, nonatomic) IBOutlet UIView *lineIma;

@end
@implementation BookmarkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_courseName setFont:MKBoldFont(12) textColor:K_Text_BlackColor withBackGroundColor:nil];
    [_coursePlace setFont:MKFont(10) textColor:K_Text_grayColor withBackGroundColor:nil];
    [_coursePage setFont:MKFont(9) textColor:K_Text_grayColor withBackGroundColor:nil];
    self.lineIma.height = K_Line_lineWidth;
    self.lineIma.backgroundColor = K_Line_lineColor;
}

-(void)cellRefreshDataWithBookMarkListModel:(BookMarkListModel *)bookModel
{
    [self.courseImage sd_setImageWithURL:[NSURL URLWithString:bookModel.course_Image] placeholderImage:nil];
    self.courseName.text = bookModel.category;
    self.coursePlace.text = bookModel.name;
    self.coursePage.text =@"";
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
