//
//  MyCenterTopCell.h
//  MK
//
//  Created by ginluck on 2019/3/18.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyCenterTopCell : UICollectionViewCell
@property(nonatomic,weak)IBOutlet UIImageView * myCenterImage;
@property(nonatomic,weak)IBOutlet UILabel * myCenterLab;
@property(nonatomic,weak)IBOutlet UIView * whiteView;
@property(nonatomic,weak)IBOutlet UIView * bgView;
@end

NS_ASSUME_NONNULL_END
