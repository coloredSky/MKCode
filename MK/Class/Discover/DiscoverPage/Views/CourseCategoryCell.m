//
//  CourseCategoryCell.m
//  MK
//
//  Created by 周洋 on 2019/3/18.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "CourseCategoryCell.h"
@interface CourseCategoryCell()

@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIImageView *contentIma;

@end
@implementation CourseCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.shadowView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.shadowView.layer.shadowColor = K_Text_DeepGrayColor.CGColor;
    self.shadowView.layer.shadowRadius = 3.0f;
    self.shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    self.shadowView.layer.shadowOpacity = .5;
    
    self.contentIma.layer.masksToBounds = YES;
    self.contentIma.layer.cornerRadius = 10;
    self.contentIma.image = KImageNamed(@"discover_items");
}

@end
