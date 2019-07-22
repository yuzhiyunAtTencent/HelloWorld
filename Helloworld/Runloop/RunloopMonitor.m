//
//  RunloopMonitor.m
//  Helloworld
//
//  Created by zhiyunyu on 2019/7/22.
//  Copyright © 2019 zhiyunyu. All rights reserved.
//

#import "RunloopMonitor.h"

@implementation RunloopMonitor {
    dispatch_semaphore_t semaphore;
    CFRunLoopObserverRef runloopObserver;
    CFRunLoopActivity runloopActivity;
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
    if (runloopObserver) {
        return;
    }
    
    semaphore = dispatch_semaphore_create(0);
    
    runloopObserver = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                              kCFRunLoopAllActivities,
                                              YES,
                                              0,
                                              &observerCallback,
                                              NULL);
    
    CFRunLoopAddObserver(CFRunLoopGetMain(), runloopObserver, kCFRunLoopCommonModes);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (YES) {
            // wait超时会return非0
            long result = dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC));
            if (result != 0) {
                NSLog(@"进入monitor");
                if (runloopActivity == kCFRunLoopBeforeSources || runloopActivity == kCFRunLoopAfterWaiting) {
                    NSLog(@"发生卡顿啦");
                }
            }
        }
    });

}

static void observerCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    RunloopMonitor *monitor = [RunloopMonitor shareInstance];
    monitor->runloopActivity = activity;
    NSLog(@"CFRunLoopActivity = %@", @(activity));
    // 发送信号
    dispatch_semaphore_signal(monitor->semaphore);
}

@end
