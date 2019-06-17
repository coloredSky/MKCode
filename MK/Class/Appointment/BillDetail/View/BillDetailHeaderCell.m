//
//  BillDetailHeaderCell.m
//  MK
//
//  Created by 周洋 on 2019/6/17.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "BillDetailHeaderCell.h"
#import "UserBillListModel.h"

@interface BillDetailHeaderCell()
@property (weak, nonatomic) IBOutlet UIImageView *billIma;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLab;

@end

@implementation BillDetailHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.billIma.layer.masksToBounds = YES;
    self.billIma.layer.cornerRadius = 6;
    self.billIma.contentMode = UIViewContentModeScaleAspectFill;
}

-(void)cellRefreshDataWithUserBillListModel:(UserBillListModel *)billModel
{
    [self.billIma sd_setImageWithURL:[NSURL URLWithString:billModel.course_post] placeholderImage:nil];
    self.billIma.backgroundColor = [UIColor redColor];
    self.courseNameLab.text = billModel.course_name;
}

@end
