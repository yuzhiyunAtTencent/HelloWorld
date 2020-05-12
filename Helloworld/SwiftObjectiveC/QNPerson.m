//
//  QNPerson.m
//  Helloworld
//
//  Created by zhiyunyu on 2020/4/9.
//  Copyright © 2020 zhiyunyu. All rights reserved.
//

#import "QNPerson.h"

@implementation QNPerson

- (void)sayHello {
    NSLog(@"swift调用oc,my name is %@", self.name);
}

- (void)saySomething:(NSString *)str {
    NSLog(@"%@",str);
}

- (void)sayCallback:(void (^)(NSString *))callback {
    if (callback) {
        callback(@"swift调用oc,带block");
    }
}

- (void)saySomething1:(NSString *)str1
           something2:(NSString *)str2
             callback:(void (^)(NSString *))callback {
    if (callback) {
        callback([NSString stringWithFormat:@"swift调用oc ,多参数 %@ %@", str1, str2]);
    }
}

- (void)sendGreetingWithMessage:(NSString *)message {
    NSLog(@"swift调用oc 修改函数名  the message content is %@", message);
}

@end
