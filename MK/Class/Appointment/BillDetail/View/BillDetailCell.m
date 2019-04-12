//
//  BillDetailCell.m
//  MK
//
//  Created by 周洋 on 2019/4/8.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "BillDetailCell.h"
@interface BillDetailCell()
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *rightContentLab;

@property (nonatomic, strong) NSArray *leftTitleArr;
@end
@implementation BillDetailCell

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _leftTitleArr = @[@"单号",@"套餐",@"交费日期",@"下次交费日期",@"登录日期",@"登录人",@"备注"];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [_leftTitleLab setFont:K_Font_Text_Normal_Max textColor:K_Text_grayColor withBackGroundColor:nil];
    [_rightContentLab setFont:K_Font_Text_Normal_Max textColor:K_Text_grayColor withBackGroundColor:nil];
    _rightContentLab.textAlignment = NSTextAlignmentRight;
    _rightContentLab.numberOfLines = 0;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftTitleLab.frame = CGRectMake(K_Padding_LeftPadding, 0, KScaleWidth(100), self.contentView.height);
    self.rightContentLab.frame = CGRectMake(self.contentView.width-K_Padding_LeftPadding-KScaleWidth(150), 0, KScaleWidth(150), self.contentView.height);
}

-(void)cellRefreshDataWithIndexPath:(NSIndexPath *)indexPath
{
    self.leftTitleLab.text = self.leftTitleArr[indexPath.row];
    if (indexPath.row ==0) {
        self.rightContentLab.text = @"KOKO-3737660f3f";
    }else if (indexPath.row ==1){
        self.rightContentLab.text = @"移动大王卡";
    }else if (indexPath.row ==2){
        self.rightContentLab.text = @"";
    }else if (indexPath.row ==3){
        self.rightContentLab.text = @"2019-01-18 23:49:21";
    }else if (indexPath.row ==4){
        self.rightContentLab.text = @"2019-01-18 23:49:21";
    }else if (indexPath.row ==1){
        self.rightContentLab.text = @"";
    }else if (indexPath.row ==5){
        self.rightContentLab.text = @"";
    }else{
         self.rightContentLab.text = @"";
    }
}
@end
