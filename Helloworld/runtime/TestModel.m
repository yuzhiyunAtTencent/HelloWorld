//
//  TestModel.m
//  Helloworld
//
//  Created by yuzhiyun on 2021/4/15.
//  Copyright © 2021 zhiyunyu. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

- (BOOL)isEqual:(TestModel *)other
{
    if (other == self) {
        return YES;
    } else {
        if ([self.title isEqual:other.title]) {
            return YES;
        }
        return NO;
    }
}

- (NSUInteger)hash
{
    return 10;
}

@end
