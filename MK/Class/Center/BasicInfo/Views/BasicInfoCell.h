//
//  BasicInfoCell.h
//  MK
//
//  Created by ginluck on 2019/3/30.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class userInfo;
@class university;

NS_ASSUME_NONNULL_BEGIN

@interface BasicInfoCell : UITableViewCell

@property (nonatomic, copy) void(^BasicInfoCellTFContentChangeBlock)(NSString *contentString,UITextField *sender);

@property(nonatomic,weak)IBOutlet UITextField * textField;
@property(nonatomic,weak)IBOutlet UILabel  * ttLabel;


//基本信息
-(void)cellBasicInfoRefreshDataWithUserInfo:(userInfo *)userInfoModel indexPath:(NSIndexPath *)indexPath;

//志愿
-(void)cellUniversityRefreshDataWithUniversity:(university *)universityModel indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
