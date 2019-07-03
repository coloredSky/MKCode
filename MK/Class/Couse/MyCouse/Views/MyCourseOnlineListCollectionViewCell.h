//
//  MyCourseOnlineListCollectionViewCell.h
//  MK
//
//  Created by 周洋 on 2019/4/10.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCourseListManager.h"

NS_ASSUME_NONNULL_BEGIN

/**
 线上课程collectionCell
 */
@interface MyCourseOnlineListCollectionViewCell : UICollectionViewCell

-(void)cellRefreshDataWithIndexPath:(NSIndexPath *)indexPath withShowType:(UserCourseListViewShowType )listViewShowType courseList:( NSArray <MKCourseListModel *>*)courseList;

@end

NS_ASSUME_NONNULL_END
