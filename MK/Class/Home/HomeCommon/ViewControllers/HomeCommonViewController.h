//
//  HomeCommonViewController.h
//  MK
//
//  Created by 周洋 on 2019/3/19.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeCommonViewController : MKBaseViewController
@property (nonatomic, copy) NSString *categoryID;//课程类型ID

-(void)homeCommonrefreshCourseListDataWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
