//
//  MessageCell.m
//  MK
//
//  Created by 周洋 on 2019/3/27.
//  Copyright © 2019年 周洋. All rights reserved.
//

#import "MessageCell.h"
#import "MKMessageModel.h"

@interface MessageCell()
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIImageView *messageIconIma;
@property (weak, nonatomic) IBOutlet UILabel *meeeageTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *messageContentLab;
@property (weak, nonatomic) IBOutlet UILabel *meeeageTimeLab;
@property (weak, nonatomic) IBOutlet UIImageView *messageShowIma;

@end
@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.shadowView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.shadowView.layer.shadowColor = K_Text_DeepGrayColor.CGColor;
    self.shadowView.layer.shadowRadius = 3.0f;
    self.shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    self.shadowView.layer.shadowOpacity = .5;
    
    self.whiteView.layer.masksToBounds = YES;
    self.whiteView.layer.cornerRadius = 8;
    
    self.messageIconIma.layer.masksToBounds = YES;
    self.messageIconIma.layer.cornerRadius = KScaleWidth(20);
    
    self.meeeageTimeLab.textAlignment = NSTextAlignmentRight;
    self.messageIconIma.image = KImageNamed(@"message_logo");
    self.messageIconIma.userInteractionEnabled = YES;
    [self.meeeageTitleLab setFont:MKBoldFont(14) textColor:K_Text_BlackColor withBackGroundColor:nil];
    [self.messageContentLab setFont:K_Font_Text_Normal_little textColor:K_Text_grayColor withBackGroundColor:nil];
    self.messageContentLab.numberOfLines = 0;
    [self.meeeageTimeLab setFont:K_Font_Text_Min_Max textColor:K_Text_DeepGrayColor withBackGroundColor:nil];
    self.messageShowIma.userInteractionEnabled = YES;
    self.messageShowIma.image = KImageNamed(@"bookmark_notshow");
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.shadowView.frame = CGRectMake(K_Padding_Home_LeftPadding, 0, self.contentView.width-K_Padding_Home_LeftPadding*2, self.contentView.height);
    self.whiteView.frame = CGRectMake(0, 0, self.shadowView.width, self.shadowView.height);
    
    self.meeeageTimeLab.frame = CGRectMake(self.whiteView.width-200-K_Padding_LeftPadding, KScaleHeight(10), 200, KScaleHeight(15));
    self.messageIconIma.frame = CGRectMake(K_Padding_LeftPadding, self.meeeageTimeLab.bottomY+8, KScaleWidth(40), KScaleWidth(40));
    self.meeeageTitleLab.frame = CGRectMake(self.messageIconIma.rightX+KScaleWidth(22), self.messageIconIma.topY, self.whiteView.width-(self.messageIconIma.rightX+KScaleWidth(22))-KScaleWidth(12), KScaleHeight(20));
    self.messageShowIma.frame = CGRectMake(self.whiteView.width/2-KScaleWidth(8), self.whiteView.height-KScaleWidth(8)-KScaleHeight(16), KScaleWidth(16), KScaleWidth(16));
    self.messageContentLab.frame = CGRectMake(self.meeeageTitleLab.leftX, self.meeeageTitleLab.bottomY+KScaleHeight(5), self.meeeageTitleLab.width, self.messageShowIma.topY-(self.meeeageTitleLab.bottomY+KScaleHeight(5))-KScaleHeight(15));
}

-(void)cellRefreshDataWithMKMessageMode:(MKMessageModel *)messageModel
{
    if (messageModel.cellSelected) {
        self.messageShowIma.image = KImageNamed(@"bookmark_show");
    }else{
        self.messageShowIma.image = KImageNamed(@"bookmark_notshow");
    }
    self.meeeageTimeLab.text = messageModel.add_time;
    self.messageContentLab.text = messageModel.content;
    self.meeeageTitleLab.text = messageModel.title;
}

@end
