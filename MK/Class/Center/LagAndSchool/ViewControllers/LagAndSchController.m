//
//  LagAndSchController.m
//  MK
//
//  Created by ginluck on 2019/3/30.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "LagAndSchController.h"
#import "ValuePickerView.h"
@interface LagAndSchController ()
@property (nonatomic, strong) ValuePickerView *pickerView;
@property(nonatomic,weak)IBOutlet UITextField * schField;
@end

@implementation LagAndSchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =K_BG_WhiteColor;
}
#pragma mark -lazy
-(ValuePickerView*)pickerView
{
    if (!_pickerView) {
        _pickerView =[ValuePickerView new];
        _pickerView .dataSource =@[@"上午班",@"下午班"];
        _pickerView.pickerTitle =@"选择班级类型";
    }
    return _pickerView;
}
-(IBAction)btnClick:(UIButton *)sender
{
    if (sender.tag ==0) {
        [self.pickerView show];
        self.pickerView.valueDidSelect = ^(NSString *value){
            value =[value substringToIndex:3];
            [sender setTitle:value forState:UIControlStateNormal];
        };
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
