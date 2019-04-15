//
//  AppointmentPopView.m
//  MK
//
//  Created by 周洋 on 2019/3/21.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "AppointmentPopView.h"
@interface AppointmentPopView()
@property (nonatomic, strong) NSArray <NSString *>*btnTitleArr;
@property (nonatomic, strong) NSArray <NSString *>*btnImaArr;
@property (nonatomic, strong) NSMutableArray <UIButton *>*senderArr;
@end
@implementation AppointmentPopView
@synthesize delegate;

-(void)dealloc
{
    MKLog(@"AppointmentPopView --dealloc");
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        for (int i = 0; i < self.btnImaArr.count; i++) {
            UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:sender];
            sender.frame = CGRectMake(KScreenWidth-KScaleWidth(12)-KScaleWidth(66), KScreenHeight-K_TabbarHeight-KScaleHeight(18)-(KScaleWidth(66)*(i+1)), KScaleWidth(66), KScaleWidth(66));
            [sender setImage:KImageNamed(self.btnImaArr[i]) forState:UIControlStateNormal];
            sender.tag = i;
            [sender addTarget:self action:@selector(senderClickTarget:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *signStrLab = [UILabel new];
            [self addSubview:signStrLab];
            signStrLab.textAlignment = NSTextAlignmentRight;
            signStrLab.frame = CGRectMake(sender.leftX-100, sender.centerY-10, 100, 20);
            [signStrLab setFont:K_Font_Text_Normal textColor:K_Text_WhiteColor withBackGroundColor:nil];
            signStrLab.text = self.btnTitleArr[i];
        }
    }
    return self;
}
#pragma mark --  lazy
-(NSArray <NSString *>*)btnTitleArr
{
    if (!_btnTitleArr) {
        _btnTitleArr = @[@"",@"预约相谈",@"请假",@"调换班级"];
    }
    return _btnTitleArr;
}

-(NSArray <NSString *>*)btnImaArr
{
    if (!_btnImaArr) {
        _btnImaArr = @[@"appointment_cancle",@"appontment_pop_ conversation",@"appontment_pop_AskForLeave",@"appontment_pop_changeClass"];
    }
    return _btnImaArr;
}

-(NSMutableArray <UIButton *>*)senderArr
{
    if (!_senderArr) {
        _senderArr = [NSMutableArray arrayWithCapacity:4];
    }
    return _senderArr;
}

#pragma mark --  ENENT
-(void)senderClickTarget:(UIButton *)sender
{
    if ([delegate respondsToSelector:@selector(AppointmentPopViewClickWithAppointmentType:)]) {
        AppointmentOperationType operationType = sender.tag;
        [delegate AppointmentPopViewClickWithAppointmentType:operationType];
    }
}
@end
