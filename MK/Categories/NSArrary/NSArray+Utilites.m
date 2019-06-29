//
//  NSArray+Utilites.m
//  MK
//
//  Created by 周洋 on 2019/6/27.
//  Copyright © 2019 周洋. All rights reserved.
//

#import "NSArray+Utilites.h"

@implementation NSArray(Utilites)

- (BOOL)isEqualToArray:(NSArray *)array {
    if (!array || [self count] != [array count]) {
        return NO;
    }
    for (NSUInteger idx = 0; idx < [array count]; idx++) {
        if (![self[idx] isEqual:array[idx]]) {
            return NO;
        }
    }
    return YES;
}

@end
