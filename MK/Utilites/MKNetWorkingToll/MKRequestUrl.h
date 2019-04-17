//
//  MKRequestUrl.h
//  MK
//
//  Created by 周洋 on 2019/4/16.
//  Copyright © 2019年 周洋. All rights reserved.
//


#ifndef MKRequestUrl_h
#define MKRequestUrl_h

#ifndef DEBUG
static NSString * const KMKBaseServerRequestUrl  = @"http://test.class.jastudy.com";
#else
static NSString * const KMKBaseServerRequestUrl  = @"https://class.jastudy.com";
#endif

//首页
//所有课程分类
static NSString * const K_MK_Home_AllCategoryList_Url  = @"/base/course/category";
//课程列表
static NSString * const K_MK_Home_CourseList_Url  = @"/base/course/list";


#endif /* MKRequestUrl_h */
