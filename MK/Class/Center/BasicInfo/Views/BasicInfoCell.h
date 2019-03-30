//
//  BasicInfoCell.h
//  MK
//
//  Created by ginluck on 2019/3/30.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasicInfoCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UITextField * textField;
@property(nonatomic,weak)IBOutlet UILabel  * ttLabel;
@end

NS_ASSUME_NONNULL_END
