//
//  MyCourseOnlineListCollectionViewCell.m
//  MK
//
//  Created by 周洋 on 2019/4/10.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MyCourseOnlineListCollectionViewCell.h"
#import "MKCourseListModel.h"

@interface MyCourseOnlineListCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *topLine;
@property (weak, nonatomic) IBOutlet UIImageView *courseIma;
@property (weak, nonatomic) IBOutlet UIImageView *lineIma;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLab;
@property (weak, nonatomic) IBOutlet UILabel *courseTeacherLab;
@property (weak, nonatomic) IBOutlet UILabel *courseStatusLab;
@end

@implementation MyCourseOnlineListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_courseNameLab setFont:MKBoldFont(14) textColor:K_Text_BlackColor withBackGroundColor:nil];
    [_courseTeacherLab setFont:K_Font_Text_Min_Max textColor:K_Text_grayColor withBackGroundColor:nil];
    [_courseStatusLab setFont:MKBoldFont(15) textColor:K_Text_grayColor withBackGroundColor:nil];
    _courseStatusLab.textAlignment = NSTextAlignmentRight;
    _courseStatusLab.text = @"";
    _lineIma.backgroundColor = K_Line_lineColor;
    _topLine.backgroundColor = K_Line_lineColor;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.courseIma.frame = CGRectMake(0, self.contentView.height/2-KScaleWidth(23), KScaleWidth(75), KScaleWidth(46));
    self.courseNameLab.frame = CGRectMake(_courseIma.rightX+KScaleWidth(10), _courseIma.topY, self.contentView.width-_courseIma.rightX-KScaleWidth(10), KScaleHeight(20));
    self.courseTeacherLab.frame = CGRectMake(_courseNameLab.leftX, _courseIma.bottomY-KScaleHeight(20), _courseNameLab.width, KScaleHeight(20));
    self.lineIma.frame = CGRectMake(_courseNameLab.leftX, self.contentView.height-K_Line_lineWidth, self.contentView.width-_courseNameLab.leftX-K_Padding_LeftPadding, K_Line_lineWidth);
    self.courseStatusLab.frame = CGRectMake(self.lineIma.rightX-KScaleWidth(40), self.contentView.height/2-6, KScaleWidth(40), 20);
        self.topLine.frame = CGRectMake(_courseNameLab.leftX, 0, self.contentView.width-_courseNameLab.leftX-K_Padding_LeftPadding, K_Line_lineWidth);
}

-(void)cellRefreshDataWithIndexPath:(NSIndexPath *)indexPath withShowType:(UserCourseListViewShowType )listViewShowType courseList:( NSArray <MKCourseListModel *>*)courseList
{
    if (courseList.count < 3) {
        self.lineIma.hidden = indexPath.row == courseList.count -1 ?YES : NO;
    }else{
        self.topLine.hidden = indexPath.row%3 == 0 ?NO:YES;
        if ((indexPath.row+1)%3==0) {
            self.lineIma.hidden = YES;
        }else{
            self.lineIma.hidden = NO;
        }
    }
    MKCourseListModel *courseModel = courseList[indexPath.row];
    [self.courseIma sd_setImageWithURL:[NSURL URLWithString:courseModel.courseImage] placeholderImage:K_MKPlaceholderImage4_3];
    self.courseNameLab.text = courseModel.courseName;
    self.courseTeacherLab.text = courseModel.teacherNmae;
    if (listViewShowType == UserCourseListViewShowTypeOnline) {
        self.courseStatusLab.text = @"";
    }else{
        self.courseStatusLab.text = courseModel.process;
    }
}

@end
