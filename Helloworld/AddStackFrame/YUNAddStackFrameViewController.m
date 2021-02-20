//
//  YUNAddStackFrameViewController.m
//  Helloworld
//
//  Created by yuzhiyun on 2021/1/13.
//  Copyright © 2021 zhiyunyu. All rights reserved.
//

#import "YUNAddStackFrameViewController.h"
#import <Aspects.h>

@interface YUNAddStackFrameViewController ()

@end
@implementation YUNAddStackFrameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self aspect_hookSelector:@selector(kotlinFunction)
                  withOptions:AspectPositionInstead
                   usingBlock:^(id<AspectInfo> aspectInfo){
        [self newMethod:aspectInfo.originalInvocation];
    }
                        error:nil];
    
    [self lostFunction];
}

- (void)lostFunction {
    NSLog(@"我是被丢失的栈帧");
    [self kotlinFunction];
}

- (void)kotlinFunction {
    NSLog(@"我是kn函数");
}

- (void)newMethod:(NSInvocation *)originalInvocation {
    NSLog(@"我是插入的替死鬼函数");
    [originalInvocation invoke];
}

@end
