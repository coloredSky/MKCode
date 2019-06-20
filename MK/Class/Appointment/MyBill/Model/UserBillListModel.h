//
//  UserBillListModel.h
//  MK
//
//  Created by 周洋 on 2019/6/17.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserBillPaymentModel;

NS_ASSUME_NONNULL_BEGIN

@interface UserBillListModel : NSObject

@property (nonatomic, copy) NSString *trade_no;//订单号
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *course_id;
@property (nonatomic, copy) NSString *unpaid_amount_jpy;
@property (nonatomic, copy) NSString *unpaid_amount_cny;
@property (nonatomic, copy) NSString *status_zh;
@property (nonatomic, copy) NSString *course_name;//课程名字
@property (nonatomic, copy) NSString *log_date;
@property (nonatomic, copy) NSString *is_online;
@property (nonatomic, copy) NSString *course_post;//课程图片
@property (nonatomic, strong) NSArray <UserBillPaymentModel *>*payments;//付款记录

@end

@interface UserBillPaymentModel : NSObject

@property (nonatomic, copy) NSString *pay_sn;//支付单号
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *status_zh;//支付状态
@property (nonatomic, copy) NSString *pay_type;//支付方式
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *pay_time;//支付时间
@property (nonatomic, copy) NSString *currency;//支付单位
@property (nonatomic, copy) NSString *amount;//支付金额

@end

NS_ASSUME_NONNULL_END
