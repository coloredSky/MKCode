//
//  NewsViewController.h
//  MK
//
//  Created by 周洋 on 2019/3/18.
//  Copyright © 2019年 周洋. All rights reserved.
//


/**
 界面显示

 - WebViewShowTypeNewsDetailHtmlContentType: 加载文章详情富文本
 - WebViewShowTypeNewsDetailUrlType: 加载文章详情URL
 */
typedef NS_ENUM(NSUInteger, WebViewShowType) {
    WebViewShowTypeNormal,
    WebViewShowTypeNewsDetailHtmlContentType,
    WebViewShowTypeNewsDetailUrlType,
};

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
/**加载类型*/
@property(nonatomic,assign)WebViewShowType showType;
/**title*/
@property(nonatomic,copy)NSString *titleString;
/**显示的url*/
@property(nonatomic,copy)NSString *contentUrl;
/**显示的富文本*/
@property(nonatomic,copy)NSString *contentString;

//加载文章详情d时，使用。
@property (nonatomic, copy) NSString *newsID;
@end

NS_ASSUME_NONNULL_END
