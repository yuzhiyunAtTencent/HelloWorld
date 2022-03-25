//
//  TimerViewController.m
//  Helloworld
//
//  Created by  yuzhiyun on 2021/11/12.
//  Copyright © 2021 zhiyunyu. All rights reserved.
//

#import "TimerViewController.h"
#import "TestBlock.h"
#import "ViewController.h"

@interface TimerViewController ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) TestBlock *testBlock;

@property (nonatomic, copy) dispatch_block_t viewblock;
@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.016 repeats:YES block:^(NSTimer * _Nonnull timer) {
////            NSLog(@"hhhhh");
//        }];
////        self.timer = [NSTimer timerWithTimeInterval:0.016 repeats:YES block:^(NSTimer * _Nonnull timer) {
////            NSLog(@"hhhhh");
////        }];
//        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
////        [self.timer fire];
//        [[NSRunLoop currentRunLoop] run];
//    });
    
    
//    self.testBlock = [[TestBlock alloc] init];
//
//    NSLog(@"retaincount = %ld", (long)CFGetRetainCount((__bridge CFTypeRef)(self)));
//
//    self.viewblock = ^{
//        NSLog(@"retaincount = %ld", (long)CFGetRetainCount((__bridge CFTypeRef)(self)));
////        [self test];
//    };
//
//    self.viewblock();
    
    [self.navigationController pushViewController:[[ViewController alloc] init] animated:YES];
}

- (void)test {
    
}


@end
