//
//  MKKey.h
//  MK
//
//  Created by 周洋 on 2019/4/12.
//  Copyright © 2019年 周洋. All rights reserved.
//

#ifndef MKKey_h
#define MKKey_h

#ifdef DEBUG
// DEBUG Module Bugly
#define kXHBorrowBuglyAPPID @""
#define kXHBorrowBugConfigChannel @"Development"
#else
// RELEASE Module Bugly
#define kXHBorrowBuglyAPPID @""
#define kXHBorrowBugConfigChannel @"APP Store"
#endif

#define MKLoginKey @"MKLoginKey"

#endif /* MKKey_h */
