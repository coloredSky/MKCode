//
//  AppointmentTapView.h
//  MK
//
//  Created by 周洋 on 2019/3/31.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class AppointmentTapView;
@protocol AppointmentTapViewDelegate <NSObject>
@optional
-(void)appointmentTapViewTapClickWithView:(AppointmentTapView *)tapView;
@end

@interface AppointmentTapView : UIView
@property (nonatomic, assign) id<AppointmentTapViewDelegate> delegate;

@property (nonatomic, assign) BOOL isSelected;//选中
@property (nonatomic, assign) BOOL canEditing;//是否能编辑
@property (nonatomic, copy) NSString *textString;//设置字
@property (nonatomic, copy) NSString *placeholderString;//设置默认字
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;
@end

NS_ASSUME_NONNULL_END
