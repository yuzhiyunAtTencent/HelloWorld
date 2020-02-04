//
//  YUNRunloopViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2019/7/22.
//  Copyright © 2019 zhiyunyu. All rights reserved.
//

#import "YUNRunloopViewController.h"
#import "RunloopMonitor.h"

@implementation YUNRunloopViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[RunloopMonitor shareInstance] beginMonitor];
}

@end
