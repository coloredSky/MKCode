//
//  BookmarkCell.h
//  MK
//
//  Created by ginluck on 2019/3/22.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKBaseTableViewCell.h"
@class BookMarkListModel;

NS_ASSUME_NONNULL_BEGIN

@interface BookmarkCell : MKBaseTableViewCell
-(void)cellRefreshDataWithBookMarkListModel:(BookMarkListModel *)bookModel;
@end

NS_ASSUME_NONNULL_END
