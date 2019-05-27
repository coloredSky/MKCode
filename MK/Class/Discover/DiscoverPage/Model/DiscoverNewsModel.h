//
//  DiscoverNewsModel.h
//  MK
//
//  Created by 周洋 on 2019/5/24.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DiscoverNewsModel : NSObject
@property (nonatomic, copy)  NSString*newsID;
@property (nonatomic, copy)  NSString*newsTitle;
@property (nonatomic, copy)  NSString*newsDigest;
@property (nonatomic, copy)  NSString*newsContent;
@property (nonatomic, copy)  NSString*newsImage;
@property (nonatomic, copy)  NSString*newsCreateTime;
@property (nonatomic, copy) NSString *newsCreateWeek;//星期几
@property (nonatomic, copy) NSString *newsCreateDate;//几月几日
@end

NS_ASSUME_NONNULL_END
