//
//  AppoinementReplyModel.h
//  MK
//
//  Created by 周洋 on 2019/6/13.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppoinementReplyModel : NSObject
@property (nonatomic, copy) NSString *reply_id;
@property (nonatomic, copy) NSString *apply_id;
@property (nonatomic, copy) NSString *apply_type;
@property (nonatomic, copy) NSString *from_uid;
@property (nonatomic, copy) NSString *from_type;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, copy) NSString *uname;
@property (nonatomic, assign) CGFloat rowHeight;
@end

NS_ASSUME_NONNULL_END
