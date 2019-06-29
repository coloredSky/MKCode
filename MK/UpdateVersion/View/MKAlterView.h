//
//  MKAlterView.h
//  MK
//
//  Created by 周洋 on 2019/6/28.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKAlterView;

NS_ASSUME_NONNULL_BEGIN

@protocol MKAlterViewDelegate <NSObject>

@optional

-(void)MKAlterViewButtonClickWithAlterView:(MKAlterView *)alterView index:(NSInteger )index;

@end

@interface MKAlterView : UIView

@property (nonatomic, assign) id<MKAlterViewDelegate> delegate;

@property (nonatomic, copy) NSString *downloadUrl;//下载地址
@property (nonatomic, assign) BOOL isForce;//是否强制更新

+(MKAlterView *)alterViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles;

@end

NS_ASSUME_NONNULL_END
