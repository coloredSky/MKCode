//
//  BillDetailPayTimeCell.m
//  MK
//
//  Created by 周洋 on 2019/4/8.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "BillDetailPayTimeCell.h"
#import "UserBillListModel.h"

@interface BillDetailPayTimeCell()
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *rightContentLab;

@end
@implementation BillDetailPayTimeCell

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [_leftTitleLab setFont:MKFont(13) textColor:K_Text_grayColor withBackGroundColor:nil];
    _leftTitleLab.text = @"";
    [_rightContentLab setFont:MKFont(13) textColor:K_Text_grayColor withBackGroundColor:nil];
    _rightContentLab.text = @"";
}

-(void)cellRefreshOrderDataWithUserBillListModel:(UserBillListModel *)billModel
{
    self.leftTitleLab.text =  billModel.trade_no;
    self.rightContentLab.text = [NSString stringWithFormat:@"JPY %@",billModel.unpaid_amount_jpy];
}

-(void)cellRefreshPayRecordDataWithIndexPath:(NSIndexPath *)indexPath sectionTitleArr:(NSArray <NSString *>*)titleArr UserBillListModel:(UserBillListModel *)billModel
{
    UserBillPaymentModel *paymentModel  = billModel.payments[indexPath.section -2];
    self.leftTitleLab.text = titleArr[indexPath.row];
    switch (indexPath.row) {
        case 0:
            {
                self.leftTitleLab.textColor = K_Text_BlackColor;
                self.leftTitleLab.text = paymentModel.pay_time;
            }
            break;
        case 1:
        {
            self.rightContentLab.text = [NSString stringWithFormat:@"%@ %@%@",paymentModel.pay_type,paymentModel.currency,paymentModel.amount];
        }
            break;
        case 2:
        {
            self.rightContentLab.text = paymentModel.pay_sn;
        }
            break;
        case 3:
        {
            self.rightContentLab.text = paymentModel.status_zh;
        }
            break;
        case 4:
        {
            self.rightContentLab.text = [NSString timeTransformWithDate:paymentModel.pay_time WithFormModel:@"YYYY-MM-dd HH:mm:ss" toModel:@"YYYY-MM-dd"];
        }
            break;
            
        default:
            break;
    }
}

@end
