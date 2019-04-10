//
//  MyCourseListCell.m
//  MK
//
//  Created by 周洋 on 2019/4/10.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MyCourseListCell.h"
@interface MyCourseListCell()
@property (weak, nonatomic) IBOutlet UIImageView *courseIma;
@property (weak, nonatomic) IBOutlet UIImageView *lineIma;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLab;
@property (weak, nonatomic) IBOutlet UILabel *courseTeacherLab;
@property (weak, nonatomic) IBOutlet UILabel *courseStatusLab;
//layout
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeightConstritraints;
@end
@implementation MyCourseListCell
- (void)awakeFromNib {
    [super awakeFromNib];
    [_courseNameLab setFont:MKBoldFont(14) textColor:K_Text_BlackColor withBackGroundColor:nil];
    [_courseTeacherLab setFont:K_Font_Text_Min_Max textColor:K_Text_grayColor withBackGroundColor:nil];
    [_courseStatusLab setFont:MKBoldFont(15) textColor:K_Text_grayColor withBackGroundColor:nil];
    _courseStatusLab.textAlignment = NSTextAlignmentRight;
    _courseStatusLab.text = @"";
    _lineIma.backgroundColor = K_Line_lineColor;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.courseIma.frame = CGRectMake(K_Padding_Home_LeftPadding, self.contentView.height/2-KScaleWidth(23), KScaleWidth(75), KScaleWidth(46));
    self.courseNameLab.frame = CGRectMake(_courseIma.rightX+KScaleWidth(10), _courseIma.topY, self.contentView.width-_courseIma.rightX-KScaleWidth(10), KScaleHeight(20));
    self.courseTeacherLab.frame = CGRectMake(_courseNameLab.leftX, _courseIma.bottomY-KScaleHeight(20), _courseNameLab.width, KScaleHeight(20));
    
    self.lineIma.frame = CGRectMake(_courseNameLab.leftX, self.contentView.height-K_Line_lineWidth, self.contentView.width-_courseNameLab.leftX-K_Padding_Home_LeftPadding, K_Line_lineWidth);
    self.courseStatusLab.frame = CGRectMake(self.lineIma.rightX-KScaleWidth(40), 0, KScaleWidth(40), self.contentView.height);
}

-(void)cellRefreshDataWithIndexPath:(NSIndexPath *)indexPath withShowType:(UserCourseListViewShowType )listViewShowType
{
    if (indexPath.row==6) {
        self.lineIma.hidden = YES;
    }else{
        self.lineIma.hidden = NO;
    }
    self.courseIma.image = [UIImage imageNamed:@"home_course"];
    self.courseNameLab.text = @"日语基础";
    self.courseTeacherLab.text = @"大阪大学博士";
    if (listViewShowType == UserCourseListViewShowTypeOnline) {
        self.courseStatusLab.text = @"";
    }else if (listViewShowType == UserCourseListViewShowTypeOfflineUnderWay) {
        self.courseStatusLab.text = @"99%";
    }else if (listViewShowType == UserCourseListViewShowTypeOfflineNotStart) {
        self.courseStatusLab.text = @"未开";
    }else if (listViewShowType == UserCourseListViewShowTypeOfflineHaveEnd) {
        self.courseStatusLab.text = @"完结";
    }
}

@end
