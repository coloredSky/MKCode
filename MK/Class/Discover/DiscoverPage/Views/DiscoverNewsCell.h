//
//  DiscoverNewsCell.h
//  MK
//
//  Created by 周洋 on 2019/3/15.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKBaseTableViewCell.h"
@class DiscoverNewsModel;

NS_ASSUME_NONNULL_BEGIN

/**
 发现模块中的新闻cell
 */
@interface DiscoverNewsCell : MKBaseTableViewCell

-(void)cellRefreshDataWithDiscoverNewsModel:(DiscoverNewsModel *)newsModel;
@end

NS_ASSUME_NONNULL_END
