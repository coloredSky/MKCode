//
//  FeedBackController.m
//  MK
//
//  Created by ginluck on 2019/3/22.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "FeedBackController.h"
#import "UserTextView.h"
#import "FeedBackManager.h"
@interface FeedBackController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,weak)IBOutlet UserTextView * textView;
@property(nonatomic,weak)IBOutlet UIButton * btn_1;
@property(nonatomic,weak)IBOutlet UIButton * btn_2;
@property(nonatomic,weak)IBOutlet UIButton * btn_3;
@property(nonatomic,strong) NSArray * btnAry;


//参数
@property(nonatomic,strong)NSString * type;
@end

@implementation FeedBackController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUICompoents];
}
-(void)setUICompoents
{
    self.type =@"1";
    self.textView.placeholder=@"请填写你的功能建议，感谢您的支持（必填）";
    self.textView.placeholderColor  =K_Text_grayColor;
    
    self.btnAry =@[self.btn_1,self.btn_2,self.btn_3];
}

-(IBAction)btnClick:(UIButton *)sender
{
    if (sender.tag <4)
    {
        for (UIButton * btn in self.btnAry)
        {
            [btn setTitleColor:UIColorFromRGB_0x(0X707070)  forState:UIControlStateNormal];
            [btn setBackgroundColor:UIColorFromRGB_0x(0xf8f8f8)];
        }
        [sender setTitleColor:K_Text_WhiteColor  forState:UIControlStateNormal];
        [sender setBackgroundColor:UIColorFromRGB_0x(0xf7ee15)];
        
        self.type =[NSString stringWithFormat:@"%ld",sender.tag+1];
    }
    else
    {
        //提交
        if (self.textView.text.length ==0  || [self.textView.text isEqualToString:@"请填写你的功能建议，感谢您的支持（必填）"]) {
            [MBHUDManager showBriefAlert:@"请输入反馈信息"];
        }
        [FeedBackManager callBackFeedBackWithHudShow:YES feedType:self.type feedDetail:self.textView.text CompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message) {
            [MBHUDManager showBriefAlert:message];
        }];
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
