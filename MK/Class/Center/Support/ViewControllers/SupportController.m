//
//  SupportController.m
//  MK
//
//  Created by ginluck on 2019/3/21.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "SupportController.h"
#import "NewsViewController.h"

@interface SupportController ()

@end

@implementation SupportController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)btnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
            //页面闪退/卡顿
        }
            break;
        case 1:
        {
            //订单加载
        }
            break;
        case 2:
        {
            //资料不显示
        }
            break;
        case 3:
        {
            //无法收藏
        }
            break;
        case 4:
        {
            //联系我们
            NewsViewController *webVC = [NewsViewController new];
            webVC.loadType = WebViewLoadTypeLoadURL;
            webVC.contentUrl = kMKPhoneServiceUrl;
            [self.navigationController pushViewController:webVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
