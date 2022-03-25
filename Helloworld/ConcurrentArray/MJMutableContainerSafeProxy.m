//
//  MJMutableContainerSafeProxy.m
//  Helloworld
//
//  Created by  yuzhiyun on 2021/11/15.
//  Copyright © 2021 zhiyunyu. All rights reserved.
//

#import "MJMutableContainerSafeProxy.h"

#import "MJMutableContainerSafeProxy.h"

@implementation MJMutableContainerSafeProxy {
@public
    id _underlyingObject;
}

+ (NSMutableDictionary *)dictionary
{
    MJMutableContainerSafeProxy *proxy = [MJMutableContainerSafeProxy alloc];
    proxy->_underlyingObject = [[NSMutableDictionary alloc] init];
    return (NSMutableDictionary *)proxy;
}

+ (NSMutableArray *)array
{
    MJMutableContainerSafeProxy *proxy = [MJMutableContainerSafeProxy alloc];
    proxy->_underlyingObject = [[NSMutableArray alloc] init];
    return (NSMutableArray *)proxy;
}

+ (NSMutableSet *)set
{
    MJMutableContainerSafeProxy *proxy = [MJMutableContainerSafeProxy alloc];
    proxy->_underlyingObject = [[NSMutableSet alloc] init];
    return (NSMutableSet *)proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    @synchronized (self) {
        return [_underlyingObject methodSignatureForSelector:selector];
    }
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    @synchronized (self) {
        [invocation invokeWithTarget:_underlyingObject];
    }
}

- (NSString *)description
{
    @synchronized (self) {
        NSString *desc = [_underlyingObject description];
        return desc;
    }
}

- (NSString *)debugDescription
{
    @synchronized (self) {
        NSString *desc = [_underlyingObject debugDescription];
        return desc;
    }
}

@end


