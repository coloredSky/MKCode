//
//  CourseCategoryCell.m
//  MK
//
//  Created by 周洋 on 2019/3/18.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "CourseCategoryCell.h"
@interface CourseCategoryCell()
@property (weak, nonatomic) IBOutlet UIImageView *contentIma;

@end
@implementation CourseCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentIma.layer.masksToBounds = YES;
    self.contentIma.layer.cornerRadius = 10;
    self.contentIma.image = KImageNamed(@"discover_items");
}

@end
