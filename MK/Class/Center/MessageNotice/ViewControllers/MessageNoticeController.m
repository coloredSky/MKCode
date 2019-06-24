//
//  MessageNoticeController.m
//  MK
//
//  Created by ginluck on 2019/3/19.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MessageNoticeController.h"

@interface MessageNoticeController ()
@property(nonatomic,weak)IBOutlet UISwitch * noticeSwitch;
@end

@implementation MessageNoticeController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.noticeSwitch.on = [self isUserNotificationEnable];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.noticeSwitch.onTintColor = [UIColor blueColor];
}

-(BOOL)isUserNotificationEnable { // 判断用户是否允许接收通知
    BOOL isEnable = NO;
    //处理逻辑
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    isEnable = (UIUserNotificationTypeNone == setting.types) ? NO : YES;
    return isEnable;
}

- (void)goToAppSystemSetting {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([application canOpenURL:url]) {
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            if (@available(iOS 10.0, *)) {
                [application openURL:url options:@{} completionHandler:^(BOOL success) {}];
            } else {
                // Fallback on earlier versions
                [application openURL:url];
            }
        } else {
            [application openURL:url];
        }
    }
}

-(IBAction)switchClick:(UISwitch *)sender
{
    sender.on = [self isUserNotificationEnable];
    //消息通知开关
    [self goToAppSystemSetting];
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
