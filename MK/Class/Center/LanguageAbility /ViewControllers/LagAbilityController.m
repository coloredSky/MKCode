//
//  LagAbilityController.m
//  MK
//
//  Created by ginluck on 2019/3/30.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "LagAbilityController.h"

@interface LagAbilityController ()
@property(nonatomic,weak)IBOutlet UITextField * TOEIC;
@property(nonatomic,weak)IBOutlet UITextField * TOEFL;
@property(nonatomic,weak)IBOutlet UITextField * JapField;
@end

@implementation LagAbilityController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =K_BG_WhiteColor;
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
