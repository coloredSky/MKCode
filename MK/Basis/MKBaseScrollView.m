//
//  MKBaseScrollView.m
//  MK
//
//  Created by 周洋 on 2019/4/11.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKBaseScrollView.h"

@implementation MKBaseScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self CreateSubViews];
    }
    return self;
}

-(instancetype)init
{
    if (self = [super init]) {
        [self CreateSubViews];
    }
    return self;
}

-(void)CreateSubViews
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTarget:)];
    [self addGestureRecognizer:tap];
}

-(void)tapTarget:(UIButton *)sender
{
    [self endEditing:YES];
}
@end
