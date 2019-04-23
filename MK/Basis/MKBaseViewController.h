//
//  MKBaseViewController.h
//  MK
//
//  Created by 周洋 on 2019/3/8.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface MKBaseViewController : UIViewController
@property (nonatomic, assign) BOOL placeholderViewShow;
//
-(void)reloadPlacehorldViewWithFrame:(CGRect )frame placehorldDisplayType:(MKPlaceWorderViewDisplayType )displayType;
//登录注册
-(void)loginAlterViewShow;
-(void)loginOutAlterViewShow;

@end

NS_ASSUME_NONNULL_END
