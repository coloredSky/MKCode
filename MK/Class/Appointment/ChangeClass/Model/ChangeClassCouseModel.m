//
//  ChangeClassCouseModel.m
//  MK
//
//  Created by 周洋 on 2019/5/30.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "ChangeClassCouseModel.h"

@implementation ChangeClassCouseModel

-(instancetype)init
{
    if (self = [super init]) {
        self.changeClassList = [NSMutableArray array];
    }
    return self;
}

// 当 JSON 转为 Model 完成后，该方法会被调用。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    if (self.same_period_class.count >0) {
        for (ChangeClassCouseModel *model in self.same_period_class) {
            if ([model.changeID integerValue] != [self.changeID integerValue]) {
                [self.changeClassList addObject:model];
                [self.changeClassStringList addObject:model.course_name];
            }
        }
    }
    return YES;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    // 将personId映射到key为id的数据字段
    return @{@"changeID":@"id",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"same_period_class" : [ChangeClassCouseModel class]};
}
@end
