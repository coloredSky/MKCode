//
//  MKDropDownMenu.h
//  MK
//
//  Created by 周洋 on 2019/5/29.
//  Copyright © 2019 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MKDropDownMenu;
@protocol MKDropDownMenuDelegate <NSObject>

@optional
-(void)dropDownMenu:(MKDropDownMenu *)downMenuView didSelectedWithIndex:(NSInteger )index;
@end


@interface MKDropDownMenu : UIView

@property (nonatomic, assign) id<MKDropDownMenuDelegate> delegate;
//+(instancetype)showDropDownMenuWithView:(UIView *)sender andTitle;

- (void)showDropDownMenuWithViewFrame:(CGRect )tapViewFrame arrayOfTitle:(NSArray *)titleArr;
@end

NS_ASSUME_NONNULL_END
