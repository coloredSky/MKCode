//
//  UserInfoEditView.m
//  MK
//
//  Created by 周洋 on 2019/6/21.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "UserInfoEditView.h"

@implementation UserInfoEditView

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self addSubview:_contentView];
        _contentView.backgroundColor = K_BG_deepGrayColor;
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.cornerRadius = 6;

        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, 60, _contentView.height)];
        [_contentView addSubview:_titleLab];
        [_titleLab setFont:MKFont(14) textColor:K_Text_grayColor withBackGroundColor:nil];
        
        _contentTF = [[UITextField alloc]initWithFrame:CGRectMake(_titleLab.rightX+15, 0, _contentView.width-_titleLab.width-10, _contentView.height)];
        [_contentView addSubview:_contentTF];
        _contentTF.font = MKFont(14);
        _contentTF.textColor = K_Text_BlackColor;
        
        _dropDownIma = [[UIImageView alloc]initWithFrame:CGRectMake(_contentView.width-20, _contentView.centerY-10, 20, 20)];
        [_contentView addSubview:_dropDownIma];
        _dropDownIma.image = KImageNamed(@"MyCenter_arrows");
        _dropDownIma.hidden = YES;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(contentTFValueChange:) name:UITextFieldTextDidChangeNotification object:self.contentTF];
    }
    return self;
}

-(void)contentTFValueChange:(NSNotification *)noti
{
    if (self.UserInfoEditViewContenTextChangeBlock) {
        self.UserInfoEditViewContenTextChangeBlock(self.contentTF, self.contentTF.text);
    }
}

-(void)setTitleString:(NSString *)titleString
{
    self.titleLab.text = titleString;
}

-(void)setContentString:(NSString *)contentString
{
    self.contentTF.text = contentString;
}

@end
