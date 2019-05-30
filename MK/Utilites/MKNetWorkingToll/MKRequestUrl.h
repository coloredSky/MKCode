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
 *预约
 */
//请假
//获取请假课程列表
static NSString * const K_MK_AskForLeave_CourseList_Url  = @"/api/user/getUserClass";
//x新增请假申请
static NSString * const K_MK_AddAskForLeave_Url  = @"/api/user/AddApplyLeave";
//编辑请假申请
static NSString * const K_MK_EditAskForLeave_Url  = @"/api/user/UpdateApplyLeave";

//预约
//获取预约时间
static NSString * const K_MK_MeetingTime_Url  = @"/api/user/getReservationTimeList";
//获取预约目的
static NSString * const K_MK_MeetingReservation_Url  = @"/api/user/getReservationList";
//新增预约相谈
static NSString * const K_MK_AddMeeting_Url  = @"/api/user/AddApplyReservation";

//换班
//换班列表
static NSString * const K_MK_ChangeClass_CourseList_Url  = @"/api/user/getStudentClass";

/*
 *登录、注册
 */
//登录
static NSString * const K_MK_Login_url  = @"/api/user/login";
//获取验证码
static NSString * const K_MK_GetPhoneCode_url  = @"/api/user/sms";
//注册接口
static NSString * const K_MK_Register_Url  = @"/api/user/reg";

#endif /* MKRequestUrl_h */
