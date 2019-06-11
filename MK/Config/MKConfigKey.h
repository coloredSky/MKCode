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
#endif /* MKConfigKey_h */
