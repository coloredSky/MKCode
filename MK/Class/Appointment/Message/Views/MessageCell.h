//
//  MessageCell.h
//  MK
//
//  Created by 周洋 on 2019/3/27.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKBaseTableViewCell.h"
@class MKMessageModel;

NS_ASSUME_NONNULL_BEGIN

@interface MessageCell : MKBaseTableViewCell

-(void)cellRefreshDataWithMKMessageMode:(MKMessageModel *)messageModel;

@end

NS_ASSUME_NONNULL_END
