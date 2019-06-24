//
//  VersionUpdateController.m
//  MK
//
//  Created by ginluck on 2019/3/21.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "VersionUpdateController.h"
#import "VersionUpdateManager.h"

@interface VersionUpdateController ()
@property (weak, nonatomic) IBOutlet UILabel *versionLab;
@property (weak, nonatomic) IBOutlet UILabel *tipLab;
@property (nonatomic, strong) VersionUpdateModel *versionModel;
@end

@implementation VersionUpdateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.versionLab.text = [NSString stringWithFormat:@"当前版本：%@",[NSString getAppVersion]];
    self.tipLab.textColor = K_Text_grayColor;
    [self startRequest];
}

-(void)startRequest
{
    [VersionUpdateManager callBackAppVersionUpdateWithCompletionBlock:^(BOOL isSuccess, VersionUpdateModel * _Nonnull versionModel, NSString * _Nonnull message) {
        if (isSuccess) {
            self.versionModel = versionModel;
        }
    }];
}

-(IBAction)btnClick:(UIButton *)sender
{
    if ([NSString compareVersion:self.versionModel.version] != 1) {
        [MBHUDManager showBriefAlert:@"已是最新版本!"];
        return;
    }
   //版本更新
    if (@available(iOS 10.0,*)){
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:self.versionModel.download_url]]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.versionModel.download_url] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@(false)} completionHandler:nil];
        }
    }else{
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:self.versionModel.download_url]]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.versionModel.download_url]];
        }
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
