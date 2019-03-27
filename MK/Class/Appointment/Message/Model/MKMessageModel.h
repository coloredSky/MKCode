//
//  MKMessageModel.h
//  MK
//
//  Created by 周洋 on 2019/3/27.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMessageModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) BOOL cellSelected;
@end

NS_ASSUME_NONNULL_END
