//
//  MKBridging.h
//  MK
//
//  Created by 周洋 on 2019/3/8.
//  Copyright © 2019年 周洋. All rights reserved.
//

#ifndef MKBridging_h
#define MKBridging_h



//Block condition
#define BLOCK_EXEC(block,...) !block ?: block(__VA_ARGS__);


#define KImageNamed(_pointer) [UIImage imageNamed:(_pointer)]
//banner normal image
#define K_placeholder_Annoument_Banner_Image  KImageNamed(@"annoument_Banner_Image")
//normal image
#define K_placeholder_Image_HomeRecommendImage  KImageNamed(@"home_place")
#define K_placeholder_Image  KImageNamed(@"News_list_content_ima")


//打印
#ifdef DEBUG
#define MKLog( s, ... ) NSLog( @"<%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )//分别是文件名，在文件的第几行，自定义输出内容
#else
#define  MKLog( s, ... )
#endif


//弱引用
#ifndef weakObject
#if DEBUG
#if __has_feature(objc_arc)
#define weakObject(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object
#else
#define weakObject(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakObject(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakObject(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

//强引用
#ifndef strongObject
#if DEBUG
#if __has_feature(objc_arc)
#define strongObject(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongObject(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongObject(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongObject(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif



#endif /* MKBridging_h */
