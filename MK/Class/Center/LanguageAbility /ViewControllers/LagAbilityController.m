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
-(void)setModel:(PersonModel *)model
{
    _model =model;

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    if (_model !=nil)
    {
        self.TOEIC.text =_model.userInfo.toeic;
        self.TOEFL.text =_model.userInfo.toefl;
        self.JapField.text =_model.userInfo.jlpt;
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
