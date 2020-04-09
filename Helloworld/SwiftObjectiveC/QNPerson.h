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

- (void)sayHello;
- (void)sendGreetingWithMessage:(NSString *)message NS_SWIFT_NAME(sendGreeting(message:));

@end

NS_ASSUME_NONNULL_END
