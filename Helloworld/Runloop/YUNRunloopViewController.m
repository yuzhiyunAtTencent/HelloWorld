//
//  YUNRunloopViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2019/7/22.
//  Copyright © 2019 zhiyunyu. All rights reserved.
//

#import "YUNRunloopViewController.h"
#import "RunloopMonitor.h"

@interface YUNRunloopViewController()
@property (nonatomic, strong) NSTimer *waitingTimer;
@end

@implementation YUNRunloopViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [[RunloopMonitor shareInstance] beginMonitor];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(_click)]];
    

    CFAbsoluteTime waitingStartTime = CFAbsoluteTimeGetCurrent();
    
    self.waitingTimer = [NSTimer scheduledTimerWithTimeInterval:5
                                    repeats:YES
                                      block:^(NSTimer * _Nonnull timer) {
        NSLog(@"kCFRunLoop timer*************************************************************");
    }];
}

- (void)_click {
    NSLog(@"kCFRunLoop lick");
}



@end
