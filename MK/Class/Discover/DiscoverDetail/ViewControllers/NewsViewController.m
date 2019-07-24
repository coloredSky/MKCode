//
//  NewsViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/18.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "NewsViewController.h"
#import <WebKit/WebKit.h>
#import "DiscoverManager.h"
#import "DiscoverNewsModel.h"

@interface NewsViewController ()<WKUIDelegate,WKNavigationDelegate>
/**webView*/
@property(nonatomic,strong) WKWebView *contentWeb;
/**进度条*/
@property(nonatomic,strong) UIProgressView *progressView;

@end

@implementation NewsViewController

-(instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)dealloc
{
    [_contentWeb removeObserver:self forKeyPath:@"estimatedProgress"];
}

-(void)loadView
{
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.showType == WebViewShowTypeNewsDetail) {
        [self startRequest];
    }else{
        if (self.loadType == WebViewLoadTypeLoadTheRichText){
            //加载富文本
            [self loadRichHtmlText];
        }else{
            [self webViewLoadRequest];
        }
    }
}

-(void)startRequest
{
    [DiscoverManager callBackDiscoverNewsDetailDataWithHUDShow:NO newsID:self.newsID andCompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message, DiscoverNewsModel * _Nonnull newsDetailModel) {
        if (isSuccess) {
            self.contentString = newsDetailModel.newsContent;
            [self loadRichHtmlText];
        }else{
            if (![NSString isEmptyWithStr:message]) {
                [MBHUDManager showBriefAlert:message];
            }
        }
    }];
}

-(void)loadRichHtmlText
{
    if ([NSString isEmptyWithStr:self.contentString])
    {
        return;
    }else{
        [self.contentWeb loadHTMLString:self.contentString baseURL:nil];
    }
}
//k加载网页
-(void)webViewLoadRequest
{
    if (![NSString isEmptyWithStr:self.contentUrl]&&[self.contentUrl hasPrefix:@"http"])
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.contentUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:24*3600];
        [self.contentWeb loadRequest:request];
    }
}

#pragma mark --Lazy
-(WKWebView *)contentWeb
{
    if (!_contentWeb)
    {
        _contentWeb = [WKWebView new];
        _contentWeb.frame = CGRectMake(0, K_StatusBarHeight, KScreenWidth,KScreenHeight-K_StatusBarHeight);
        [self.view addSubview:_contentWeb];
         if (@available(ios 11.0,*)) {
            _contentWeb.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _contentWeb.scrollView.showsVerticalScrollIndicator = NO;
        _contentWeb.scrollView.showsHorizontalScrollIndicator = NO;
        _contentWeb.UIDelegate = self;
        _contentWeb.navigationDelegate = self;
        _contentWeb.backgroundColor = [UIColor whiteColor];
        _contentWeb.scrollView.showsVerticalScrollIndicator = NO;
        [_contentWeb addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _contentWeb;
}
-(UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, K_StatusBarHeight, KScreenWidth, 1)];
        [self.view addSubview:_progressView];
        _progressView.trackTintColor = [UIColor whiteColor];
        _progressView.progressTintColor = K_BG_YellowColor;
        _progressView.progressViewStyle = UIProgressViewStyleDefault;
    }
    return _progressView;
}

#pragma mark --observe
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([object isEqual:self.contentWeb]&&[keyPath isEqualToString:@"estimatedProgress"])
    {
        double newProgress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        [self.progressView setProgress:newProgress animated:YES];
        //        DDLogInfo(@"----------%.2f",newProgress);
        if (newProgress == 1.0)
        {
            [self hiddenProgressViewAnimated:NO];
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mark --进度条隐藏
-(void)hiddenProgressViewAnimated:(BOOL)animated
{
    [UIView animateWithDuration:.5 animations:^{
        [self.progressView setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self.progressView setProgress:0 animated:NO];
        [self.progressView setAlpha:1.0];
    }];
}
#pragma mark-- WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void(^)(WKNavigationActionPolicy))decisionHandler
{
    //在发送请求之前，是否跳转
    decisionHandler(WKNavigationActionPolicyAllow);
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    MKLog(@"页面开始加载");
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void(^)(WKNavigationResponsePolicy))decisionHandler {
    //收到服务器的响应头
    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    MKLog(@"内容开始返回");
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    MKLog(@"页面加载完成");
    if (self.loadType == WebViewLoadTypeLoadTheRichText)
    {
        [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'" completionHandler:nil];
    }
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    MKLog(@"页面加载失败");
    [self hiddenProgressViewAnimated:NO];
}
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    MKLog(@"接收到服务器跳转请求");
}
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    MKLog(@"数据加载发生错误");
    [self hiddenProgressViewAnimated:NO];
}



@end
