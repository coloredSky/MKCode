//
//  MyCourseListCell.h
//  MK
//
//  Created by 周洋 on 2019/4/10.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKBaseTableViewCell.h"
#import "UserCourseListManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyCourseListCell : MKBaseTableViewCell
-(void)cellRefreshDataWithIndexPath:(NSIndexPath *)indexPath withShowType:(UserCourseListViewShowType )listViewShowType;
@end

NS_ASSUME_NONNULL_END
