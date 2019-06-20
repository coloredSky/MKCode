//
//  BillDetailPayTimeCell.h
//  MK
//
//  Created by 周洋 on 2019/4/8.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKBaseTableViewCell.h"
@class UserBillListModel;

NS_ASSUME_NONNULL_BEGIN

@interface BillDetailPayTimeCell : MKBaseTableViewCell


-(void)cellRefreshOrderDataWithUserBillListModel:(UserBillListModel *)billModel;

/**
 支付记录

 @param indexPath index
 @param titleArr 左边标题
 @param billModel model
 */
-(void)cellRefreshPayRecordDataWithIndexPath:(NSIndexPath *)indexPath sectionTitleArr:(NSArray <NSString *>*)titleArr UserBillListModel:(UserBillListModel *)billModel;

@end

NS_ASSUME_NONNULL_END
