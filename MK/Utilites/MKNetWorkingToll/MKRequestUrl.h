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

//发现列表
static NSString * const K_MK_Discover_NewsList_Url  = @"/api/posts/getlist";
//发现新闻详情
static NSString * const K_MK_Discover_NewsDetail_Url  = @"/api/posts/getcontent";

/*
 *预约
 */
//获取各类申请列表
static NSString * const K_MK_GetApplyList_Url  = @"/api/user/getApplyList";
//获取各类申请的回复
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
 *登录、注册
 */
//登录
static NSString * const K_MK_Login_url  = @"/api/user/login";
//获取验证码
static NSString * const K_MK_GetPhoneCode_url  = @"/api/user/sms";
//注册接口
static NSString * const K_MK_Register_Url  = @"/api/user/reg";
//获取账单接口
static NSString * const K_MK_MyBillList_Url =@"/user/order/paymentLogList";





/*
 个人中心
 */
//修改密码
static NSString * const K_MK_SetPwd_url  = @"/api/user/updatePwd";
//意见反馈
static NSString * const K_MK_FeedBack_url  = @"api/user/insertUserFeedback";
//获取个人信息
static NSString * const K_MK_GetUserInfo_url  = @"/api/user/GetUserInfo";
#endif /* MKRequestUrl_h */
