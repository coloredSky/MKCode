//
//  DiscoverNewsModel.m
//  MK
//
//  Created by 周洋 on 2019/5/24.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "DiscoverNewsModel.h"

@implementation DiscoverNewsModel

// 当 JSON 转为 Model 完成后，该方法会被调用。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    if (![NSString isEmptyWithStr:_newsCreateTime]) {
        _newsCreateWeek = [NSString weekdayStringWithDateString:_newsCreateTime andDateFormatString:@"YYYY-MM-dd HH:mm:ss"];
        _newsCreateDate = [NSString timeTransformWithDate:_newsCreateTime WithFormModel:@"YYYY-MM-dd HH:mm:ss" toModel:@"MM月dd日"];;
//        [_newsCreateWeek getStrWidthWithfont:@""];
    }
    if (![NSString isEmptyWithStr:_newsContent]) {
        _newsContent = [NSString htmlStringTransToString:_newsContent];
        NSString *cssContentString = [NSString stringWithFormat:
                                      @"<!DOCTYPE html>"
                                      "<html>"
                                      "<head>"
                                      "<meta name=\"viewport\" content=\"width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no\">" //适配手机的关键
                                      "</head>"
                                      "<body>"
                                      "%@"
                                      "</body>"
                                      "</html>" , _newsContent];
        _newsContent = cssContentString;
    }
    return YES;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    // 将personId映射到key为id的数据字段
    return @{@"newsID":@"id",
             @"newsTitle" : @"title",
             @"newsDigest" : @"digest",
             @"newsContent" : @"content",
             @"newsCreateTime" : @"create_time",
             @"newsImage":@"thumb",
             };
}
@end
