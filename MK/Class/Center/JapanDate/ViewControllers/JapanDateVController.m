//
//  JapanDateVController.m
//  MK
//
//  Created by ginluck on 2019/3/30.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "JapanDateVController.h"
#import "LYSDatePickerController.h"//时间控件
@interface JapanDateVController ()<LYSDatePickerSelectDelegate>
@property(nonatomic,weak)IBOutlet UIButton  * timeBtn;
@end

@implementation JapanDateVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(IBAction)btnClick:(UIButton * )sender
{
    if (sender.tag ==0)
    {
        [LYSDatePickerController alertDatePickerInWindowRootVCWithType:(LYSDatePickerTypeDay) selectDate:[NSDate date]];
        [LYSDatePickerController customPickerDelegate:self];
        [LYSDatePickerController customdidSelectDatePicker:^(NSDate *date) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
//        [sender setTitle:[NSString stringFromDate:date formate:dateFormat] forState:UIControlStateNormal];
        }];
    }
    else
    {
        //保存
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
