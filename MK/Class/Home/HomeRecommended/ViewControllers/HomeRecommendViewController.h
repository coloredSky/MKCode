//
//  HomeRecommendViewController.h
//  MK
//
//  Created by 周洋 on 2019/3/18.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeRecommendViewController : MKBaseViewController
@property (nonatomic, copy) NSString *categoryID;//课程类型ID

-(void)homeRecommendfreshCourseListData;
@end

NS_ASSUME_NONNULL_END
