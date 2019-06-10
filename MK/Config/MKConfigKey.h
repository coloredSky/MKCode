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

//static NSString *const KMKLoginKey = @"KMKLoginKey";
//static BOOL KIsHaveLogin(){
//    return [[NSUserDefaults standardUserDefaults]boolForKey:KMKLoginKey];
//}
//#define KMKLoginKey @"KMKLoginKey"
//#define K_MK_IsHaveLoginKey [[NSUserDefaults standardUserDefaults]boolForKey:KMKLoginKey]

#define kMKLoginInNotifcationKey @"kMKLoginInNotifcationKey"
#define kMKLoginOutNotifcationKey @"kMKLoginOutNotifcationKey"

#endif /* MKConfigKey_h */
