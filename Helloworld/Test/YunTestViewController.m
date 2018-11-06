//
//  YunTestViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2018/11/6.
//  Copyright © 2018 zhiyunyu. All rights reserved.
//

#import "YunTestViewController.h"

@interface YunTestViewController ()

@end

@implementation YunTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(mainthreadOperation) withObject:nil afterDelay:1];
    
    [[NSOperationQueue new] addOperationWithBlock:^{
        [self performSelector:@selector(delayOperation) withObject:nil afterDelay:1];
        [self performSelector:@selector(operation) withObject:nil];
    }];
}

- (void)delayOperation {
    NSLog(@"delayOperation");
}

- (void)operation {
    NSLog(@"operation");
}

- (void)mainthreadOperation {
    NSLog(@"mainthreadOperation");
}

@end
