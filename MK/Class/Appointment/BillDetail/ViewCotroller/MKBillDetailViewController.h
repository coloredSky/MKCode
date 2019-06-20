//
//  MKBillDetailViewController.h
//  MK
//
//  Created by 周洋 on 2019/4/8.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKNavViewController.h"
@class UserBillListModel;

NS_ASSUME_NONNULL_BEGIN

@interface MKBillDetailViewController : MKNavViewController

@property (nonatomic, strong) UserBillListModel *billModel;
@end

NS_ASSUME_NONNULL_END
