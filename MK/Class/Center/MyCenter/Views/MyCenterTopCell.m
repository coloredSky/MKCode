//
//  MyCenterTopCell.m
//  MK
//
//  Created by ginluck on 2019/3/18.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MyCenterTopCell.h"
@interface MyCenterTopCell()

@end
@implementation MyCenterTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
      [_myCenterLab setFont:MKBoldFont(13) textColor:K_Text_BlackColor withBackGroundColor:nil];
    self.contentView.backgroundColor =[UIColor clearColor];
    self.bgView.backgroundColor =[UIColor clearColor];
    self.backgroundColor =[UIColor clearColor];
    self.bgView.layer.shadowColor = K_Text_DeepGrayColor.CGColor;
    self.bgView.layer.shadowRadius = 3.0f;
    self.bgView.layer.shadowOffset = CGSizeMake(0, 0);
    self.bgView.layer.shadowOpacity = .5;
    
    self.whiteView.layer.cornerRadius =5.f;
    self.whiteView.layer.masksToBounds=YES;
}

@end
