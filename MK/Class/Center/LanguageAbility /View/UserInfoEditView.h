//
//  UserInfoEditView.h
//  MK
//
//  Created by 周洋 on 2019/6/21.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoEditView : UIView

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UITextField *contentTF;
@property (nonatomic, strong) UIImageView * dropDownIma;

@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *contentString;

@property (nonatomic, copy) void(^UserInfoEditViewContenTextChangeBlock)(UITextField *contentTF,NSString *contentString);
@end

NS_ASSUME_NONNULL_END
