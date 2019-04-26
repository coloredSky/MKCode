//
//  MKPlaceholderView.h
//  MK
//
//  Created by 周洋 on 2019/4/22.
//  Copyright © 2019年 周洋. All rights reserved.
//
typedef NS_ENUM(NSUInteger, MKPlaceWorderViewDisplayType) {
    MKPlaceWorderViewDisplayTypeNoData,
    MKPlaceWorderViewDisplayTypeNoNetworking,
    MKPlaceWorderViewDisplayTypeNoOrder,
    MKPlaceWorderViewDisplayTypeNoBookMark
};

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKPlaceholderViewDelegate <NSObject>
@optional
-(void)placeholderViewClickWithDisplayType:(MKPlaceWorderViewDisplayType )placeholderDisplayType;
@end

@interface MKPlaceholderView : UIView
@property (nonatomic, assign) id<MKPlaceholderViewDelegate> delegate;
@property(nonatomic, assign)MKPlaceWorderViewDisplayType displayType;
@end

NS_ASSUME_NONNULL_END
