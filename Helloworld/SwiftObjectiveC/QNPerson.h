//
//  QNPerson.h
//  Helloworld
//
//  Created by zhiyunyu on 2020/4/9.
//  Copyright © 2020 zhiyunyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QNPerson : NSObject

@property(nonatomic, strong) NSString *name;

// 无参数
- (void)sayHello;
// 带参数
- (void)saySomething:(NSString *)str;
// 带block
- (void)sayCallback:(void (^)(NSString *))callback;
// 多参数
- (void)saySomething1:(NSString *)str1
           something2:(NSString *)str2
             callback:(void (^)(NSString *))callback;
// NS_SWIFT_NAME 修改名字
- (void)sendGreetingWithMessage:(NSString *)message NS_SWIFT_NAME(sendGreeting(message:));

@end

NS_ASSUME_NONNULL_END
