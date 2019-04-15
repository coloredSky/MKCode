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

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, copy) NSString *textString;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;
@end

NS_ASSUME_NONNULL_END
