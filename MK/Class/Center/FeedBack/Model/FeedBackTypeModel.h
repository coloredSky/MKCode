//
//  FeedBackTypeModel.h
//  MK
//
//  Created by 周洋 on 2019/6/20.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeedBackTypeModel : NSObject

@property (nonatomic, copy) NSString *feedBackID;
@property (nonatomic, copy) NSString *feedBackTitle;
@property (nonatomic, assign) BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
