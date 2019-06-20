//
//  BillListCollectionViewCell.h
//  MK
//
//  Created by 周洋 on 2019/4/4.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserBillListModel;

NS_ASSUME_NONNULL_BEGIN

@interface BillListCollectionViewCell : UICollectionViewCell
-(void)cellRefreshDataWithUserBillListModel:(UserBillListModel *)billModel;
@end

NS_ASSUME_NONNULL_END
