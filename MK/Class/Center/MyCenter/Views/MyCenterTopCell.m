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
}

@end
