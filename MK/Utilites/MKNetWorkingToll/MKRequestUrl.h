//
//  MKRequestUrl.h
//  MK
//
//  Created by 周洋 on 2019/4/16.
//  Copyright © 2019年 周洋. All rights reserved.
//


#ifndef MKRequestUrl_h
#define MKRequestUrl_h

//#ifdef DEBUG
static NSString * const KMKBaseServerRequestUrl  = @"http://test.class.jastudy.com";
//#else
//static NSString * const KMKBaseServerRequestUrl  = @"https://class.jastudy.com";
//#endif

/*
 *首页
 */
//所有课程分类
static NSString * const K_MK_Home_AllCategoryList_Url  = @"/base/course/category";
//课程列表
static NSString * const K_MK_Home_CourseList_Url  = @"/api/course/courseList";
//课程详情
static NSString * const K_MK_Course_CourseDetail_Url  = @"/api/course/courseDetail";

//发现
static NSString * const K_MK_Discover_NewsList_Url  = @"/api/posts/getposts";


/*
 *登录、注册
 */
//登录
static NSString * const K_MK_Login_url  = @"/user/base/auth";
//获取验证码
static NSString * const K_MK_GetPhoneCode_url  = @"/user/base/sms";
//注册接口
static NSString * const K_MK_Register_Url  = @"/user/base/reg";

#endif /* MKRequestUrl_h */
