//
//  RunloopMonitor.m
//  Helloworld
//
//  Created by zhiyunyu on 2019/7/22.
//  Copyright © 2019 zhiyunyu. All rights reserved.
//

#import "RunloopMonitor.h"

@implementation RunloopMonitor {
//    dispatch_semaphore_t semaphore;
    CFRunLoopObserverRef runloopObserver;
//    CFRunLoopActivity runloopActivity;
}

+ (instancetype)shareInstance {
    static id instance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[RunloopMonitor alloc] init];
    });
    return instance;
}

- (void)beginMonitor {
    CFRunLoopObserverContext context = {0, (__bridge void *) self, NULL, NULL, NULL};
    CFRunLoopObserverRef beginObserver = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, LONG_MIN, &myRunLoopBeginCallback, &context);
    CFRetain(beginObserver);
    
    CFRunLoopRef runloop = [[NSRunLoop currentRunLoop] getCFRunLoop];
    CFRunLoopAddObserver(runloop, beginObserver, kCFRunLoopCommonModes);
    
    runloopObserver = beginObserver;
}

void myRunLoopBeginCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"kCFRunLoopEntry");
            break;

        case kCFRunLoopBeforeTimers:
            NSLog(@"kCFRunLoopBeforeTimers");
            break;

        case kCFRunLoopBeforeSources:
            NSLog(@"kCFRunLoopBeforeSources");
            break;

        case kCFRunLoopAfterWaiting:
            NSLog(@"kCFRunLoopAfterWaiting");
            break;

        case kCFRunLoopBeforeWaiting:
            NSLog(@"kCFRunLoopBeforeWaiting");
            break;

        case kCFRunLoopExit:
            NSLog(@"kCFRunLoopExit");
            break;

        case kCFRunLoopAllActivities:
            break;

        default:
            break;
    }
}

@end
