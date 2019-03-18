//
//  NewsViewController.h
//  MK
//
//  Created by 周洋 on 2019/3/18.
//  Copyright © 2019年 周洋. All rights reserved.
//

/**
 加载类型
 - WebViewLoadTypeLoadTheRichText: 富文本
 - WebViewLoadTypeLoadURL: URL
 */
typedef NS_ENUM(NSUInteger, WebViewLoadType) {
        WebViewLoadTypeLoadURL,
    WebViewLoadTypeLoadTheRichText
};

#import "MKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 新闻详情
 */
@interface NewsViewController : MKNavViewController
/**加载类型*/
@property(nonatomic,assign)WebViewLoadType loadType;
/**title*/
@property(nonatomic,copy)NSString *titleString;
/**显示的url*/
@property(nonatomic,copy)NSString *contentUrl;
/**显示的富文本*/
@property(nonatomic,copy)NSString *contentString;
@end

NS_ASSUME_NONNULL_END
