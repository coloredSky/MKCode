//
//  AppointmentTeacherReplyCell.h
//  MK
//
//  Created by 周洋 on 2019/4/1.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKBaseTableViewCell.h"
@class AppoinementReplyModel;

NS_ASSUME_NONNULL_BEGIN

@interface AppointmentTeacherReplyCell : MKBaseTableViewCell
-(void)cellRefreshDataWithAppoinementReplyModel:(AppoinementReplyModel *)replyModel;
@end

NS_ASSUME_NONNULL_END
