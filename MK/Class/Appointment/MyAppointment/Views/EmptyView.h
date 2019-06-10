//
//  EmptyView.h
//  MK
//
//  Created by 周洋 on 2019/6/3.
//  Copyright © 2019 周洋. All rights reserved.
//

typedef NS_ENUM(NSUInteger, EmptyViewShowType) {
    EmptyViewShowTypeUnknown,
    EmptyViewShowTypeAppointmentNoLogin,
    EmptyViewShowTypeNoAppointment,
};

#import <UIKit/UIKit.h>
@class EmptyView;

NS_ASSUME_NONNULL_BEGIN

@protocol EmptyViewDelegate <NSObject>

-(void)emptyViewClickTargetWithView:(EmptyView *)view;

@end

@interface EmptyView : UIView
@property (nonatomic, assign) EmptyViewShowType showType;
@property (nonatomic, assign) id<EmptyViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
