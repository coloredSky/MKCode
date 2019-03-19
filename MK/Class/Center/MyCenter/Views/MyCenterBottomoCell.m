//
//  MyCenterBottomoCell.m
//  MK
//
//  Created by ginluck on 2019/3/18.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MyCenterBottomoCell.h"
@interface MyCenterBottomoCell()

@end
@implementation MyCenterBottomoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     [_myCenterLab setFont:MKBoldFont(13) textColor:K_Text_BlackColor withBackGroundColor:nil];
    self.shadowView.backgroundColor =[UIColor clearColor];
    self.shadowView.layer.shadowColor = K_Text_DeepGrayColor.CGColor;
    self.shadowView.layer.shadowRadius = 3.0f;
    self.shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    self.shadowView.layer.shadowOpacity = .5;
}

@end
