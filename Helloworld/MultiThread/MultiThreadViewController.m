//
//  MultiThreadViewController.m
//  Helloworld
//
//  Created by 俞志云 on 2018/6/16.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import "MultiThreadViewController.h"

@interface MultiThreadViewController ()

@end

@implementation MultiThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(20, 80, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(clickNSThread) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"NSThread" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(20, 120, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(clickGCD) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"GCD" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
}

- (void)clickNSThread {
    // NSThread的3种使用方法
    
    // 1.通过alloc init的方式
    //    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    //    [thread start];
    
    // 2.使用静态方法
    //    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
    
    // 3.使用NSObject(NSThreadPerformAdditions) 的分类创建
    [self performSelectorInBackground:@selector(run) withObject:nil];
}

// 子线程的任务
- (void)run {
    // 加锁方式一
//    @synchronized(self) {
    // 加锁方式二
    NSCondition *condition = [[NSCondition alloc] init];
    [condition lock]; //加锁
        for (int i = 0; i < 10; i++) {
            NSLog(@"%i",i);
            if (i == 9) {
                // performSelectorOnMainThread也是NSObject的一个分类哦
                [self performSelectorOnMainThread:@selector(runMainThread) withObject:nil waitUntilDone:YES];
            }
        }
    [condition unlock]; //解锁
//    }
}

- (void)runMainThread {
    NSLog(@"我是主线程");
}

- (void)clickGCD {
    [self runMainThread];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"执行子线程。。。");
        [NSThread sleepForTimeInterval:2];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self runMainThread];
        });
    });
}

@end
