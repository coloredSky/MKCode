//
//  MKConfigKey.h
//  MK
//
//  Created by 周洋 on 2019/4/12.
//  Copyright © 2019年 周洋. All rights reserved.
//

#ifndef MKConfigKey_h
#define MKConfigKey_h

#ifdef DEBUG
// DEBUG Module Bugly
#define kXHBorrowBuglyAPPID @""
#define kXHBorrowBugConfigChannel @"Development"
#else
// RELEASE Module Bugly
#define kXHBorrowBuglyAPPID @""
#define kXHBorrowBugConfigChannel @"APP Store"
#endif


/**用户登录通知*/
#define kMKLoginInNotifcationKey @"kMKLoginInNotifcationKey"
/**用户退出登录通知*/
#define kMKLoginOutNotifcationKey @"kMKLoginOutNotifcationKey"
/**预约相谈列表刷新通知*/
#define kMKApplyMeetingListRefreshNotifcationKey @"kMKApplyMeetingListRefreshNotifcationKey"
/**请假列表刷新通知*/
#define kMKApplyAskForLeaveListRefreshNotifcationKey @"kMKApplyAskForLeaveListRefreshNotifcationKey"
/**换班列表刷新通知*/
#define kMKApplyChangeClassListRefreshNotifcationKey @"kMKApplyChangeClassListRefreshNotifcationKey"
/*收藏课程列表刷新通知*/
#define kMKUserCollectionClassListRefreshNotifcationKey @"kMKUserCollectionClassListRefreshNotifcationKey"
/*我的课程列表刷新通知*/
#define kMKUserCourseListRefreshNotifcationKey @"kMKUserCourseListRefreshNotifcationKey"

//URL
/**客服URL*/
#define kMKPhoneServiceUrl @"https://dct.zoosnet.net/LR/Chatpre.aspx?id=DCT42909734&cid=4148acc6e0374d9988ae3b2e963f860d&lng=cn&sid=4148acc6e0374d9988ae3b2e963f860d&p=about%3Ablank&rf1=&rf2=&msg=&d=1560242584360"

//隐私声明地址
#define kMKPrivacyStatementUrl @"http://www.mkeduit.com/mobile/protocol/privacy_statement.html"
//服务条款地址
#define kMKTheTermsOfServiceUrl @"http://www.mkeduit.com/mobile/protocol/service_clause.html"

#endif /* MKConfigKey_h */
