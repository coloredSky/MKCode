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
//课程收藏
static NSString * const K_MK_Course_Collection_Url  = @"/api/user/focusCourse";
//课程取消收藏
static NSString * const K_MK_Course_CancleCollection_Url  = @"/api/user/cancelFocusCourse";

//发现列表
static NSString * const K_MK_Discover_NewsList_Url  = @"/api/posts/getlist";
//发现新闻详情
static NSString * const K_MK_Discover_NewsDetail_Url  = @"/api/posts/getcontent";

/*
 *预约
 */
//获取各类申请列表
static NSString * const K_MK_GetApplyList_Url  = @"/api/user/getApplyList";
//获取各类申请的回复列表
static NSString * const K_MK_GetApplyReplayInformation_Url  = @"/api/user/getApplyReply";
//获取各类申请的详情
static NSString * const K_MK_GetApplyDetail_Url  = @"/api/user/getApplyInfo";


//请假
//获取请假课程列表
static NSString * const K_MK_AskForLeave_CourseList_Url  = @"/api/user/getUserClass";
//x新增请假申请
static NSString * const K_MK_AddAskForLeave_Url  = @"/api/user/AddApplyLeave";
//编辑请假申请
static NSString * const K_MK_EditAskForLeave_Url  = @"/api/user/UpdateApplyLeave";
//删除请假申请
static NSString * const K_MK_DeleteAskForLeave_Url  = @"/api/user/DelApplyLeave";

//预约
//获取预约时间
static NSString * const K_MK_MeetingTime_Url  = @"/api/user/getReservationTimeList";
//获取预约目的
static NSString * const K_MK_MeetingReservation_Url  = @"/api/user/getReservationList";
//新增预约相谈
static NSString * const K_MK_AddMeeting_Url  = @"/api/user/AddApplyReservation";
//删除预约相谈
static NSString * const K_MK_DeleteMeeting_Url  = @"/api/user/DelApplyReservation";

//换班
//换班列表
static NSString * const K_MK_ChangeClass_CourseList_Url  = @"/api/user/getStudentClass";
//新增换班申请
static NSString * const K_MK_AddChangeClass_Url  = @"/api/user/addEditClassChangeApply";
//删除换班申请
static NSString * const K_MK_DeleteChangeClass_Url  = @"/api/user/deleteChangeClassApply";

/*
 *订单
 */
//获取订单列表
static NSString * const K_MK_MyBillList_Url =@"/api/user/getOrders";

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
