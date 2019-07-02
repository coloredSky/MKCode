//
//  MKShareInstance.h
//  MK
//
//  Created by 周洋 on 2019/3/8.
//  Copyright © 2019年 周洋. All rights reserved.
//

#ifndef MKShareInstance_h
#define MKShareInstance_h


// .h文件
#define MKBorrowShareSingleton_H(name) + (instancetype)shared##name;

// .m文件
#define MKBorrowShareSingleton_M(name) \
static id _instace = nil; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super allocWithZone:zone]; \
}); \
return _instace; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [[self alloc] init]; \
}); \
return _instace; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instace; \
}

#endif /* MKShareInstance_h */
