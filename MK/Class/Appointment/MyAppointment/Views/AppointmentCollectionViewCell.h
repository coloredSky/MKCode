//
//  AppointmentCollectionViewCell.h
//  MK
//
//  Created by 周洋 on 2019/3/20.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppointmentManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppointmentCollectionViewCell : UICollectionViewCell
-(void)cellRefreshDataWithDisplayType:(AppointmentDisplayType )displayType;
@end

NS_ASSUME_NONNULL_END
