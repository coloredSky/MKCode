//
//  BillDetailHeaderCell.h
//  MK
//
//  Created by 周洋 on 2019/6/17.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserBillListModel;

NS_ASSUME_NONNULL_BEGIN

@interface BillDetailHeaderCell : UITableViewCell

-(void)cellRefreshDataWithUserBillListModel:(UserBillListModel *)billModel;

@end

NS_ASSUME_NONNULL_END
