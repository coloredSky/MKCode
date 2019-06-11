//
//  MyCenterHeaderView.h
//  MK
//
//  Created by ginluck on 2019/3/18.
//  Copyright © 2019年 周洋. All rights reserved.
//

typedef NS_ENUM(NSUInteger, MyCenterHeaderViewOperationType) {
    MyCenterHeaderViewOperationTypeEditUserInfo = 1,
    MyCenterHeaderViewOperationTypeLoginIn,
};

@protocol MyCenterHeaderViewDelegate <NSObject>

-(void)headerViewBtnClickWithOperationType:(MyCenterHeaderViewOperationType )operationType;

@end
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyCenterHeaderView : UIView

@property(nonatomic,assign)id<MyCenterHeaderViewDelegate>delegate;

-(void)refreshData;
@end

NS_ASSUME_NONNULL_END
