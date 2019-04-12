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


#define KMKLoginKey @"KMKLoginKey"
#define K_MK_IsHaveLoginKey [[NSUserDefaults standardUserDefaults]boolForKey:KMKLoginKey]


#endif /* MKConfigKey_h */
