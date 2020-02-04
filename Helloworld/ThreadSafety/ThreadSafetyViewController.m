//
//  ThreadSafetyViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2019/7/4.
//  Copyright © 2019 zhiyunyu. All rights reserved.
//

#import "ThreadSafetyViewController.h"

@interface ThreadSafetyViewController ()
@property (atomic, assign) NSInteger count;
@end

@implementation ThreadSafetyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.count = 0;
    
    NSThread *threadA = [[NSThread alloc] initWithTarget:self selector:@selector(doSomething) object:nil];
    [threadA start];
    
    NSThread *threadB = [[NSThread alloc] initWithTarget:self selector:@selector(doSomething) object:nil];
    [threadB start];
}

- (void)doSomething {
    for (NSInteger i = 0; i < 10; i++) {
        [NSThread sleepForTimeInterval:1.0];
        @synchronized (self) {
            self.count++;
        }
        
        NSLog(@"self.count = %@ %@", @(self.count), [NSThread currentThread]);
    }
}


@end
