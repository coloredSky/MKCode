//
//  UILabel+layout.m
//  MaiQiDanGao
//
//  Created by zhouyang on 15/12/17.
//  Copyright © 2015年 ZhouYang. All rights reserved.
//

#import "UILabel+layout.h"

@implementation UILabel(UILabel_layout)

-(void)setFont:(UIFont *)font textColor:(UIColor *)textColor withBackGroundColor:(UIColor *)backGroundColor
{
    
    if (backGroundColor==nil)
    {
        self.backgroundColor = [UIColor clearColor];
    
    }
    else
    {
        self.backgroundColor = backGroundColor;
    }
    self.textColor = textColor;
    self.font = font;
    
}

-(void)setLabelSpaceWithText:(NSString *)text  andLineSpacValue:(float)lineSpace  andWordSpace:(float)wordSpace withFont:(UIFont*)font
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpace; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@(wordSpace)
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:text attributes:dic];
    self.attributedText = attributeStr;
}

- (void)setAttributeTitles:(NSArray *)titles fonts:(NSArray *)fonts colors:(NSArray *)colors{
    if(titles != nil && titles.count > 0 && fonts.count>0 && titles.count == colors.count){
        NSMutableAttributedString *attributedStrM = [[NSMutableAttributedString alloc] init];
        int i = 0;
        for (NSString *title in titles) {
            UIFont *font = fonts.count-1 < i ? fonts.lastObject : fonts[i];
            NSDictionary *dic = @{NSFontAttributeName:font, NSForegroundColorAttributeName:colors[i]};
            NSAttributedString *attr = [[NSAttributedString alloc] initWithString:title attributes:dic];
            i++;
            [attributedStrM appendAttributedString:attr];
        }
        
        self.attributedText = attributedStrM;
    }
}
@end
