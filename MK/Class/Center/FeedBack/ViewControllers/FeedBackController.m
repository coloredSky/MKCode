//
//  FeedBackController.m
//  MK
//
//  Created by ginluck on 2019/3/22.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "FeedBackController.h"

#import "UITextView+WJPlaceholder.h"
#import "FeedBackManager.h"
#import "FeedBackTypeModel.h"

@interface FeedBackController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSArray <FeedBackTypeModel *>*feedBackTypeList;
@property (nonatomic, strong) UITextView *feedBackTextView;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) FeedBackTypeModel *selectedTypeModel;

@end

@implementation FeedBackController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = K_BG_WhiteColor;
    [self startRequest];
}

-(void)startRequest
{
    [FeedBackManager callBackGetFeedBackTypeWithCompletionBlock:^(BOOL isSuccess, NSArray<FeedBackTypeModel *> * _Nonnull typeList, NSString * _Nonnull message) {
        if (isSuccess) {
            self.feedBackTypeList = typeList;
            [self configSubVuews];
        }
    }];
}

-(void)configSubVuews
{
    if (self.feedBackTypeList.count <=0) {
        return;
    }
    CGFloat btnWPadding = (KScreenWidth-90*3-K_Padding_LeftPadding*2)/2;
    CGFloat btnHPadding = K_Padding_LeftPadding;
    for (NSInteger i=0; i<self.feedBackTypeList.count; i++) {
        FeedBackTypeModel *typeModel = self.feedBackTypeList[i];
        UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
        [sender addTarget:self action:@selector(feedbackTypeSelectedHandleTarget:) forControlEvents:UIControlEventTouchUpInside];
        sender.tag = i;
        [self.view addSubview:sender];
        sender.backgroundColor = K_BG_deepGrayColor;
        sender.layer.masksToBounds = YES;
        sender.layer.cornerRadius = 15;
        if (i == 0) {
            self.selectedBtn = sender;
            self.selectedTypeModel = typeModel;
            self.selectedBtn.backgroundColor = K_BG_YellowColor;
        }
        sender.frame = CGRectMake(K_Padding_LeftPadding+(90+btnWPadding)*(i%3), self.titleLabel.bottomY+30+(btnHPadding+30)*(i/3), 90, 30);
        [sender setNormalTitle:typeModel.feedBackTitle font:MKFont(14) titleColor:K_Text_BlackColor];
        [sender setSelectedTitle:typeModel.feedBackTitle titleColor:K_Text_WhiteColor];
    }
    self.feedBackTextView.topY = self.titleLabel.bottomY+30+(btnHPadding+30)*(self.feedBackTypeList.count/3);
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, K_NaviHeight+7, 200, 50)];
        [self.view addSubview:_titleLabel];
        [_titleLabel setFont:MKBoldFont(28) textColor:[UIColor blackColor] withBackGroundColor:[UIColor clearColor]];
        _titleLabel.text =@"Feedback";
    }
    return  _titleLabel;
}

-(UITextView *)feedBackTextView
{
    if (!_feedBackTextView) {
        _feedBackTextView = [[UITextView alloc]initWithFrame:CGRectMake(K_Padding_LeftPadding, self.titleLabel.bottomY+20, KScreenWidth-K_Padding_LeftPadding*2, 200)];
        [self.view addSubview:_feedBackTextView];
        _feedBackTextView.backgroundColor = K_BG_YellowColor;
        _feedBackTextView.layer.masksToBounds = YES;
        _feedBackTextView.layer.cornerRadius = 10;
        _feedBackTextView.location = CGPointMake(5, 5);
        _feedBackTextView.placeholder = @"请填写您遇到的问题或者建议，感谢你的支持！";
        _feedBackTextView.placeholdFont = MKFont(13);
        _feedBackTextView.placeholderColor = K_Text_grayColor;
        [self.submitBtn addTarget:self action:@selector(submitTarget:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _feedBackTextView;
}

-(UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_submitBtn];
        _submitBtn.backgroundColor = [UIColor blackColor];
        [_submitBtn setNormalTitle:@"提交" font:MKBoldFont(15) titleColor:K_Text_WhiteColor];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 10;
        _submitBtn.frame = CGRectMake(K_Padding_Home_LeftPadding, self.view.height-K_TabbarHeight-(KScreenWidth-K_Padding_Home_LeftPadding*2)/6, KScreenWidth-K_Padding_Home_LeftPadding*2, (KScreenWidth-K_Padding_Home_LeftPadding*2)/6);
    }
    return _submitBtn;
}


-(void)feedbackTypeSelectedHandleTarget:(UIButton *)sender
{
    if (self.selectedBtn == sender) {
        return;
    }
    self.selectedBtn.backgroundColor = K_BG_deepGrayColor;
    sender.backgroundColor = K_BG_YellowColor;
    self.selectedBtn = sender;
    FeedBackTypeModel *model = self.feedBackTypeList[sender.tag];
    self.selectedTypeModel = model;
}

-(void)submitTarget:(UIButton *)sender
{
    //提交
    if (self.selectedTypeModel == nil) {
        [MBHUDManager showBriefAlert:@"请选择您要反馈的类型！"];
        return;
    }
    if ([NSString isEmptyWithStr:self.feedBackTextView.text]) {
        [MBHUDManager showBriefAlert:@"请选择您要反馈的内容！"];
        return;
    }
    [MBHUDManager showLoading];
    [FeedBackManager callBackFeedBackWithHudShow:NO feedType:[self.selectedTypeModel.feedBackID integerValue]  feedDetail:self.feedBackTextView.text CompletionBlock:^(BOOL isSuccess, NSString * _Nonnull message) {
        [MBHUDManager hideAlert];
        if (isSuccess) {
            [MBHUDManager showBriefAlert:@"感谢您的反馈！"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            if (![NSString isEmptyWithStr:message]) {
                [MBHUDManager showBriefAlert:message];
            }
        }
    }];
}

@end
