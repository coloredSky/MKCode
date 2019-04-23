//
//  MKBaseTableView.m
//  MK
//
//  Created by 周洋 on 2019/3/8.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MKBaseTableView.h"

@interface MKBaseTableView()
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *noDataIma;

@end

@implementation MKBaseTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.separatorColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = K_BG_deepGrayColor;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
    return self;
}





@end
