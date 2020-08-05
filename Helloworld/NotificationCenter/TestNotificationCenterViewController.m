//
//  TestNotificationCenterViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2020/8/3.
//  Copyright © 2020 zhiyunyu. All rights reserved.
//

#import "TestNotificationCenterViewController.h"

#define testNotificationName @"testNotificationName"

@interface TestNotificationCenterViewController ()

@end

@implementation TestNotificationCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(click)]];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_receiveNotification)
                                                 name:testNotificationName
                                               object:nil];
    
}

- (void)click {
    NSLog(@"发送通知前");
    [[NSNotificationCenter defaultCenter] postNotificationName:testNotificationName object:nil];
    NSLog(@"发送通知后");
}

- (void)_receiveNotification {
    NSLog(@"收到通知");
}

@end
