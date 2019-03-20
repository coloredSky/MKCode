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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)switchClick:(UISwitch *)sender
{
    //消息通知开关
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
