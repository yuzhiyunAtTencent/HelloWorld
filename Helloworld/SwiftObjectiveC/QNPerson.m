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
    NSLog(@"Hello, my name is %@", self.name);
}

- (void)sendGreetingWithMessage:(NSString *)message {
    NSLog(@"the message content is %@", message);
}

@end
