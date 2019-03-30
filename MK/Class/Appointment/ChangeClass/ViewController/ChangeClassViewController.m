//
//  ChangeClassViewController.m
//  MK
//
//  Created by 周洋 on 2019/3/29.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "ChangeClassViewController.h"


@interface ChangeClassViewController ()
@property (nonatomic, strong) UIScrollView *contentScroll;
@end

@implementation ChangeClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_YellowColor;
}

-(UIScrollView *)contentScroll
{
    if (!_contentScroll) {
        _contentScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        [self.view addSubview:_contentScroll];
        _contentScroll.backgroundColor = K_BG_YellowColor;
    }
    return  _contentScroll;
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
